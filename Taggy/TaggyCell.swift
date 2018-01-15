//
//  TaggyCell.swift
//  Taggy
//
//  Created by Manu K on 14/01/18.
//  Copyright © 2018 Manu K. All rights reserved.
//

import UIKit

open class TaggyCell: _TaggyCell {
    
    var title:String=""{
        didSet{
            button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    open var tagColor: UIColor=UIColor(red: 87.0/255.0, green: 190.0/255.0, blue: 212.0/255.0, alpha: 1.0){
        didSet {
            button.backgroundColor=tagColor
        }
    }
    
    open var textColor: UIColor=UIColor.white{
        didSet {
            button.titleLabel?.textColor = textColor
            button.setTitleColor(textColor, for: .normal)
        }
    }
    
    open var textHighlightColor: UIColor=UIColor.white{
        didSet {
            button.setTitleColor(textHighlightColor, for: .highlighted)
            button.setTitleColor(textHighlightColor, for: .selected)
        }
    }
    
    open var highlightColor: UIColor=UIColor(red: 234.0/255.0, green: 59.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    
    open var borderHighlightColor: UIColor=UIColor(red: 234.0/255.0, green: 59.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    
    open var borderColor: UIColor=UIColor.clear{
        didSet {
            if(borderColor==UIColor.clear){
                button.layer.borderWidth = 0
                button.layer.borderColor=borderColor.cgColor
            }else{
                button.layer.borderWidth = 1
                button.layer.borderColor=borderColor.cgColor
            }
        }
    }
    
    open func setTagSelected(_ status: Bool){
        if status==true{
            button.layer.borderWidth=0
            button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.5,delay: 0,usingSpringWithDamping: 5,initialSpringVelocity: 2.0,options: .allowUserInteraction,animations: { [weak self] in
                self?.button.isSelected=true
                self?.button.backgroundColor=self?.highlightColor
                self?.button.transform = .identity
                },completion: nil)
            button.layer.borderColor=borderHighlightColor.cgColor
            button.layer.borderWidth=1
            
        }
        else{
            button.layer.borderWidth=0
            button.isSelected=false
            UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .allowUserInteraction, animations: {
                self.button.backgroundColor=self.tagColor
            }, completion: nil)
            button.layer.borderColor=self.borderColor.cgColor
            button.layer.borderWidth=1
        }
        
    }
}

open class _TaggyCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    
    private func setupButton(){
        button.layer.cornerRadius=10
        
    }
    
}
