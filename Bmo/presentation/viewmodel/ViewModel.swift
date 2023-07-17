//
//  ViewModel.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class ViewModel: ObservableObject {
    
    private let api = NewsApi()
    private let locationManager = PermsUtils.Location()
    
    private func getCountryCode() -> String? {
        
        var countryCode: String? = nil
        
        if locationManager.locationManagerDidChangeAuthorization() {
            countryCode = Locale.current
                .language
                .region?
                .identifier
                .lowercased(with: Locale.current)
        }
        
        return countryCode
    }
    
    func cacheTopHeadlines(context: NSManagedObjectContext, category: Category) {
        
        let country = getCountryCode() ?? "us"
        
        api.getTopHeadlines(for: country, category: category) { articles in
            for article in articles {
                self.insert(context: context, response: article)
            }
        }
    }
    
    private func insert(context: NSManagedObjectContext, response: Response) {
        
        let article = Article(context: context)
        
        article.id = UUID()
        article.source = response.source
        article.author = response.author
        article.title = response.title
        article.url = response.url
        article.urlToImage = response.urlToImage
        article.desc = response.desc
        article.publishedAt = response.publishedAt
        article.content = response.content
        article.type = response.type
        article.category = response.category
        
        save(context: context)
    }
    
    func delete(context: NSManagedObjectContext, article: Article) {
        
        context.delete(article)
        
        save(context: context)
    }
    
    private func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
}
