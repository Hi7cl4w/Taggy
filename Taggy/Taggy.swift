//
//  Taggy.swift
//  Taggy
//
//  Created by Manu K on 14/01/18.
//  Copyright © 2018 Manu K. All rights reserved.
//

import UIKit

@IBDesignable open class Taggy: _Taggy{
    public override func setTags(_ tags:Array<String>){
        self.tagsCount=tags.count
        self.tags=tags
    }
    public var delegate: TaggyDelegate?{
        didSet{
            self._delegate=delegate
        }
    }
    
    @IBInspectable var tagColor: UIColor=UIColor(red: 87.0/255.0, green: 190.0/255.0, blue: 212.0/255.0, alpha: 1.0){
        didSet {
            self._tagColor = tagColor
            setupTags()
        }
    }
    
    @IBInspectable var tagBorderColor: UIColor=UIColor.clear{
        didSet {
            self._tagBorderColor = tagBorderColor
            setupTags()
        }
    }
    
    @IBInspectable var tagTextColor: UIColor=UIColor.white{
        didSet {
            self._tagTextColor = tagTextColor
            setupTags()
        }
    }
    
    @IBInspectable var tagBackgroundColor: UIColor=UIColor.white{
        didSet {
            self._tagBackgroundColor = tagBackgroundColor
            setupTags()
        }
    }
}

@IBDesignable open class _Taggy: UIStackView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView:UICollectionView?
    public var _delegate:TaggyDelegate?
    
    @IBInspectable var tagsCount: Int = 10{
        didSet {
            if(tags.count<tagsCount){
                for index in tags.count...tagsCount-1 {
                    tags.insert("Tag \(index)", at: index)
                }
            }
            setupTags()
        }
    }
    
    var _tagColor: UIColor=UIColor(red: 87.0/255.0, green: 190.0/255.0, blue: 212.0/255.0, alpha: 1.0)
    
    var _tagBorderColor: UIColor=UIColor.clear
    
    var _tagTextColor: UIColor=UIColor.white
    
    var _tagBackgroundColor: UIColor=UIColor.white
    
    public var tags: Array<String> = [] {
        didSet {
            setupTags()
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTags()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
        setupTags()
    }
    
    public func setTags(_ tags:Array<String>){
        self.tagsCount=tags.count
        self.tags=tags
    }
    
    private func setCollectionView(){
        if(collectionView==nil){
            let layout: TaggyAlignLayout = TaggyAlignLayout()
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing=0
            layout.minimumInteritemSpacing=0
            layout.itemSize=CGSize.init(width: 100, height: 35)
            self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
            collectionView?.delegate   = self
            collectionView?.dataSource = self
            let bundle = Bundle(for: self.classForCoder)
            let taggyCell = UINib(nibName: "TaggyCell", bundle: bundle)
            self.collectionView?.register(taggyCell, forCellWithReuseIdentifier: "taggycell")
            collectionView?.backgroundColor = _tagBackgroundColor
            collectionView?.isScrollEnabled=false
            addArrangedSubview(collectionView!)
        }
        
        if let collectionView=collectionView{
            collectionView.reloadData()
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "taggycell", for: indexPath) as! TaggyCell
        cell.button.tag = indexPath.item
        cell.button.addTarget(self, action: #selector(_Taggy.didTagSelected(_:)), for: .touchUpInside)
        cell.tagColor=_tagColor
        cell.tagTextColor=_tagTextColor
        cell.tagBorderColor=_tagBorderColor
        if indexPath.row<tags.count{
            cell.title=tags[indexPath.row]
        }
        return cell
    }
    
    @objc func didTagSelected(_ sender: UIButton) {
        _delegate?.didSelectTagAt(index: sender.tag, title: tags[sender.tag])
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "taggycell", for: indexPath) as! TaggyCell
        if indexPath.row<tags.count{
            _delegate?.didSelectTagAt(index: indexPath.row, title: tags[indexPath.row])
        }
    }
    
    
    
    @objc func collectionView(_ collectionView: UICollectionView,
                              layout collectionViewLayout: UICollectionViewLayout,
                              sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize{
        if indexPath.row<tags.count{
            let button=UIButton.init()
            button.setTitle(tags[indexPath.row], for: .normal)
            button.sizeToFit()
            return CGSize.init(width: button.frame.size.width+20, height: 35)
        }
        let size=CGSize.init(width: 100, height: 35)
        return size
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsCount
    }
    
    func setupTags() {
        setCollectionView()
    }
    
}

public protocol TaggyDelegate {
    func didSelectTagAt(index:Int,title:String)
}
