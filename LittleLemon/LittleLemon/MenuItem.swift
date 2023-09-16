//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Warakorn Mukdaprasert on 16/9/2566 BE.
//

import Foundation

struct MenuItem: Codable {
    let title: String
    let image: String
    let price: String
    let menuDescription: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case price = "price"
        case menuDescription = "description"
    }
}
