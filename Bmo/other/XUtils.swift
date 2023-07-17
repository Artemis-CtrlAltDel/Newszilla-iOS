//
//  XUtils.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import Foundation
import SwiftUI

extension Date {
    
    func stringify() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: self)
    }
}

extension Color {
    
    static let accentSurface = Color(red: 0.6784313725490196, green: 0.8274509803921568, blue: 0.9607843137254902, opacity: 0.15)
}
