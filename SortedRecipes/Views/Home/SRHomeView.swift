//
//  SRHomeView.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 04/09/2024.
//


import SwiftUI

struct SRHomeView: View {
    
    @StateObject private var viewModel = SRHomeViewModel() // ViewModel instance
    
    var body: some View {
        NavigationStack {
            VStack {
                // Category Carousel
                SRCategoryCarouselView(viewModel: viewModel)
                    .frame(height: 200)
                    .background(Color("mainBackground"))
                Spacer()
            }
            .padding()
            .background(Color("mainBackground"))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SRHomeView()
}
