//
//  SRRecipeDetailView.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import SwiftUI

struct SRRecipeDetailView: View {
    @ObservedObject var viewModel: SRRecipeDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Recipe Title
                Text(viewModel.recipe?.title ?? "")
                    .font(.largeTitle)
                    .padding(.top, 180)
                    .padding(.horizontal)
                
                // Recipe Image
                AsyncImage(url: URL(string: viewModel.recipe?.image ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                // Ingredients Header
                Text("Ingredients")
                    .font(.title2)
                    .padding()
                    .padding(.horizontal)
                
                // Ingredients List
                ForEach(viewModel.recipe?.ingredients ?? [], id: \.self) { ingredient in
                    Text(ingredient)
                        .padding(.horizontal)
                        .padding(.bottom, 2)
                }
                
                // Instructions Header
                Text("Instructions")
                    .font(.title2)
                    .padding(.top)
                    .padding(.horizontal)
                
                // Instructions List
                ForEach(viewModel.recipe?.instructions ?? [], id: \.self) { instruction in
                    Text(instruction)
                        .padding(.horizontal)
                        .padding(.bottom, 2)
                }
            }
        }
        .navigationTitle(viewModel.recipe?.title ?? "Recipe Details")
        .ignoresSafeArea()
    }
}

struct SRRecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample Recipe Data
        let sampleRecipe = SRRecipe(
            image: "https://example.com/pancakes.jpg",
            title: "Pancakes",
            category: "Breakfast",
            date: Date(),
            ingredients: ["Flour", "Milk", "Eggs"],
            instructions: ["Mix ingredients", "Cook on griddle"],
            preparationTime: "10 mins",
            featured: false
        )
        
        return SRRecipeDetailView(viewModel: SRRecipeDetailViewModel(recipe: sampleRecipe))
    }
}
