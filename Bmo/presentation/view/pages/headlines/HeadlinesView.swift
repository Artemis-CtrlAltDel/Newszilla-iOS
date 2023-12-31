//
//  HeadlinesView.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 14/7/2023.
//

import SwiftUI

struct HeadlinesView: View {
    
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
            
            if topHeadlinesList.isEmpty {
                Text("no data")
            }
            
            else {
                
                List(topHeadlinesList) { article in
                    
                    ArticleCardView(article: article)
                        .listRowSeparator(.hidden)
                        .padding(.bottom)
                    
                }
                .listStyle(.plain)
                .refreshable {
                    cache(category: category)
                }
                
                Picker("Category", selection: $category) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue.capitalized)
                    }
                }
                .padding()
                .onChange(of: category) { newCategory in
                    onCategoryChange(category: newCategory)
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
