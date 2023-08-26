//
//  CategoryPackageView.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 14/8/2023.
//

import SwiftUI

struct CategoryPackageView: View {
    
    let articlesGroupedByCategory: [Article?]
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @EnvironmentObject
    private var viewModel: ViewModel
    
    @State
    var isSaved = false
    
    var body: some View {
        
        //todo create group packages
        Text("Hello World!")
        
    }
}
