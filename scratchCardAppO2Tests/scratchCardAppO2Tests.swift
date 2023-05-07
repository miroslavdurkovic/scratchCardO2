//
//  scratchCardAppO2Tests.swift
//  scratchCardAppO2Tests
//
//  Created by Miroslav Durkovic on 07/05/2023.
//

import XCTest
@testable import scratchCardAppO2

final class scretchCardO2Tests: XCTestCase {
  var scratchCardManager: ScratchCardManager = ScratchCardManager()
  
  func testScatchCardHaveDefaultState() {
    XCTAssertEqual(scratchCardManager.scratchCard.status, .new, "Newly created scatch card haven't default status new")
    XCTAssertNotEqual(scratchCardManager.scratchCard.status, .wiped, "Newly created scatch card can't have wiped status")
    XCTAssertNotEqual(scratchCardManager.scratchCard.status, .active, "Newly created scatch card can't have active status")
  }
  
  func testCodeIsGeneratedCard() {
    scratchCardManager.wipeOff()
    XCTAssertNotEqual(scratchCardManager.scratchCard.code, "", "Code wasn't generated and is empty string")
  }
  
  func testWipeOffCard() {
    XCTAssertEqual(scratchCardManager.scratchCard.status, .new, "Status is not ready for wipe, must be in new state")
    scratchCardManager.wipeOff()
    XCTAssertEqual(scratchCardManager.scratchCard.status, .wiped, "After user wipe scratch status muset be wiped")
  }
  
  func testNotAllowedWipeOffCard() {
    XCTAssertEqual(scratchCardManager.scratchCard.status, .new, "Status is not ready for wipe, must be in new state")
    scratchCardManager.scratchCard.status = .active
    XCTAssertEqual(scratchCardManager.scratchCard.status, .active, "Status is not active so wipe off will proced")
    scratchCardManager.wipeOff()
    XCTAssertNotEqual(scratchCardManager.scratchCard.status, .wiped, "If status is active, wipe is not permitted")
  }
  
  func testActivateCardOnBackend() throws {
    let expectation = self.expectation(description: "Activating")
    
    scratchCardManager.wipeOff()
    scratchCardManager.activateCard { status in
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertEqual(scratchCardManager.scratchCard.status, .active, "Status was not changed to activated")
  }
}
