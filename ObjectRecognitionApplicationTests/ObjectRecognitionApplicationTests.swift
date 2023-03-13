import XCTest
import AVFAudio

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
        let bounds = CGRect(x: 0, y: 0, width: 90, height: 90)
        let textLayer = viewController.createTextSubLayerInBounds(bounds, identifier: "Test", confidence: 0.8)
        XCTAssertEqual(textLayer.bounds, bounds, "Expected text layer bounds to match input bounds")
//        XCTAssertEqual(textLayer.string as? String, "Test 0.8".lowercased(), "Expected text layer string to include object identifier and confidence percentage")
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
    
    func testFontManagerIncreaseFontSize() throws {
        let fontManager = FontManager.shared
        let initialFontSizeIndex = fontManager.currentFontSizeIndex
        let newFontSize = fontManager.increaseFontSize()
        XCTAssertEqual(fontManager.currentFontSizeIndex, (initialFontSizeIndex + 1) % fontManager.fontSizes.count, "Expected font size index to increase by 1 modulo the number of available font sizes")
        XCTAssertEqual(newFontSize, fontManager.fontSizes[fontManager.currentFontSizeIndex], "Expected new font size to match updated font size index")
    }


}


class ChooseItemsViewControllerTests: XCTestCase {

    var viewController: ChooseItemsViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = ChooseItemsViewController()
    }

    func testBackButtonTapped() throws {
        let window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        let backButton = viewController.view.subviews.first(where: { $0 is UIButton }) as! UIButton
        backButton.sendActions(for: .touchUpInside)

        XCTAssertNil(viewController.presentingViewController, "Expected presenting view controller to be nil after dismissal")
    }

    func testViewBackgroundColor() throws {
        let backgroundColor = viewController.view.backgroundColor
        XCTAssertEqual(backgroundColor, .white, "Expected background color to be white")
    }

    func testBackButtonTitleColor() throws {
        let backButton = viewController.view.subviews.first(where: { $0 is UIButton }) as! UIButton
        let titleColor = backButton.titleColor(for: .normal)
        XCTAssertEqual(titleColor, .white, "Expected title color to be white")
    }

    // Additional tests for other UI elements and layout constraints could be added here
}

class InformationViewControllerTests: XCTestCase {
    
    var viewController: InformationViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = InformationViewController()
    }
    
    func testBackButtonTapped() throws {
        let window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        let backButton = viewController.view.subviews.first(where: { $0 is UIButton }) as! UIButton
        backButton.sendActions(for: .touchUpInside)
        
        XCTAssertNil(viewController.presentingViewController, "Expected presenting view controller to be nil after dismissal")
    }
    
    func testViewBackgroundColor() throws {
        let backgroundColor = viewController.view.backgroundColor
        XCTAssertEqual(backgroundColor, .white, "Expected background color to be white")
    }
    
    func testTitleLabelFont() throws {
        let titleLabel = viewController.view.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).text == "App Information" }) as! UILabel
        let font = titleLabel.font
        XCTAssertEqual(font, UIFont.boldSystemFont(ofSize: 28), "Expected title label font to be bold system font of size 28")
    }
    
    // Additional tests for other UI elements and layout constraints could be added here
    class OptionsViewControllerTests: XCTestCase {
        
        var optionsViewController: ChooseItemsViewController!
        
        override func setUp() {
            super.setUp()
            optionsViewController = ChooseItemsViewController()
            _ = optionsViewController.view // Load view hierarchy
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
    
    class SynthesizerTests: XCTestCase {
        
        var synthesizer: AVSpeechSynthesizer!
        let text = "Hello, World!"
        
        override func setUpWithError() throws {
            try super.setUpWithError()
            synthesizer = AVSpeechSynthesizer()
        }
        
        func testSpeak() throws {
            let expectation = self.expectation(description: "Speech synthesis")
            let utterance = AVSpeechUtterance(string: text)
            synthesizer.speak(utterance)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                expectation.fulfill()
            }
            waitForExpectations(timeout: 3, handler: nil)
            XCTAssertTrue(synthesizer.isSpeaking, "Expected speech synthesis to be in progress")
        }
        
        func testStopSpeaking() throws {
            let expectation = self.expectation(description: "Speech synthesis")
            let utterance = AVSpeechUtterance(string: text)
            synthesizer.speak(utterance)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.synthesizer.stopSpeaking(at: .immediate)
                expectation.fulfill()
            }
            waitForExpectations(timeout: 3, handler: nil)
            XCTAssertFalse(synthesizer.isSpeaking, "Expected speech synthesis to be stopped")
        }
        
    }
    
    class FontManagerTests: XCTestCase {
        
        var fontManager: FontManager!
        
        override func setUpWithError() throws {
            try super.setUpWithError()
            fontManager = FontManager.shared
        }
        
        override func tearDownWithError() throws {
            try super.tearDownWithError()
            fontManager = nil
        }
        
        func testFontManagerIncreaseFontSize() throws {
            let initialIndex = fontManager.currentFontSizeIndex
            let initialFontSize = fontManager.getFontSize()
            let newFontSize = fontManager.increaseFontSize()
            let expectedIndex = (initialIndex + 1) % fontManager.fontSizes.count
            let expectedFontSize = fontManager.fontSizes[expectedIndex]
            XCTAssertEqual(newFontSize, expectedFontSize, "Expected increased font size to match expected font size")
            XCTAssertEqual(fontManager.currentFontSizeIndex, expectedIndex, "Expected font size index to be updated after increasing font size")
            XCTAssertEqual(initialFontSize, fontManager.getFontSize(), "Expected getFontSize() to return current font size")
        }
        
    }
}
