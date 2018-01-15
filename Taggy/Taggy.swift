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
    
    @IBInspectable var tagHighlightColor: UIColor=UIColor(red: 234.0/255.0, green: 59.0/255.0, blue: 128.0/255.0, alpha: 1.0){
        didSet {
            self._tagHighlightColor = tagHighlightColor
            setupTags()
        }
    }
    
    @IBInspectable var tagBorderHighlightColor: UIColor=UIColor(red: 234.0/255.0, green: 59.0/255.0, blue: 128.0/255.0, alpha: 1.0){
        didSet {
            self._tagBorderHighlightColor = tagBorderHighlightColor
            setupTags()
        }
    }
    
    @IBInspectable var tagTextHighlightColor: UIColor=UIColor.white{
        didSet {
            self._tagTextHighlightColor = tagTextHighlightColor
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
    
    var _tagHighlightColor: UIColor=UIColor(red: 234.0/255.0, green: 59.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    
    var _tagBorderHighlightColor: UIColor=UIColor(red: 234.0/255.0, green: 59.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    
    var _tagTextHighlightColor: UIColor=UIColor.white
    
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
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            layout.minimumLineSpacing=5
            layout.minimumInteritemSpacing=5
            layout.itemSize=CGSize.init(width: 100, height: 32)
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
            let size=collectionView.collectionViewLayout.collectionViewContentSize
            collectionView.frame.size=CGSize.init(width: collectionView.frame.size.width, height:  size.height)
            self.frame=collectionView.frame
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "taggycell", for: indexPath) as! TaggyCell
        cell.button.tag = indexPath.item
        cell.button.addTarget(self, action: #selector(_Taggy.didTagSelected(_:)), for: .touchUpInside)
        cell.tagColor=_tagColor
        cell.textColor=_tagTextColor
        cell.borderColor=_tagBorderColor
        cell.textHighlightColor=_tagTextHighlightColor
        cell.highlightColor=_tagHighlightColor
        cell.borderHighlightColor=_tagBorderHighlightColor
        if ((_delegate?.tagForItemAt) != nil){
            _delegate?.tagForItemAt!(index: indexPath.row, taggyCell: cell)
        }
        if indexPath.row<tags.count{
            cell.title=tags[indexPath.row]
        }
        return cell
    }
    
    @objc func didTagSelected(_ sender: UIButton) {
        setButtonSelected(sender)
        _delegate?.didSelectTagAt(index: sender.tag, title: tags[sender.tag])
    }
    
    func setButtonSelected(_ button: UIButton){
        if let cells=collectionView?.visibleCells as? [TaggyCell]{
            for cell in cells{
                if cell.button.isSelected==true{
                    cell.setTagSelected(false)
                }
            }
        }
        button.layer.borderWidth=0
        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5,delay: 0,usingSpringWithDamping: 5,initialSpringVelocity: 2.0,options: .allowUserInteraction,animations: { [weak self] in
            button.isSelected=true
            button.backgroundColor=self?._tagHighlightColor
            button.transform = .identity
            },completion: nil)
        button.layer.borderColor=self._tagBorderHighlightColor.cgColor
        button.layer.borderWidth=1
        
    }
    
    func setSelectedAt(){
        
    }
    
    
    @objc func collectionView(_ collectionView: UICollectionView,
                              layout collectionViewLayout: UICollectionViewLayout,
                              sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize{
        if indexPath.row<tags.count{
            let button=UIButton.init()
            button.setTitle(tags[indexPath.row], for: .normal)
            button.sizeToFit()
            return CGSize.init(width: button.frame.size.width+20, height: 32)
        }
        let size=CGSize.init(width: 100, height: 32)
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

@objc public protocol TaggyDelegate {
    func didSelectTagAt(index:Int,title:String)
    @objc optional func tagForItemAt(index: Int, taggyCell: TaggyCell)
}
