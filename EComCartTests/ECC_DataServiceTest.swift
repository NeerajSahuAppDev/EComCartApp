//
//  ECC_DataServiceTest.swift
//  EComCartTests
//
//  Created by mytsl01831 on 30/04/22.
//

import XCTest
@testable import EComCart

class ECC_DataServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testOrderDetails() throws{
        
        let dataService = ECC_DataServices()
        let orderDetails = dataService.getOrderDoneDetails()

        if let orderDataProducts = orderDetails?.orderData{
            XCTAssertTrue(orderDataProducts.count == 2)
        }

        XCTAssertFalse(false)
    }
    
    func testProducts() throws{
        
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testStoreDataTest() throws{
        // This is an example of a performance test case.
        let dataService = ECC_DataServices()
        let stores = dataService.getStore()

        if let stores = stores{
            XCTAssertTrue(stores.count > 0)
        }

        XCTAssertFalse(false)
    }
    
    func testProductDataTest() throws {
        // This is an example of a performance test case.
        let dataService = ECC_DataServices()
        let products = dataService.getProductForStoreType(storeType: "")

        if let product = products?.first{
            XCTAssertEqual(product.type, "dairy")
        }
    }

}
