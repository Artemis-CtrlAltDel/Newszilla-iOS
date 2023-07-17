//
//  Source.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import Foundation

class Source: NSObject, NSCoding {
    
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init?(coder: NSCoder) {
        
        guard let id = coder.decodeObject(forKey: "id") as? String else {
            return nil
        }
        guard let name = coder.decodeObject(forKey: "name") as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
    }
}
