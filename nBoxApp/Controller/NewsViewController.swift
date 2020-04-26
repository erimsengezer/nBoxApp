//
//  NewsViewController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 25.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    var choosenCategory = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = choosenCategory

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }

    private func setupLayout() {
        
        
        NSLayoutConstraint.activate([
        
            
            
            
        ])
        
        
    }
    
}
extension NewsViewController : UITableViewDelegate {
    
}

extension NewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! NewsCell
        cell.titleLabel.text = "Buraya Başlık Gelecek !"
        cell.descriptionLabel.text = "Buraya Alt başlık gelecek."
        cell.sourceLabel.text = "burasıkaynak.com"
        cell.timeLabel.text = "1 dakika önce"
        cell.imageNews.image = UIImage(named: "newsImage")
        
        return cell
    }
    
}
