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
            //button.sizeToFit()
            //sizeToFit()
            print("button \(button.frame)")
            print("TaggyCell \(frame)")
            
            print("TaggyCell x:\(frame.minX) y:\(frame.minY)\n")
            //frame.size=CGSize.init(width: button.frame.width+10, height: button.frame.height)
            //frame=CGRect.init(x: frame.minX, y: frame.minY, width: button.frame.width+10, height: button.frame.height+7)
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
