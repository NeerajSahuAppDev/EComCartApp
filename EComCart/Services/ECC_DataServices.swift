//
//  ECC_DataServices.swift
//  EComCart
//
//  Created by mytsl01831 on 28/04/22.
//

import Foundation

class ECC_DataServices{
   
    //Reading JSON file and returnin the store
    func getStore()->[ECC_StoreInfoModel]?{
        
        if let url = Bundle.main.url(forResource: "StoreInfo", withExtension: "json") {
          do {
              let data = try Data(contentsOf: url)
              let jsonDecoder = JSONDecoder()
              var responseModel = try jsonDecoder.decode([ECC_StoreInfoModel].self, from: data)
        
              var storeModelFirst = responseModel.first
              storeModelFirst?.isSelected = true
              responseModel[0] = storeModelFirst ?? responseModel.first!
              return responseModel
              
          } catch {
              print("Error!! Unable to parse StoreInfo.json")
          }
        }
        return nil
    }
    
    //Reading JSON file and returnin the products
    func getProductForStoreType(storeType:String) -> [ECC_ProductsModel]?{
        if let url = Bundle.main.url(forResource: "Products", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([ECC_ProductsModel].self, from: data)
                return responseModel
                
            } catch {
                print("Error!! Unable to parse Products.json")
            }
      }
            return nil
    }
    
    
    func getOrderDoneDetails()-> ECC_OrderDoneModel?{
        
        if let url = Bundle.main.url(forResource: "OrderDone", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(ECC_OrderDoneModel.self, from: data)
                return responseModel
                
            } catch {
                print("Error!! Unable to parse Products.json")
            }
      }
        return nil
    }
    
    // Create the Json file and save locally in document folder
    func createAndSaveLocalJSONFileFromJSONString(jsonStringOrderDetails : String, completion: (Bool) -> ()){
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("OrderDone.json")
            do {
                try jsonStringOrderDetails.write(to: pathWithFilename,
                                     atomically: true,
                                     encoding: .utf8)
                
                completion(true)
            } catch {
                // Handle error
                completion(false)
            }
        }
    }
    
    func getTheUpdatedProductsIfProductCartUpdated()-> [ECC_ProductsModel]?{
        let products = getProductForStoreType(storeType: "")
        let cartProducts = ECC_CartManager.shared.productCart
        if var mutableProducts = products {
            for (index, product) in mutableProducts.enumerated(){
               let productIsPresent = cartProducts?.contains(where: {$0.id == product.id})
                if( productIsPresent == true){
                   var newProduct = product
                    newProduct.isSelected = true
                    mutableProducts[index] = newProduct
                }
                
            }
            return mutableProducts
        }
        return nil
    }

}
    
