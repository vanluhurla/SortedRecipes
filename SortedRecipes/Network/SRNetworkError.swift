//
//  SRNetworkError.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import Foundation

enum SRNetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
