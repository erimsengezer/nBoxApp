//
//  TabBarController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 27.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
        
        for item in tabBar.items! {
            item.image?.withRenderingMode(.alwaysOriginal)
            item.selectedImage?.withRenderingMode(.alwaysOriginal)
        }
    }
}
