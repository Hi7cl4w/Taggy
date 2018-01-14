//
//  Taggy.swift
//  Taggy
//
//  Created by Manu K on 14/01/18.
//  Copyright © 2018 Manu K. All rights reserved.
//

import UIKit

@IBDesignable open class Taggy: UIStackView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView:UICollectionView?
    
    @IBInspectable var tagsCount: Int = 2 {
        didSet {
            for index in tags.count...tagsCount-1 {
                tags.insert(" ", at: index)
            }
            setupButtons()
            collectionView?.reloadData()
        }
    }
    
    @IBInspectable var tagBackgroundColor: UIColor=UIColor.white{
        didSet {
             collectionView?.backgroundColor = tagBackgroundColor
        }
    }
    
    var tags: Array<String> = [] {
        didSet {
            setupButtons()
            collectionView?.reloadData()
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func setCollectionView(){
        if(collectionView==nil){
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
            collectionView?.delegate   = self
            collectionView?.dataSource = self
            let bundle = Bundle(for: self.classForCoder)
            let taggyCell = UINib(nibName: "TaggyCell", bundle: bundle)
            self.collectionView?.register(taggyCell, forCellWithReuseIdentifier: "taggycell")
            collectionView?.backgroundColor = tagBackgroundColor
            addArrangedSubview(collectionView!)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "taggycell", for: indexPath) as! TaggyCell
        if indexPath.row<tags.count{
            cell.title=tags[indexPath.row]
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "taggycell", for: indexPath) as! TaggyCell
    }
    
    @objc func collectionView(_ collectionView: UICollectionView,
                              layout collectionViewLayout: UICollectionViewLayout,
                              sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize{
        if indexPath.row<tags.count{
            let button=UIButton.init()
            button.setTitle(tags[indexPath.row], for: .normal)
            button.sizeToFit()
            print(button.frame.size)
            return CGSize.init(width: button.frame.size.width+10, height: 30)
        }
        var size=CGSize.init(width: 100, height: 30)
        return size
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsCount
    }
    
    private func setupButtons() {
        setCollectionView()
    }
    
}
