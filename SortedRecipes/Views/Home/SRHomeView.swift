//
//  SRHomeView.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 04/09/2024.
//


import SwiftUI

struct SRHomeView: View {
    
    // Instance of my ViewModel
    @StateObject private var viewModel = SRHomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    
                    SRCategoryCarouselView(viewModel: viewModel)
                        .frame(height: 100)
                        .background(Color("mainBackground"))
                    
                    Text("Featured")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("mainBackground"))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: -10) {
                            ForEach(viewModel.featuredRecipes, id: \.title) { recipe in
                                NavigationLink(destination: SRRecipeDetailView(viewModel: SRRecipeDetailViewModel(recipe: recipe))) {
                                    SRFeaturedRecipeCell(recipe: recipe)
                                        .frame(width: 300, height: 400)
                                        .cornerRadius(16)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 400)
                    }
                    .padding()
                    .background(Color("mainBackground"))
                    
                    Text("All Recipes")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("mainBackground"))
                    
                    VStack(spacing: 10) {
                        ForEach(viewModel.allRecipes, id: \.title) { recipe in
                            NavigationLink(destination: SRRecipeDetailView(viewModel: SRRecipeDetailViewModel(recipe: recipe))) {
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
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color("secondaryBackground"))
                                .cornerRadius(12)
                                .shadow(radius: 4)
                            }
                        }
                    }
                    .padding()
                }
                .padding(.top, 65)
            }
            .background(Color("mainBackground"))
            .ignoresSafeArea()
        }
        
    }
    
}

#Preview {
    SRHomeView()
}
