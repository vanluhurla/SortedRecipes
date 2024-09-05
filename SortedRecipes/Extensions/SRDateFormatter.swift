//
//  SRDateFormatter.swift
//  SortedRecipes
//
//  Created by Vanessa Hurla on 05/09/2024.
//

import Foundation

extension DateFormatter {
    static var serverDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    static var readableDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
