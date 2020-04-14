//
//  ViewController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 14.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class ViewController: UIViewController, GADInterstitialDelegate {
    
    var interstitial : GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9394312041468898/9609702768")
        interstitial.delegate = self
        loadAds()
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
            self.showAds()
        }

    }

    
    private func loadAds() {
        let request = GADRequest()
        interstitial.load(request)
    }
    
    private func showAds() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }

}

