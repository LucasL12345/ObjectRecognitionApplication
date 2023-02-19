//
//  ObjectRecognitionApplicationTests.swift
//  ObjectRecognitionApplicationTests
//
//  Created by Lucas Lemoine on 19/02/2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import XCTest

@testable import ObjectRecognitionApplication

final class ObjectRecognitionApplicationTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {

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

}

