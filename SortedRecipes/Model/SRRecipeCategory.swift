//
//  SRRecipeCategory.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import UIKit

enum SRRecipeCategory: Int, CaseIterable {
    case breakfast, lunch, dinner, dessert, snacks, drinks, bakery
    
    var title: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .dinner:
            return "Dinner"
        case .dessert:
            return "Dessert"
        case .snacks:
            return "Snacks"
        case .drinks:
            return "Drinks"
        case .bakery:
            return "Bakery"
        }
    }
    
    var image: UIImage? {
        UIImage(named: "category_icon_\(self.title.lowercased())")?.withRenderingMode(.alwaysTemplate)
    }
}
