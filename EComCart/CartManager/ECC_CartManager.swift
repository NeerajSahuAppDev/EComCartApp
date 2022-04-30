//
//  ECC_CartManager.swift
//  EComCart
//
//  Created by mytsl01831 on 28/04/22.
//

import Foundation
class ECC_CartManager {
 
    static let shared = ECC_CartManager()
    private init() { }
    
    var productCart : [ECC_ProductsModel]? = [ECC_ProductsModel]()
    
    //Add product in cart
    func addProduct(productNeedToAdd : ECC_ProductsModel){
        productCart?.insert(productNeedToAdd , at: 0)
    }
    
    //Removed product from cart
    func removeProduct(productNeedToRemove : ECC_ProductsModel){
        let filteredItems = productCart?.filter { $0.id == productNeedToRemove.id }
        if let product = filteredItems?.first {
            productCart?.removeAll(where: {$0.id == product.id})
        }
    }
    //Return the total products added in the cart
    func totalProductCount()-> Int{
        return productCart?.count ?? 0
    }
    
    //Return the toral cart value
    func totalCartPriceValue()->Double{
        let reducedPriceValue = productCart?.reduce(0) { $0 + $1.price!}
        return reducedPriceValue ?? 0

    }
    
    //Clean the complete cart
    func clearCart(){
        self.productCart?.removeAll()
    }
    
    func postOrderDetailsToLocalDocumentFolder(orderDoneDetails: ECC_OrderDoneModel, completion: (Bool) -> ()) {
        // we are just sending the Boolean value that was sent in "back"
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(orderDoneDetails)
        guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else { return completion(false) }
        
        let dataService = ECC_DataServices()
        dataService.createAndSaveLocalJSONFileFromJSONString(jsonStringOrderDetails: jsonString) { success in
            if(success){
                completion(true)
            }else{
                completion(false)

            }
        }
    }

}
