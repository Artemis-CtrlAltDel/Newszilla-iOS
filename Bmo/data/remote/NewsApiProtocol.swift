//
//  NewsApiProtocol.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 13/7/2023.
//

import Foundation

protocol NewsApiProtocol {
    
    func getTopHeadlines(
        for country: String,
        category: Category,
        continuation: @escaping ([Response]) -> Void
    )
}
