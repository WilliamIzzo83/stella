//
//  OFS_StellaTests.swift
//  OFS_StellaTests
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import XCTest
@testable import OFS_Stella

class OFS_ProvidersTests: XCTestCase {
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testReadyToWearProviderData() {
        let urlProvider = HTTPDataProvider<[ProductModel]>.productsDataProvider(department: Department.readyToWear)
        
        let readyToWearExpectation = expectation(description: "ready to wear product retrieval")
        urlProvider.retrieveData { (readyToWearItems, error) in
            XCTAssert(error == nil, error?.localizedDescription ?? "")
            readyToWearExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) {
            if let error = $0 {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
}
