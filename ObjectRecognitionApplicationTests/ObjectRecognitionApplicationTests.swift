import XCTest

@testable import ObjectRecognitionApplication

final class ObjectRecognitionApplicationTests: XCTestCase {
    
    var viewController: VisionObjectRecognitionViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = VisionObjectRecognitionViewController()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewController = nil
    }
    
    func testSetupVision() throws {
        let viewController = VisionObjectRecognitionViewController()
        let error = viewController.setupVision()
        XCTAssertNil(error, "Expected no error while setting up vision")
    }

    func testCreateTextSubLayerInBounds() throws {
        let viewController = VisionObjectRecognitionViewController()
        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        let textLayer = viewController.createTextSubLayerInBounds(bounds, identifier: "Test", confidence: 0.8)
        XCTAssertEqual(textLayer.bounds, bounds, "Expected text layer bounds to match input bounds")
        XCTAssertEqual(textLayer.string as? String, "Test (80%)", "Expected text layer string to include object identifier and confidence percentage")
    }
    
    func testSetupAVCapture() throws {
        viewController.setupAVCapture()
        XCTAssertNotNil(viewController.previewLayer, "Expected preview layer to be set up")
        XCTAssertEqual(viewController.rootLayer.sublayers?.count, 1, "Expected one sublayer in root layer")
        XCTAssertNotNil(viewController.session, "Expected session to be set up")
    }

    func testUpdateLayerGeometry() throws {
        viewController.setupAVCapture()
        let initialBounds = viewController.detectionOverlay.bounds
        viewController.previewView.bounds = CGRect(x: 0, y: 0, width: 200, height: 300)
        viewController.updateLayerGeometry()
        XCTAssertNotEqual(viewController.detectionOverlay.bounds, initialBounds, "Expected detection overlay bounds to change after updating geometry")
        XCTAssertEqual(viewController.detectionOverlay.position, CGPoint(x: 100, y: 150), "Expected detection overlay to be centered in preview view")
    }


}

