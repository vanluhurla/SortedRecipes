//
//  SRNetworkManagerTests.swift
//  SRNetworkManagerTests
//
//  Created by Vanessa Hurla on 04/09/2024.
//

import XCTest
@testable import SortedRecipes

final class GCNetworkManagerTests: XCTestCase {
    
    var sut: GCNetworkManager!
    
    override func setUpWithError() throws {
       
        sut = GCNetworkManager(urlSession: URLSession.shared, urlString: SRNetworkUrl.recipeList)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetRecipeList_WhenDataIsReceived_ReturnsRecipes() {
        // Arrange
        let expectation = self.expectation(description: "Fetching recipes from the API")
        
        // Act
        sut.getRecipeList { recipes, error in
            // Assert
            XCTAssertNotNil(recipes, "Expected recipes but received nil.")
            XCTAssertNil(error, "Expected no error but received: \(String(describing: error))")
            XCTAssertFalse(recipes?.isEmpty ?? true, "Expected recipes list to not be empty.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 10)
    }
}
