//
//  TaggyCell.swift
//  Taggy
//
//  Created by Manu K on 14/01/18.
//  Copyright © 2018 Manu K. All rights reserved.
//

import UIKit

class TaggyCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    var title:String=""{
        didSet{
            button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    
    private func setupButton(){
        button.layer.cornerRadius=10
        
    }

}
