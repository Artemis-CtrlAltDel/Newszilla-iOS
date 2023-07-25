//
//  ArticleCardView.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 13/7/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleCardView: View {
    
    let article: Article
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @EnvironmentObject
    private var viewModel: ViewModel
    
    @State
    var isSaved = false
    
    var body: some View {
        
        VStack {
            
            NavigationLink(destination: ArticleDetailsView(article: article, isSaved: isSaved)) {
                
                HStack {
                    
                    if article.urlToImage == nil || article.urlToImage == "" {
                        Image("default")
                    }
                    else {
                        WebImage(url: URL(string: article.urlToImage ?? "url to image")!, options: .highPriority)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                    }
                    
                    VStack {
                        
                        Text(article.title ?? "title")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                            .font(.title3)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        Text(article.desc ?? "description")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        Text("• \(article.author ?? "author")")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .italic()
                            .foregroundColor(.secondary)
                            .padding(.top, 5)
                            .lineLimit(1)
                    }
                    .padding(.leading, 5)
                    
                }
                
            }
            
            Divider()
            
            HStack {
                // TODO re-position this sharing feature.
                Image(systemName: "link")
                    .padding(5)
                    .background(Color.accentSurface)
                    .clipShape(Circle())
                    .onTapGesture {
                        share(url: article.url ?? "url")
                    }
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: {
                viewModel.delete(context: viewContext, article: article)
            }) {
                Image(systemName: "trash")
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                save(article: self.article)
            } label: {
                (self.article.isSaved || self.isSaved) ? Image(systemName: "minus.circle") : Image(systemName: "arrow.down.circle")
            }
            .tint((self.article.isSaved || self.isSaved) ? .orange : .blue)

        }
        
    }
    
    private func share(url: String){
        let url = URL(string: url)!
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            window.rootViewController?.present(av, animated: true, completion: nil)
            
        }
    }
    
    private func save(article: Article) {
        
        isSaved.toggle()
        article.isSaved = isSaved
        print(article.isSaved)
    }
}
