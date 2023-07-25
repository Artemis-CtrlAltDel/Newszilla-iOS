//
//  ArticleDetailsView.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 13/7/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleDetailsView: View {
    
    let article: Article
    
    @State
    var isSaved: Bool
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                ZStack {
                    if article.urlToImage == nil || article.urlToImage == "" {
                        Image("default")
                    }
                    else {
                        WebImage(url: URL(string: article.urlToImage ?? "url to image")!, options: .highPriority)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    }
                }
                
                VStack {
                    
                    Text(article.title ?? "Title")
                        .modifier(AlignHLeading())
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(article.desc ?? "Description")
                        .modifier(AlignHLeading())
                        .font(.title3)
                        .padding(.top, 1)
                    
                    VStack {
                        
                        HStack {
                            Text("Read more about it")
                                .modifier(AlignHLeading())
                                .font(.title2)
                                .fontWeight(.bold)
                                .modifier(AlignHLeading())
                            Button {
                                save(article: self.article)
                            } label: {
                                (self.article.isSaved || self.isSaved) ? Image(systemName: "arrow.down.circle.fill") : Image(systemName: "arrow.down.circle")
                            }
                            .tint(.blue)
                            .imageScale(.large)
                            
                        }
                        
                        NavigationLink(destination: WebView(url: URL(string: article.url ?? "url to read more")!)) {
                            Text(article.url ?? "url to read more")
                                .modifier(AlignHLeading())
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .modifier(AlignHLeading())
                        .padding(.top, 1)

                    }
                    .modifier(AlignVBottom())
                    .padding(.top, 30)
                    
                }
                .modifier(AlignVTop())
                .padding(.top, 30)
                
                
            }
            .navigationTitle("Details")
            .padding(12)
            .modifier(AlignVTop())
        }
        
    }
    
    private func save(article: Article) {
        
        isSaved.toggle()
        article.isSaved = isSaved
        print(article.isSaved)
    }
}
