//
//  ECC_CartManagerTest.swift
//  EComCart
//
//  Created by mytsl01831 on 30/04/22.
//

import XCTest
@testable import EComCart

class ECC_CartManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCartProductAdd() throws{
        
        let dataService = ECC_DataServices()
        let products = dataService.getProductForStoreType(storeType: "")
        
        if let product = products?.first{
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)

            XCTAssertTrue(ECC_CartManager.shared.totalProductCount() == 1)
        }
        
        XCTAssertFalse(false)
    }
    
    func testCartProductRemove() throws{
        let dataService = ECC_DataServices()
        let products = dataService.getProductForStoreType(storeType: "")
        
        if let product = products?.first{
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)
            ECC_CartManager.shared.removeProduct(productNeedToRemove: product)

            XCTAssertTrue(ECC_CartManager.shared.totalProductCount() == 0)
        }
        
        XCTAssertFalse(false)
    }
    
    func testCartPriceValue() throws{
        let dataService = ECC_DataServices()
        let products = dataService.getProductForStoreType(storeType: "")
        
        if let product = products?.first{
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)
            
            XCTAssertTrue(ECC_CartManager.shared.totalCartPriceValue() == 28.1)
        }
        
        XCTAssertFalse(false)
    }
    
    func testCartProductCount() throws{
        
        let dataService = ECC_DataServices()
        let products = dataService.getProductForStoreType(storeType: "")
        
        if let product = products?.first{
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)

            XCTAssertTrue(ECC_CartManager.shared.totalProductCount() == 3)
        }
        
        XCTAssertFalse(false)
    }
    
    func testRemoveCartProduct() throws{
        
        let dataService = ECC_DataServices()
        let products = dataService.getProductForStoreType(storeType: "")
        
        if let product = products?.first{
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)
            ECC_CartManager.shared.addProduct(productNeedToAdd: product)

            ECC_CartManager.shared.clearCart()
            XCTAssertTrue(ECC_CartManager.shared.totalProductCount() == 0)
        }
        
        XCTAssertFalse(false)
    }
    
    func testOrderDetailDataPost() throws {
        
        let dataService = ECC_DataServices()
        let orderDetails = dataService.getOrderDoneDetails()
        
        if let orderDetails = orderDetails {
            ECC_CartManager.shared.postOrderDetailsToLocalDocumentFolder(orderDoneDetails: orderDetails) { success in
                if(success){
                    XCTAssertTrue(success)
                }else{
                    XCTAssertTrue(success)
                }
            }
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
