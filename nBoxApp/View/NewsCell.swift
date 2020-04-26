//
//  NewsCell.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 25.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var emojiView: UIView!
    @IBOutlet weak var saveIcon: UIImageView!
    
    var isSaved = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveIcon.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(click))
        saveIcon.addGestureRecognizer(gesture)
    }

    @objc func click() {
        print("Clicked")
        isSaved = !isSaved
        saveIcon.image = isSaved ? UIImage(named: "saveIconSelected") : UIImage(named: "saveIcon")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
