//
//  SRHomeViewModel.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import SwiftUI

class SRHomeViewModel: ObservableObject {
    
    @Published var allRecipes: [SRRecipe] = []
    @Published var filteredRecipes: [SRRecipe] = []
    @Published var selectedCategory: SRRecipeCategory?
    
    var featuredRecipes: [SRRecipe] {
        return allRecipes.filter { $0.featured }
    }
    
    private let networkManager: GCNetworkManager
    
    init(networkManager: GCNetworkManager = GCNetworkManager(urlString: SRNetworkUrl.recipeList)) {
        self.networkManager = networkManager
        fetchRecipes()
    }
    
    func fetchRecipes() {
        networkManager.getRecipeList { [weak self] recipes, error in
            guard let self = self else { return }
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
                if let category = self.selectedCategory {
                    self.filterRecipes(by: category)
                }
            }
        }
    }
    
    func filterRecipes(by category: SRRecipeCategory) {
        selectedCategory = category
        filteredRecipes = allRecipes.filter { $0.category == category.title }
    }
    
    func getRecipesForCategory(_ category: SRRecipeCategory) -> [SRRecipe] {
        return filteredRecipes
    }
    
    func getFeaturedRecipes() -> [SRRecipe] {
        return allRecipes.filter { $0.featured }
    }
}
