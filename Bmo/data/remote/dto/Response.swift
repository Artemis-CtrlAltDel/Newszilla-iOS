//
//  Response.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import Foundation

struct Response: Hashable {

    var source: Source
    var author: String
    var title: String
    var url: String
    var urlToImage: String
    var desc: String
    var publishedAt: String
    var content: String
    var type: NewsType.RawValue
    var category: Category.RawValue?
}
