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

class OptionsViewControllerTests: XCTestCase {
    
    var optionsViewController: OptionsViewController!
    
    override func setUp() {
        super.setUp()
        optionsViewController = OptionsViewController()
        _ = optionsViewController.view // Load view hierarchy
    }
    
    override func tearDown() {
        optionsViewController = nil
        super.tearDown()
    }
    
    func testScrollViewHasButtons() {
        XCTAssertEqual(optionsViewController.scrollView.subviews.count, optionsViewController.buttons.count, "Number of buttons should be equal to number of subviews in scroll view")
    }
    
    func testButtonTapped() {
        let button = optionsViewController.buttons[0]
        button.sendActions(for: .touchUpInside)
        XCTAssertEqual(button.backgroundColor, .systemBlue, "Button background color should change to systemBlue when tapped")
        XCTAssertEqual(button.titleColor(for: .normal), .white, "Button text color should change to white when background color changes to systemBlue")
    }
    
    func testConfirmButtonTapped() {
        optionsViewController.confirmButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(optionsViewController.synthesizer.isSpeaking, "AVSpeechSynthesizer should start speaking when confirm button is tapped")
    }
    
    func testFontSizeButtonTapped() {
        let originalFontSizeIndex = optionsViewController.currentFontSizeIndex
        optionsViewController.fontSizeButtonTapped()
        XCTAssertNotEqual(optionsViewController.currentFontSizeIndex, originalFontSizeIndex, "Current font size index should change when font size button is tapped")
        XCTAssertNotEqual(optionsViewController.titleLabel.font.pointSize, UIFont.boldSystemFont(ofSize: optionsViewController.fontSizes[originalFontSizeIndex] + 5).pointSize, "Title label font size should change when font size button is tapped")
        XCTAssertNotEqual(optionsViewController.backButton.titleLabel?.font.pointSize, UIFont.systemFont(ofSize: optionsViewController.fontSizes[originalFontSizeIndex]).pointSize, "Back button font size should change when font size button is tapped")
        XCTAssertNotEqual(optionsViewController.confirmButton.titleLabel?.font.pointSize, UIFont.boldSystemFont(ofSize: optionsViewController.fontSizes[originalFontSizeIndex] + 5).pointSize, "Confirm button font size should change when font size button is tapped")
    }
    
    func testBackButtonTapped() {
        let presentingVC = MockVisionObjectRecognitionViewController()
        optionsViewController.visionObjectVC = presentingVC
        optionsViewController.backButtonTapped()
        XCTAssertTrue(presentingVC.didCallUpdateValue, "View controller's updateValue method should be called when back button is tapped")
    }
    
}

class MockVisionObjectRecognitionViewController: VisionObjectRecognitionViewController {
    
    var didCallUpdateValue = false
    
    override func updateValue(_ items: [String]) {
        didCallUpdateValue = true
    }
    
}

