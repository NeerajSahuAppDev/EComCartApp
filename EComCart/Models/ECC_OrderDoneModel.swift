//
//  ECC_OrderDoneModel.swift
//  EComCart
//
//  Created by mytsl01831 on 30/04/22.
//

import Foundation

struct ECC_OrderDoneModel : Codable {
    let destination : String?
    var orderData : [ECC_ProductsModel]?
    var orderPrice : String?
    var shipments : String?

    enum CodingKeys: String, CodingKey {

        case destination = "destination"
        case orderData = "orderData"
        case orderPrice = "orderPrice"
        case shipments = "shipments"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        orderData = try values.decodeIfPresent([ECC_ProductsModel].self, forKey: .orderData)
        orderPrice = try values.decodeIfPresent(String.self, forKey: .orderPrice)
        shipments = try values.decodeIfPresent(String.self, forKey: .shipments)
    }

}
