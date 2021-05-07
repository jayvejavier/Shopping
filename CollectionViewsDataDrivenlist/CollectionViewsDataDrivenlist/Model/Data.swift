//
//  Data.swift
//  CollectionViews_DataDrivenList
//
//  Created by Mospeng Research Lab Philippines on 4/25/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import Foundation

struct Categories: Decodable {
    let category_id: Int
    let category_name: String
    let category_image: String
}

struct Subcategories: Decodable {
    let subcategory_id: Int
    let subcategory_name: String
    let subcategory_image: String
    let from_category_id: Int
}

struct Items: Decodable {
    let item_id: Int
    let item_name: String
    let item_image: String
    let item_price: Int
    let item_description: String
    let from_subcategory_id: Int
}

struct Articles: Decodable {
    let id: Int
    let title: String
    let url:String
}
