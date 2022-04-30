//
//  ECC_StoreInfoModel.swift
//  EComCart
//
//  Created by mytsl01831 on 28/04/22.
//

import Foundation

typealias StoreArray = [ECC_StoreInfoModel]

struct ECC_StoreInfoModel : Codable {
    let title : String?
    let type : String?
    let image : String?
    var isSelected : Bool = false
    enum CodingKeys: String, CodingKey {

        case title = "title"
        case type = "type"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
