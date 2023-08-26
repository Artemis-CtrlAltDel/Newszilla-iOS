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

enum Category: String, CaseIterable, Identifiable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
    var id: Self {
        self
    }
}

enum Language: String, CaseIterable, Identifiable {
    case arabic = "ar"
    case deutsh = "de"
    case english = "en"
    case spanish = "es"
    case french = "fr"
    case italian = "it"
    case russian = "ru"
    case salvador = "sv"
    
    var id: Self {
        self
    }
}
