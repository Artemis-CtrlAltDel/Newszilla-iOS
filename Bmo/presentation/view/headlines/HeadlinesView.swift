//
//  HeadlinesView.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 14/7/2023.
//

import SwiftUI

struct HeadlinesView: View {
    
    private let api = NewsApi()
    
    private var topHeadlinesFetchRequest: FetchRequest<Article>
    private var topHeadlinesList: FetchedResults<Article> {
        topHeadlinesFetchRequest.wrappedValue
    }
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @EnvironmentObject
    private var viewModel: ViewModel
    
    @State
    private var isPresentingConfirm = true
    
    @State
    private var sortBy: SortBy = .initCase
    
    @State
    private var category: Category = .initCase
    
    init() {
        
        topHeadlinesFetchRequest = FetchRequest(
            sortDescriptors: [NSSortDescriptor(key: "publishedAt", ascending: false)]
        )
        
    }
    
    var body: some View {
        
        VStack {
            
            if topHeadlinesList.isEmpty {
                Text("no data")
            }
            
            else {
                
                List(topHeadlinesList) { article in
                    
                    ArticleCardView(article: article)
                    
                }
                
            }
            
        }
        .navigationTitle("Headlines")
        .onAppear {
            cache(category: Category.business)
        }
    }
    
    private func cache(category: Category) {
        self.category = category
        viewModel.cacheTopHeadlines(context: viewContext, category: category)
    }
    
}

struct HeadlinesView_Previews: PreviewProvider {
    static var previews: some View {
        HeadlinesView()
    }
}
