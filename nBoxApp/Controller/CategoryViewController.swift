//
//  CategoryViewController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 24.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    let categories = ["Tümü", "Dünya", "Sosyal Medya", "Otomobil", "Teknoloji", "Siyaset", "Sağlık", "Spor"]
    
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeAction))
        closeLabel.addGestureRecognizer(tapGesture)
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        setupLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func setupLayout() {
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        selectButton.layer.masksToBounds = true
        selectButton.layer.cornerRadius = 10
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        NSLayoutConstraint.activate([
        
            //MARK: - Picker Constraints
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pickerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //MARK: - Close Constraints
            closeLabel.widthAnchor.constraint(equalToConstant: 100),
            closeLabel.heightAnchor.constraint(equalToConstant: 100),
            closeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (width / 2) - 30),
            closeLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: height / 10),
            
            //MARK: - Button Constraints
            
            selectButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            selectButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            
            
        ])
    }
    
    @objc private func closeAction() {
        print("Close cliked !")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "news" {
            
            let destination = segue.destination as! UITabBarController
            let destinationVC = destination.viewControllers?.first as! NewsViewController
            destinationVC.choosenCategory = selectedCategory
            
        }
    }
    
    @IBAction func selectButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "news", sender: selectedCategory)
    }
    

}

extension CategoryViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleText = categories[row]
        let titleForRow = NSAttributedString(string: titleText, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white,
        
        ])
        
        return titleForRow
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let count = categories.count
        
        return screenHeight / CGFloat(count)
    }
    
}

extension CategoryViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newsViewController") as! NewsViewController
        print("Choosen : \(vc.choosenCategory)")
        print("Selected : \(selectedCategory)")
    }
}
