//
//  SRFeaturedRecipeCarousel.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 06/09/2024.
//

import SwiftUI

struct SRFeaturedRecipeCarousel: View {
    var featuredRecipes: [SRRecipe]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Featured Recipes")
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(featuredRecipes, id: \.self) { recipe in
                        SRFeaturedRecipeCell(recipe: recipe)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SRFeaturedRecipeCarousel_Previews: PreviewProvider {
    static var previews: some View {
        let mockRecipes = [
            SRRecipe(
                image: "https://example.com/pancakes.jpg",
                title: "Pancakes",
                category: "Breakfast",
                date: Date(),
                ingredients: ["Flour", "Milk", "Eggs"],
                instructions: ["Mix ingredients", "Cook on griddle"],
                preparationTime: "10 mins",
                featured: true
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
        
        return SRFeaturedRecipeCarousel(featuredRecipes: mockRecipes)
    }
}

struct SRFeaturedRecipeCell: View {
    var recipe: SRRecipe
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: recipe.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 400)
                        .cornerRadius(15)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 250, height: 300)
                        .cornerRadius(15)
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(recipe.title)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .cornerRadius(15)
        }
        .frame(width: 250, height: 300)
    }
}
