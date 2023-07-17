//
//  BmoApp.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import SwiftUI

@main
struct BmoApp: App {
    
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    @StateObject
    var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
                .environmentObject(viewModel)
        }
    }
}
