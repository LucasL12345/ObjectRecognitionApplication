import UIKit
import AVFoundation
import Vision

class VisionObjectRecognitionViewController: ViewController {
    
    internal var detectionOverlay: CALayer! = nil
    // Vision parts
    internal var requests = [VNRequest]()
    
    var settingsVC: OptionsViewController!

    var all_items = ["backpack", "handbag", "bottle", "cup", "knife", "bowl", "laptop", "remote", "cell phone", "book", "vase", "scissors", "toothbrush", "chair", "dog", "cat"]
    static var selected_items:[String] = ["all"]
    
    static var all_obj_vibration_mode: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "all_obj_vibration_mode")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "all_obj_vibration_mode")
        }
    }
    
    static var selected_obj_vibration_mode: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "selected_obj_vibration_mode")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selected_obj_vibration_mode")
        }
    }
    
    @discardableResult
    func setupVision() -> NSError? {
        // Setup Vision parts
        let error: NSError! = nil
        
        guard let modelURL = Bundle.main.url(forResource: "(TODO: Model)", withExtension: "mlmodelc") else {
            return NSError(domain: "VisionObjectRecognitionViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
        }
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
            let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
                DispatchQueue.main.async(execute: {
                    // perform all the UI updates on the main queue
                    if let results = request.results {
                        self.drawVisionRequestResults(results)
                    }
                })
            })
            self.requests = [objectRecognition]
        } catch let error as NSError {
            print("Model loading went wrong: \(error)")
        }
        
        return error
    }
    
    
    func drawVisionRequestResults(_ results: [Any]) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        detectionOverlay.sublayers = nil // remove old recognized objects
        
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                continue
            }
            // select the label with the highest confidence
            let topLabelObservation = objectObservation.labels[0]
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
            
            
            let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds)
            
            let textLayer = self.createTextSubLayerInBounds(objectBounds,
                                                            identifier: topLabelObservation.identifier,
                                                            confidence: topLabelObservation.confidence)
            
            shapeLayer.addSublayer(textLayer)
            detectionOverlay.addSublayer(shapeLayer)
            
            if findObjectButton.currentTitle == "Finding selected objects" {
                for object in VisionObjectRecognitionViewController.selected_items {
                    if topLabelObservation.identifier == object {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    }
                }
            } else {
                for object in all_items {
                    if topLabelObservation.identifier == object {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    }
                }
            }
        }
        self.updateLayerGeometry()
        CATransaction.commit()
    }
    
    
    override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    
    override func setupAVCapture() {
        super.setupAVCapture()
        setupLayers()
        updateLayerGeometry()
        setupVision()
        startCaptureSession()
    }
    
    
    func setupLayers() {
        detectionOverlay = CALayer() // container layer that has all the renderings of the observations
        detectionOverlay.name = "DetectionOverlay"
        detectionOverlay.bounds = CGRect(x: 0.0,
                                         y: 0.0,
                                         width: bufferSize.width,
                                         height: bufferSize.height)
        detectionOverlay.position = CGPoint(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
        rootLayer.addSublayer(detectionOverlay)
     }
     
    
     func updateLayerGeometry() {
         let bounds = rootLayer.bounds
         var scale: CGFloat
         
         let xScale: CGFloat = bounds.size.width / bufferSize.height
         let yScale: CGFloat = bounds.size.height / bufferSize.width
         
         scale = fmax(xScale, yScale)
         if scale.isInfinite {
             scale = 1.0
         }
         CATransaction.begin()
         CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
         
         // rotate layer into screen orientation, scale, and mirror
         detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: scale, y: -scale))
         // center layer
         detectionOverlay.position = CGPoint(x: bounds.midX, y: bounds.midY)
         
         CATransaction.commit()
     }
     
    
    func createTextSubLayerInBounds(_ bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.name = "Object Label"
        let confidenceValue = Float(confidence)
        let formattedString = NSMutableAttributedString(string: String(format: "\(identifier) (%.0f%%)", confidenceValue * 100))
        let largeFont = UIFont(name: "Helvetica", size: 24.0)!
        formattedString.addAttributes([NSAttributedString.Key.font: largeFont], range: NSRange(location: 0, length: identifier.count))
        textLayer.string = formattedString
        
        textLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.height, height: bounds.size.width)
        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        textLayer.shadowOpacity = 0.5
        textLayer.shadowOffset = CGSize(width: 2, height: 2)
        textLayer.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        textLayer.contentsScale = 2.0 // retina rendering
        
        // rotate the layer into screen orientation and scale and mirror
        textLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: 1.0, y: -1.0))
        return textLayer
    }


    func createRoundedRectLayerWithBounds(_ bounds: CGRect) -> CALayer {
        let shapeLayer = CALayer()
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        shapeLayer.name = "Found Object"
        shapeLayer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.2])
        shapeLayer.cornerRadius = 7
        return shapeLayer
    }

    
    @IBAction func button2(_ sender: Any) {
        if findObjectButton.currentTitle == "Finding selected objects" {
            findObjectButton.setTitle("Finding all objects", for: .normal)
        } else {
            findObjectButton.setTitle("Finding selected objects", for: .normal)
        }
        print(VisionObjectRecognitionViewController.all_obj_vibration_mode)
        print(VisionObjectRecognitionViewController.selected_obj_vibration_mode)
    }
    
    func updateValue(_ value: [String]) {
        VisionObjectRecognitionViewController.selected_items = value
    }
    
    func updateAllObjectVibrationMode(_ value: Bool) {
        VisionObjectRecognitionViewController.all_obj_vibration_mode = value
        UserDefaults.standard.set(value, forKey: "all_obj_vibration_mode")
    }

    func updateSelectedObjectVibrationMode(_ value: Bool) {
        VisionObjectRecognitionViewController.selected_obj_vibration_mode = value
        UserDefaults.standard.set(value, forKey: "selected_obj_vibration_mode")
    }
    
}
    


