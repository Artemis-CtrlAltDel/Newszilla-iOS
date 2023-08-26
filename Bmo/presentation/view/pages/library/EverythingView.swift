//
//  EverythingView.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 26/8/2023.
//

import SwiftUI

struct EverythingView: View {
    
    private var everythingFetchRequest: FetchRequest<Article>
    private var everythingList: FetchedResults<Article> {
        everythingFetchRequest.wrappedValue
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
    private var language: Language = .english
    
    @State
    private var searchText = ""
    
    @State
    private var isCachedOnLaunch = false
    
    init() {
        
        everythingFetchRequest = FetchRequest(
            sortDescriptors: [NSSortDescriptor(key: "publishedAt", ascending: false)]
        )
        
    }
    
    var body: some View {
        
        VStack {
            
            if everythingList.isEmpty {
                Text("no data")
            }
            
            else {
                
                List(everythingList) { article in
                    
                    ArticleCardView(article: article)
                        .listRowSeparator(.hidden)
                        .padding(.bottom)
                    
                }
                .listStyle(.plain)
                .refreshable {
                    cache(language: language)
                }
                
                Picker("Language", selection: $language) {
                    ForEach(Language.allCases) { language in
                        Text(language.rawValue.capitalized)
                    }
                }
                .padding()
                .onChange(of: language) { newLanguage in
                    onLanguageChange(language: newLanguage)
                }
                
            }
            
        }
        .onAppear {
            if !isCachedOnLaunch {
                isCachedOnLaunch.toggle()
                cache(language: language)
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a topic to search...")
        .onChange(of: searchText) { newTopic in
            onTopicChange(q: newTopic)
        }
        
    }
    
    private func cache(language: Language) {
        viewModel.cacheEverything(context: viewContext, q: searchText, language: language)
    }
    
    private func onLanguageChange(language: Language) {
        viewModel.truncateEverything(context: viewContext, everythingList: everythingList)
        cache(language: language)
    }
    
    private func onTopicChange(q: String) {
        viewModel.truncateEverything(context: viewContext, everythingList: everythingList)
        cache(language: language)
    }
    
}
