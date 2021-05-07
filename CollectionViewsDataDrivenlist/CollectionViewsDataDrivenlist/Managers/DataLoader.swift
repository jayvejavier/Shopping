//
//  DataLoader.swift
//  CollectionViews_DataDrivenList
//
//  Created by Mospeng Research Lab Philippines on 4/25/20.
//  Copyright © 2020 Mospeng Research Lab Philippines. All rights reserved.
//

import Foundation

public class DataLoader {
    
    let const = Constants()

    var categoriesData = [Categories]()
    var subcategoriesData = [Subcategories]()
    var itemsData = [Items]()
    var articlesData = [Articles]()
    
    func getCategoriesData() -> [Categories] {
        
        if let fileLocation = Bundle.main.url(forResource: const.CATEGORIES_STR, withExtension: const.JSON_STR) {
            
            // do catch in case of an error
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Categories].self, from: data)
                let categories = dataFromJson
                self.categoriesData = categories
            } catch {
                print(error)
            }
        }
        return categoriesData
    }
    
    func getSubcategoriesData(from_category_id: Int) -> [Subcategories] {
        
        if let fileLocation = Bundle.main.url(forResource: const.SUBCATEGORIES_STR, withExtension: const.JSON_STR) {
      
            // do catch in case of an error
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Subcategories].self, from: data)
                let subcategories = dataFromJson.filter { $0.from_category_id == from_category_id }
                self.subcategoriesData = subcategories
            } catch {
                print(error)
            }
        }
        return subcategoriesData
    }
    
    func getItemsData(from_subcategory_id: Int) -> [Items] {
        
        if let fileLocation = Bundle.main.url(forResource: const.ITEMS_STR, withExtension: const.JSON_STR) {
      
            // do catch in case of an error
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Items].self, from: data)
                let items = dataFromJson.filter { $0.from_subcategory_id == from_subcategory_id }
                self.itemsData = items
            } catch {
                print(error)
            }
        }
        return itemsData
    }
    
}

