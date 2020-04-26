//
//  TrendsViewController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 27.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit

class TrendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Trendler"
    }

}
