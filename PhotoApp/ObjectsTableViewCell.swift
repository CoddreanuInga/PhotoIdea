//
//  ObjectsTableViewCell.swift
//  PhotoApp
//
//  Created by Inga Codreanu on 11/16/15.
//  Copyright © 2015 Inga. All rights reserved.
//

import UIKit

class ObjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var DetailCell: UILabel!
    @IBOutlet var SaveImage: UIImageView!
   
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.SaveImage.layer.cornerRadius = self.SaveImage.frame.size.width / 2
        self.SaveImage.clipsToBounds = true
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
