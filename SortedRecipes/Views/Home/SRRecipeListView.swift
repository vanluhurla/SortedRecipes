//
//  SRRecipeListView.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import SwiftUI

struct SRRecipeListView: View {
    @ObservedObject var viewModel: SRHomeViewModel
    var category: SRRecipeCategory
    
    var body: some View {
        NavigationView {
            List(viewModel.getRecipesForCategory(category), id: \.title) { recipe in
                NavigationLink(destination: SRRecipeDetailView(viewModel: SRRecipeDetailViewModel(recipe: recipe))) {
                    SRRecipeRowView(recipe: recipe)
                }
            }
            .navigationTitle(category.title)
            .padding(.top, 180)
            .ignoresSafeArea()
            .onAppear {
                viewModel.filterRecipes(by: category)
            }
        }
    }
    
    struct SRRecipeListView_Previews: PreviewProvider {
        static var previews: some View {
            let mockViewModel = SRHomeViewModel()
            mockViewModel.allRecipes = [
                SRRecipe(
                    image: "https://example.com/pancakes.jpg",
                    title: "Pancakes",
                    category: "Breakfast",
                    date: Date(),
                    ingredients: ["Flour", "Milk", "Eggs"],
                    instructions: ["Mix ingredients", "Cook on griddle"],
                    preparationTime: "10 mins",
                    featured: false
                ),
                SRRecipe(
                    image: "https://example.com/salad.jpg",
                    title: "Caesar Salad",
                    category: "Lunch",
                    date: Date(),
                    ingredients: ["Lettuce", "Croutons", "Caesar dressing"],
                    instructions: ["Toss ingredients", "Serve chilled"],
                    preparationTime: "15 mins",
                    featured: true
                )
            ]
            
            return SRRecipeListView(viewModel: mockViewModel, category: .breakfast)
        }
    }
    
    
    struct SRRecipeRowView: View {
        let recipe: SRRecipe
        
        var body: some View {
            HStack {
                AsyncImage(url: URL(string: recipe.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(recipe.title)
                    .font(.headline)
                
                Spacer()
            }
            .padding()
        }
    }
}
