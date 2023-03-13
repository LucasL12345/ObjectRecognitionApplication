import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    @IBOutlet weak internal var previewView: UIView!
    internal let session = AVCaptureSession()
    internal var previewLayer: AVCaptureVideoPreviewLayer! = nil
    internal let videoDataOutput = AVCaptureVideoDataOutput()
    internal let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // to be implemented in the subclass
    }
    
    
    let findObjectButton: UIButton = {
            let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.backgroundColor = button.backgroundColor?.withAlphaComponent(0.75)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Finding all objects", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(VisionObjectRecognitionViewController.findingObjectsButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    let optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.backgroundColor = button.backgroundColor?.withAlphaComponent(0.75)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Choose items", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.addTarget(self, action: #selector(ViewController.showOptions), for: .touchUpInside)

        return button
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.backgroundColor = button.backgroundColor?.withAlphaComponent(0.75)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("App Info", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(ViewController.showSettings), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAVCapture()
        
        view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionButton)
        optionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(findObjectButton)
        findObjectButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            settingsButton.heightAnchor.constraint(equalToConstant: 90),

            optionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            optionButton.leadingAnchor.constraint(equalTo: settingsButton.trailingAnchor, constant: 10),
            optionButton.heightAnchor.constraint(equalToConstant: 90),
            optionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            findObjectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            findObjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            findObjectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            findObjectButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])

    }
    
    @objc func showOptions() {
        let optionsVC = OptionsViewController()
        present(optionsVC, animated: true, completion: nil)
    }
    
    @objc func showSettings() {
        let settingsVC = SettingsViewController()
        present(settingsVC, animated: true, completion: nil)
    }
    
    func setupAVCapture() {
        var deviceInput: AVCaptureDeviceInput!
        
        // Select a video device, make an input
        let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
        } catch {
            print("Could not create video device input: \(error)")
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .vga640x480
        
        // Add video input
        guard session.canAddInput(deviceInput) else {
            print("Couldn't add video device input to the session")
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput)
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            // Add a video data output
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            print("Couldn't add video data output to the session")
            session.commitConfiguration()
            return
        }
        let captureConnection = videoDataOutput.connection(with: .video)
        // process frames
        captureConnection?.isEnabled = true
        do {
            try  videoDevice!.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice?.activeFormat.formatDescription)!)
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            videoDevice!.unlockForConfiguration()
        } catch {
            print(error)
        }
        session.commitConfiguration()
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        rootLayer = previewView.layer
        previewLayer.frame = rootLayer.bounds
        rootLayer.addSublayer(previewLayer)
    }
    
    func startCaptureSession() {
        session.startRunning()
    }

    
    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop didDropSampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // print("frame dropped")
    }
    
    
}
