//
//  SRNetworkManager.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import Foundation

class GCNetworkManager {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlSession: URLSession = .shared, urlString: String) {
        self.urlSession = urlSession
        self.urlString = urlString
    }
    
    // Completion handler
    func getRecipeList(completion: @escaping (_ recipes: [SRRecipe]?, _ error: SRNetworkError?) -> Void) {
        guard let url = URL(string: SRNetworkUrl.recipeList) else {
            completion(nil, SRNetworkError.invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data,
                  error == nil else {
                completion(nil, SRNetworkError.noData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.serverDateFormat)
                let recipeRecord = try decoder.decode(SRRecipeRecord.self, from: data)
                completion(recipeRecord.record.recipes, nil)
            } catch {
                completion(nil, SRNetworkError.decodingError)
            }
        }
        task.resume()
    }
}
