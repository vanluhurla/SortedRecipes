//
//  SRRecipeDetailViewModel.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import SwiftUI

class SRRecipeDetailViewModel: ObservableObject {
    
    @Published var recipe: SRRecipe?
    
    init(recipe: SRRecipe) {
        self.recipe = recipe
    }
}
