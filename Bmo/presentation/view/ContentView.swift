//
//  ContentView.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            
            TabView {
                HeadlinesView()
                    .tabItem {
                        Image(systemName: "square.topthird.inset.filled")
                        Text("Headlines")
                    }
                Text("News Screen")
                    .tabItem {
                        Image(systemName: "network")
                        Text("News")
                    }
                Text("Library Screen")
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Library")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
