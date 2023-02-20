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


}





class OptionsViewControllerTests: XCTestCase {

    var viewController: OptionsViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = OptionsViewController()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewController = nil
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

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewController = nil
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
}

