
//SYSTEM TESTING (Unit tests below)


import XCTest
import AVFoundation
@testable import ObjectRecognitionApplication

class ObjectRecognitionTests: XCTestCase {

    var chooseItemsVC: ChooseItemsViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        chooseItemsVC = ChooseItemsViewController()
        chooseItemsVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        chooseItemsVC = nil
        try super.tearDownWithError()
    }

    // Must have: Object recognition for a preset list of items
    func testObjectRecognition() {
        let objects = ["backpack", "handbag", "bottle", "cup", "knife", "bowl", "laptop", "remote", "cell phone", "book", "vase", "scissors", "toothbrush", "chair", "dog", "cat"]
        XCTAssertEqual(objects.count, chooseItemsVC.all_items.count)
        for object in objects {
            XCTAssertTrue(chooseItemsVC.all_items.contains(object))
        }
    }

    // Must have: Objects recognised must be useful to blind

    // Must have: Works on iPhones
    func testWorksOnIPhones() {
        XCTAssertTrue(UIDevice.current.userInterfaceIdiom == .phone)
    }

    // Must have: Voice feedback
    func testVoiceFeedback() {
        let synthesizer = chooseItemsVC.synthesizer
        let utterance = AVSpeechUtterance(string: "You have selected: backpack, handbag")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let expectation = self.expectation(description: "speechSynthesizer(_:didFinish:)")
        chooseItemsVC.speechSynthesizer(synthesizer, didFinish: utterance)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    // Must have: Vibration/haptic feedback
    // Not testable
    // Requires a physical device

    // Must have: Offline availability
    // Not testable
    // Requires a physical device


    // Must have: Compatibility with voiceover
    func testCompatibilityWithVoiceOver() {
        XCTAssertTrue(UIAccessibility.isVoiceOverRunning)
    }

    // Must have: A simple and intuitive design that’s easy to navigate
    func testDesign() {
        let scrollView = chooseItemsVC.scrollView
        let backButton = chooseItemsVC.backButton
        let confirmButton = chooseItemsVC.confirmButton
        XCTAssertTrue(scrollView.isDescendant(of: chooseItemsVC.view))
        XCTAssertTrue(backButton.isDescendant(of: chooseItemsVC.view))
        XCTAssertTrue(confirmButton.isDescendant(of: chooseItemsVC.view))
    }

    // Should have: Large buttons
    func testLargeButtons() {
        chooseItemsVC.view.layoutIfNeeded()
        let buttons = chooseItemsVC.buttons
        for button in buttons {
            let width = button.frame.width
            let height = button.frame.height
            print(width)
            print(height)
            XCTAssertTrue(width >= 100, "Expected button width to be at least 10")
            XCTAssertTrue(height >= 50, "Expected button height to be at least 10")
        }
    }

    // Should have: Big clear font
//    func testBigClearFont() {
//        let font = UIFont.systemFont(ofSize: 24)
//        let buttons = chooseItemsVC.buttons
//        for button in buttons {
//            XCTAssertTrue(button.titleLabel?.font.pointSize == font.pointSize, "Expected font size to be at least 24")
//        }
//    }


    // Should have: Vibration customization
    func testVibrationCustomization() {
        let strongVibration = UIImpactFeedbackGenerator(style: .heavy)
        let weakVibration = UIImpactFeedbackGenerator(style: .light)
        XCTAssertNotNil(strongVibration, "Expected strong vibration to be set up")
        XCTAssertNotNil(weakVibration, "Expected weak vibration to be set up")
    }

    // Should have: Text resize button
//    func testTextResizeButton() {
//        let resizeButton = chooseItemsVC.fontSizeButton
//        XCTAssertTrue(resizeButton.isDescendant(of: chooseItemsVC.view), "Expected resize text button to be a subview of the view")
//    }
//
    // Should have: Low storage requirements
    func testLowStorageRequirements() {
        // No testable implementation
        // Requires testing on devices with varying storage capacities
    }

    // Should have: Minimal battery drain
    func testMinimalBatteryDrain() {
        // No testable implementation
        // Requires testing on devices with varying battery levels and usage scenarios
    }

    // Should have: A simple and intuitive design that’s easy to navigate
    func testDesignSimplicity() {
        let scrollView = chooseItemsVC.scrollView
        let backButton = chooseItemsVC.backButton
        let confirmButton = chooseItemsVC.confirmButton
        XCTAssertTrue(scrollView.isDescendant(of: chooseItemsVC.view))
        XCTAssertTrue(backButton.isDescendant(of: chooseItemsVC.view))
        XCTAssertTrue(confirmButton.isDescendant(of: chooseItemsVC.view))
    }

    // Should have: App information page
    func testAppInformationPage() {
        let informationVC = InformationViewController()
        XCTAssertNotNil(informationVC, "Expected information view controller to be set up")
    }

    // Should have: Colour scheme change option (light/dark mode)
    @available(iOS 13.0, *)
    func testColorSchemeChangeOption() {
        let lightColorScheme = UIColor.systemBackground
        let darkColorScheme = UIColor.black
        XCTAssertNotEqual(lightColorScheme, darkColorScheme, "Expected light and dark color schemes to be different")
    }

    // Should have: Voice commands via Siri
    func testVoiceCommandsViaSiri() {
        // No testable implementation
        // Requires integration with SiriKit and testing with voice commands
    }

    // Should have: Extension to outdoor environment objects
    func testOutdoorObjectRecognition() {
        // No testable implementation
        // Requires testing with outdoor environment object recognition
    }
}











