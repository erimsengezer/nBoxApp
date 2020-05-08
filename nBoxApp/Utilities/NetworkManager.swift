//
//  NetworkManager.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 8.05.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import Foundation
import Firebase

class NetworkManager : NSObject {
    
    var newsArray = [NewsModel]()
    private static let sharedInstance = NetworkManager()
    private override init() {}
    let db = Firestore.firestore()
    
    public static func getSharedInstance() -> NetworkManager! {
        return sharedInstance
    }
    
    func sendGetData(collection: String) -> [NewsModel]{
        
        let collect = db.collection(collection)
        var modelArray = [NewsModel]()
        DispatchQueue.main.async {
            collect.getDocuments { (snapshot, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
                else {
                    
                    for document in snapshot!.documents {
                        
                        let title = document.data()["title"] as! String
                        let desc = document.data()["description"] as! String
                        let content = document.data()["content"] as! String
                        
    //                    print("Document ID : \(document.documentID) => Document : \(document.data()["title"] ?? "")")
                        
                        let model = NewsModel(title: title, description: desc, content: content)
                        self.newsArray.append(model)
                        modelArray.append(model)
                        
                    }
                }
            }
        }
        return modelArray
    }
}
