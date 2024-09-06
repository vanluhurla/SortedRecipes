//
//  SRCategoryCarouselView.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import SwiftUI

struct SRCategoryCarouselView: View {
    
    @ObservedObject var viewModel: SRHomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: -15) {
                ForEach(SRRecipeCategory.allCases, id: \.self) { category in
                    NavigationLink(destination: SRRecipeListView(viewModel: viewModel, category: category)) {
                        VStack {
                            if let image = category.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.orange)
                            }
                            Text(category.title)
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        .frame(width: 80, height: 80)
                        .background(Color("smallCarousel"))
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    struct SRCategoryCarouselView_Previews: PreviewProvider {
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
            
            return SRCategoryCarouselView(viewModel: mockViewModel)
        }
    }
}
