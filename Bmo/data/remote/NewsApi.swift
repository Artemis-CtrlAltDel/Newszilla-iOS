//
//  NewsApi.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON

class NewsApi: NewsApiProtocol {
    
    private var newsType: NewsType = .initCase
    
    private func taskGetNews(with url: URL, completion: @escaping ([Response]) -> Void) {
        
        var articles = [Response]()
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("no data received")
                return
            }
            
            let json = try! JSON(data: data)
            
            for article in json["articles"] {
                
                let source = article.1["source"]
                let id = source["id"].stringValue
                let name = source["name"].stringValue //
                
                let author = article.1["author"].stringValue //
                let title = article.1["title"].stringValue //
                let url = article.1["url"].stringValue //
                let urlToImage = article.1["urlToImage"].stringValue //
                let description = article.1["description"].stringValue //
                let publishedAt = article.1["publishedAt"].stringValue
                let content = article.1["content"].stringValue
                
                if  (
                    !(name.isEmpty) &&
                    !(author.isEmpty) &&
                    !(title.isEmpty) &&
                    !(url.isEmpty) &&
                    !(urlToImage.isEmpty) &&
                    !(description.isEmpty)
                ) {
                    
                    articles.append(
                        Response(source: Source(id: id, name: name), author: author, title: title, url: url, urlToImage: urlToImage, desc: description, publishedAt: publishedAt, content: content, type: self.newsType.rawValue)
                    )
                    
                }
                
            }
            
            completion(articles)
        }
        
        task.resume()
        
    }
    
    func getTopHeadlines(
        for country: String,
        category: Category,
        continuation: @escaping ([Response]) -> Void
    ) {
        
        newsType = .topHeadlines
        let url = URL(string: "\(Constants.BASE_URL)/\(newsType.rawValue)?apiKey=\(Constants.API_KEY)&country=\(country)&category=\(category.rawValue)")!
        
        taskGetNews(with: url) { articles in
            
            // mutableArticle has been used as a work around to "modify" the immutable original array
            continuation(
                articles
                    .compactMap({ article in
                        var mutableArticle = article
                        mutableArticle.category = category.rawValue
                        return mutableArticle
                    })
            )
        }
        
    }
    
    func getEverything(
        for q: String,
        language: Language,
        continuation: @escaping ([Response]) -> Void)
    {
        
        newsType = .everything
        let url = URL(string: "\(Constants.BASE_URL)/\(newsType.rawValue)?apiKey=\(Constants.API_KEY)&q=\(q)&language=\(language.rawValue)")!
        
        taskGetNews(with: url) { articles in
            
            continuation(
                articles
            )
            
        }
        
    }
}
