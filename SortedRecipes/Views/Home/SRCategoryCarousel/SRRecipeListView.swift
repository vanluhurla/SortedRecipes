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
    
    init(viewModel: SRHomeViewModel, category: SRRecipeCategory) {
        self.viewModel = viewModel
        self.category = category
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "mainBackground")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getRecipesForCategory(category), id: \.title) { recipe in
                    NavigationLink(destination: SRRecipeDetailView(viewModel: SRRecipeDetailViewModel(recipe: recipe))) {
                        SRRecipeRowView(recipe: recipe)
                    }
                    .listRowBackground(Color("mainBackground"))
                }
            }
            .listStyle(PlainListStyle())
            .background(Color("mainBackground").edgesIgnoringSafeArea(.all))
            .navigationTitle(category.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.filterRecipes(by: category)
            }
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
                            .frame(width: 100, height: 100)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .padding()
            .background(Color("secondaryBackground"))
            .cornerRadius(12)
            .shadow(radius: 4)
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
}
