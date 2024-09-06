//
//  SRRecipeDetailView.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import SwiftUI

struct SRRecipeDetailView: View {
    @ObservedObject var viewModel: SRRecipeDetailViewModel
    
    init(viewModel: SRRecipeDetailViewModel) {
        self.viewModel = viewModel
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "mainBackground")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    
                    AsyncImage(url: URL(string: viewModel.recipe?.image ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 300)
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: geometry.size.width, height: 300)
                                .clipped()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text("Ingredients")
                        .font(.title2)
                        .padding(.top, 16)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    
                    ForEach(viewModel.recipe?.ingredients ?? [], id: \.self) { ingredient in
                        Text(ingredient)
                            .padding(.horizontal)
                            .padding(.bottom, 2)
                            .foregroundColor(.white)
                    }
                    
                    Text("Instructions")
                        .font(.title2)
                        .padding(.top, 16)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    
                    ForEach(viewModel.recipe?.instructions ?? [], id: \.self) { instruction in
                        Text(instruction)
                            .padding(.horizontal)
                            .padding(.bottom, 2)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 0)
            }
        }
        .background(Color("mainBackground"))
        .navigationTitle(viewModel.recipe?.title ?? "Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SRRecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
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
