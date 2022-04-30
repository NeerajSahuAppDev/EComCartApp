//
//  ECC_ProductsModel.swift
//  EComCart
//
//  Created by mytsl01831 on 28/04/22.
//

import Foundation
struct ECC_ProductsModel : Codable, Hashable{
    let id : Int?
    let title : String?
    let type : String?
    let image : String?
    let price : Double?
    let rating : Double?
    var isSelected : Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case type = "type"
        case image = "image"
        case price = "price"
        case rating = "rating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
    }

}
