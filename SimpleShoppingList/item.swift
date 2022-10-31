//
//  item.swift
//  SimpleShoppingList
//
//  Created by Gideon Shawana on 2022-10-30.
//

// Item clas to store item

import Foundation

class item: Encodable, Decodable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
