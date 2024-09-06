//
//  SRCategoryCarouselView.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import SwiftUI

struct SRCategoryCarouselView: View {
    
    @ObservedObject var viewModel: SRHomeViewModel // Passing ViewModel from SRHomeView
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(SRRecipeCategory.allCases, id: \.self) { category in
                    NavigationLink(destination: SRRecipeListView(viewModel: viewModel, category: category)) {
                        VStack {
                            if let image = category.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.orange) // This tints the image
                            }
                            Text(category.title)
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        .frame(width: 80, height: 80) // Small square size
                        .background(Color("smallCarousel")) // Background color from assets
                        .cornerRadius(20) // Rounded corners
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    struct SRCategoryCarouselView_Previews: PreviewProvider {
        static var previews: some View {
            // Create a mock instance of RecipeViewModel with sample data
            let mockViewModel = SRHomeViewModel()
            
            // Mock SRRecipe data
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
            
            return SRCategoryCarouselView(viewModel: mockViewModel)
        }
    }
}
