//
//  MenuList.swift
//  LittleLemon
//
//  Created by Warakorn Mukdaprasert on 16/9/2566 BE.
//

import Foundation

struct MenuList: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}
