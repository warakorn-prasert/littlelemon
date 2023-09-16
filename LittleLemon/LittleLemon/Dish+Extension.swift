//
//  Dish+Extension.swift
//  LittleLemon
//
//  Created by Warakorn Mukdaprasert on 16/9/2566 BE.
//

import Foundation
import CoreData

extension Dish {
    
    static func createDishFrom(menuItem: MenuItem,
                                 _ context: NSManagedObjectContext) {
        let dish = Dish(context: context)
        dish.title = menuItem.title
        dish.image = menuItem.image
        dish.price = menuItem.price
        dish.menuDescription = menuItem.menuDescription
    }
}
