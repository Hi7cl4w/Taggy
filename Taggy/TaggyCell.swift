//
//  TaggyCell.swift
//  Taggy
//
//  Created by Manu K on 14/01/18.
//  Copyright © 2018 Manu K. All rights reserved.
//

import UIKit

internal class TaggyCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    var title:String=""{
        didSet{
            button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    var tagColor: UIColor=UIColor(red: 87.0/255.0, green: 190.0/255.0, blue: 212.0/255.0, alpha: 1.0){
        didSet {
            button.backgroundColor=tagColor
        }
    }
    
   var tagTextColor: UIColor=UIColor.white{
        didSet {
            button.titleLabel?.textColor = tagTextColor
            button.setTitleColor(tagTextColor, for: .normal)
        }
    }
    
    var tagBorderColor: UIColor=UIColor.clear{
        didSet {
            if(tagBorderColor==UIColor.clear){
                button.layer.borderWidth = 0
                button.layer.borderColor=tagBorderColor.cgColor
            }else{
                button.layer.borderWidth = 1
                button.layer.borderColor=tagBorderColor.cgColor
            }
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
