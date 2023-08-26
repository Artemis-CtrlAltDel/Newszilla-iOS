//
//  LibraryView.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 14/8/2023.
//

import SwiftUI

struct LibraryView: View {
    
    private let libraryFetchRequest: FetchRequest<Article>
    private var libraryList: FetchedResults<Article> {
        libraryFetchRequest.wrappedValue
    }
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @EnvironmentObject
    private var viewModel: ViewModel
    
    init() {
        
        libraryFetchRequest = FetchRequest(
            sortDescriptors: [NSSortDescriptor(key: "publishedAt", ascending: false)]
        )
        
    }
    
    var body: some View {
        
        let categorizedLibraryList = libraryList.reduce(into: [String: [Article]]()) { partialResult, article in
            
            if let category = article.category {
                
                partialResult[category]!.append(article)
                
            }
            
        }
        
        Text(categorizedLibraryList.count.formatted())
        
    }
    
}
