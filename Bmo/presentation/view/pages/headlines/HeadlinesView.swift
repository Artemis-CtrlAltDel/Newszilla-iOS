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
    private var category: Category = .business
    
    @State
    private var isCachedOnLaunch = false
    
    init() {
        
        topHeadlinesFetchRequest = FetchRequest(
            sortDescriptors: [NSSortDescriptor(key: "publishedAt", ascending: false)]
        )
        
    }
    
    var body: some View {
        
        VStack {
            
            Picker("Category", selection: $category) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue.capitalized)
                }
            }
            .onChange(of: category) { newCategory in
                onCategoryChange(category: newCategory)
            }
            
            if topHeadlinesList.isEmpty {
                Text("no data")
            }
            
            else {
                
                List(topHeadlinesList) { article in
                    
                    ArticleCardView(article: article)
                    
                }
                .refreshable {
                    cache(category: category)
                }
                
            }
            
        }
        .onAppear {
            if !isCachedOnLaunch {
                isCachedOnLaunch.toggle()
                cache(category: category)
            }
        }
    }
    
    private func cache(category: Category) {
        viewModel.cacheTopHeadlines(context: viewContext, category: category)
    }
    
    private func onCategoryChange(category: Category) {
        viewModel.truncateHeadlines(context: viewContext, topHeadlinesList: topHeadlinesList)
        cache(category: category)
    }
    
}

struct HeadlinesView_Previews: PreviewProvider {
    static var previews: some View {
        HeadlinesView()
    }
}
