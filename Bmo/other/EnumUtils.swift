//
//  EnumUtils.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import Foundation

enum NewsType: String {
    case topHeadlines = "top-headlines"
    case everything = "everything"
    
    case initCase
}

enum SortBy: String {
    case relevency = "relevency"
    case popularity = "popularity"
    case publishedAt = "publishedAt"
    
    case initCase
}

enum Category: String {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
    case initCase
}
