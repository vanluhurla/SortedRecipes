//
//  SRRecipe.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import Foundation

struct SRRecipeRecord: Codable {
    let record: SRRecipeResponse
}

struct SRRecipeResponse: Codable {
    let recipes: [SRRecipe]
}

struct SRRecipe: Codable, Hashable {
    let image: String
    let title: String
    let category: String
    let date: Date
    let ingredients: [String]
    let instructions: [String]
    let preparationTime: String
    let featured: Bool
}
