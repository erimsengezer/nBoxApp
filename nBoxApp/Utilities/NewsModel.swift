//
//  NewsModel.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 9.05.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import Foundation

struct NewsModel {
    var title : String
    var content : String
    var description : String
    
    init(title: String, description: String, content: String) {
        
        self.title = title
        self.content = content
        self.description = description
    }
}