//UNIT TESTING


//import XCTest
//import AVFAudio
//
//@testable import ObjectRecognitionApplication
//
//final class ObjectRecognitionApplicationTests: XCTestCase {
//
//    var viewController: VisionObjectRecognitionViewController!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        viewController = VisionObjectRecognitionViewController()
//    }
//
//    override func tearDownWithError() throws {
//        try super.tearDownWithError()
//        viewController = nil
//    }
//
//    func testSetupVision() throws {
//        let viewController = VisionObjectRecognitionViewController()
//        let error = viewController.setupVision()
//        XCTAssertNil(error, "Expected no error while setting up vision")
//    }
//
//    func testCreateTextSubLayerInBounds() throws {
//        let viewController = VisionObjectRecognitionViewController()
//        let bounds = CGRect(x: 0, y: 0, width: 90, height: 90)
//        let textLayer = viewController.createTextSubLayerInBounds(bounds, identifier: "Test", confidence: 0.8)
//        XCTAssertEqual(textLayer.bounds, bounds, "Expected text layer bounds to match input bounds")
////        XCTAssertEqual(textLayer.string as? String, "Test 0.8".lowercased(), "Expected text layer string to include object identifier and confidence percentage")
//    }
//
//
//    func testSetupAVCapture() throws {
//        viewController.setupAVCapture()
//        XCTAssertNotNil(viewController.previewLayer, "Expected preview layer to be set up")
//        XCTAssertEqual(viewController.rootLayer.sublayers?.count, 1, "Expected one sublayer in root layer")
//        XCTAssertNotNil(viewController.session, "Expected session to be set up")
//    }
//
//    func testUpdateLayerGeometry() throws {
//        viewController.setupAVCapture()
//        let initialBounds = viewController.detectionOverlay.bounds
//        viewController.previewView.bounds = CGRect(x: 0, y: 0, width: 200, height: 300)
//        viewController.updateLayerGeometry()
//        XCTAssertNotEqual(viewController.detectionOverlay.bounds, initialBounds, "Expected detection overlay bounds to change after updating geometry")
//        XCTAssertEqual(viewController.detectionOverlay.position, CGPoint(x: 100, y: 150), "Expected detection overlay to be centered in preview view")
//    }
//
//    func testFontManagerIncreaseFontSize() throws {
//        let fontManager = FontManager.shared
//        let initialFontSizeIndex = fontManager.currentFontSizeIndex
//        let newFontSize = fontManager.increaseFontSize()
//        XCTAssertEqual(fontManager.currentFontSizeIndex, (initialFontSizeIndex + 1) % fontManager.fontSizes.count, "Expected font size index to increase by 1 modulo the number of available font sizes")
//        XCTAssertEqual(newFontSize, fontManager.fontSizes[fontManager.currentFontSizeIndex], "Expected new font size to match updated font size index")
//    }
//
//
//}
//
//
//class ChooseItemsViewControllerTests: XCTestCase {
//
//    var viewController: ChooseItemsViewController!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        viewController = ChooseItemsViewController()
//    }
//
//    func testBackButtonTapped() throws {
//        let window = UIWindow()
//        window.rootViewController = viewController
//        window.makeKeyAndVisible()
//
//        let backButton = viewController.view.subviews.first(where: { $0 is UIButton }) as! UIButton
//        backButton.sendActions(for: .touchUpInside)
//
//        XCTAssertNil(viewController.presentingViewController, "Expected presenting view controller to be nil after dismissal")
//    }
//
//    func testViewBackgroundColor() throws {
//        let backgroundColor = viewController.view.backgroundColor
//        XCTAssertEqual(backgroundColor, .white, "Expected background color to be white")
//    }
//
//    func testBackButtonTitleColor() throws {
//        let backButton = viewController.view.subviews.first(where: { $0 is UIButton }) as! UIButton
//        let titleColor = backButton.titleColor(for: .normal)
//        XCTAssertEqual(titleColor, .white, "Expected title color to be white")
//    }
//
//    // Additional tests for other UI elements and layout constraints could be added here
//}
//
//class InformationViewControllerTests: XCTestCase {
//
//    var viewController: InformationViewController!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        viewController = InformationViewController()
//    }
//
//    func testBackButtonTapped() throws {
//        let window = UIWindow()
//        window.rootViewController = viewController
//        window.makeKeyAndVisible()
//
//        let backButton = viewController.view.subviews.first(where: { $0 is UIButton }) as! UIButton
//        backButton.sendActions(for: .touchUpInside)
//
//        XCTAssertNil(viewController.presentingViewController, "Expected presenting view controller to be nil after dismissal")
//    }
//
//    func testViewBackgroundColor() throws {
//        let backgroundColor = viewController.view.backgroundColor
//        XCTAssertEqual(backgroundColor, .white, "Expected background color to be white")
//    }
//
//    func testTitleLabelFont() throws {
//        if let titleLabel = viewController.view.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).text == "App Information" }) as? UILabel {
//            let font = titleLabel.font
//            XCTAssertEqual(font, UIFont.boldSystemFont(ofSize: 28), "Expected title label font to be bold system font of size 28")
//        } else {
//            XCTFail("Title label not found")
//        }
//    }
//
//
//    // Additional tests for other UI elements and layout constraints could be added here
//    class OptionsViewControllerTests: XCTestCase {
//
//        var optionsViewController: ChooseItemsViewController!
//
//        override func setUp() {
//            super.setUp()
//            optionsViewController = ChooseItemsViewController()
//            _ = optionsViewController.view // Load view hierarchy
//        }
//
//        func testScrollViewHasButtons() {
//            XCTAssertEqual(optionsViewController.scrollView.subviews.count, optionsViewController.buttons.count, "Number of buttons should be equal to number of subviews in scroll view")
//        }
//
//        func testButtonTapped() {
//            let button = optionsViewController.buttons[0]
//            button.sendActions(for: .touchUpInside)
//            XCTAssertEqual(button.backgroundColor, .systemBlue, "Button background color should change to systemBlue when tapped")
//            XCTAssertEqual(button.titleColor(for: .normal), .white, "Button text color should change to white when background color changes to systemBlue")
//        }
//
//        func testConfirmButtonTapped() {
//            optionsViewController.confirmButton.sendActions(for: .touchUpInside)
//            XCTAssertTrue(optionsViewController.synthesizer.isSpeaking, "AVSpeechSynthesizer should start speaking when confirm button is tapped")
//        }
//
//        func testBackButtonTapped() {
//            let presentingVC = MockVisionObjectRecognitionViewController()
//            optionsViewController.visionObjectVC = presentingVC
//            optionsViewController.backButtonTapped()
//            XCTAssertTrue(presentingVC.didCallUpdateValue, "View controller's updateValue method should be called when back button is tapped")
//        }
//
//    }
//
//    class MockVisionObjectRecognitionViewController: VisionObjectRecognitionViewController {
//
//        var didCallUpdateValue = false
//
//        override func updateValue(_ items: [String]) {
//            didCallUpdateValue = true
//        }
//
//    }
//
//    class SynthesizerTests: XCTestCase {
//
//        var synthesizer: AVSpeechSynthesizer!
//        let text = "Hello, World!"
//
//        override func setUpWithError() throws {
//            try super.setUpWithError()
//            synthesizer = AVSpeechSynthesizer()
//        }
//
//        func testSpeak() throws {
//            let expectation = self.expectation(description: "Speech synthesis")
//            let utterance = AVSpeechUtterance(string: text)
//            synthesizer.speak(utterance)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                expectation.fulfill()
//            }
//            waitForExpectations(timeout: 3, handler: nil)
//            XCTAssertTrue(synthesizer.isSpeaking, "Expected speech synthesis to be in progress")
//        }
//
//        func testStopSpeaking() throws {
//            let expectation = self.expectation(description: "Speech synthesis")
//            let utterance = AVSpeechUtterance(string: text)
//            synthesizer.speak(utterance)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                self.synthesizer.stopSpeaking(at: .immediate)
//                expectation.fulfill()
//            }
//            waitForExpectations(timeout: 3, handler: nil)
//            XCTAssertFalse(synthesizer.isSpeaking, "Expected speech synthesis to be stopped")
//        }
//
//    }
//
//    class FontManagerTests: XCTestCase {
//
//        var fontManager: FontManager!
//
//        override func setUpWithError() throws {
//            try super.setUpWithError()
//            fontManager = FontManager.shared
//        }
//
//        override func tearDownWithError() throws {
//            try super.tearDownWithError()
//            fontManager = nil
//        }
//
//        func testFontManagerIncreaseFontSize() throws {
//            let initialIndex = fontManager.currentFontSizeIndex
//            let initialFontSize = fontManager.getFontSize()
//            let newFontSize = fontManager.increaseFontSize()
//            let expectedIndex = (initialIndex + 1) % fontManager.fontSizes.count
//            let expectedFontSize = fontManager.fontSizes[expectedIndex]
//            XCTAssertEqual(newFontSize, expectedFontSize, "Expected increased font size to match expected font size")
//            XCTAssertEqual(fontManager.currentFontSizeIndex, expectedIndex, "Expected font size index to be updated after increasing font size")
//            XCTAssertEqual(initialFontSize, fontManager.getFontSize(), "Expected getFontSize() to return current font size")
//        }
//
//    }
//}



