//
//  MenuBar.swift
//  YouTube
//
//  Created by leanid niadzelin on 25.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    var homeController: HomeController?
    var horizontalViewLeftAnchor: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 31, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        let selectedItem = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedItem, animated: false, scrollPosition: .left)
        
        setupHorizontalBar()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupHorizontalBar() {
        let horizontalView = UIView()
        horizontalView.backgroundColor = .white
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalView)
        
        horizontalViewLeftAnchor = horizontalView.leftAnchor.constraint(equalTo: leftAnchor)
        horizontalViewLeftAnchor?.isActive = true
        horizontalView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        horizontalViewLeftAnchor?.constant = CGFloat(indexPath.item) * (frame.width / 4)
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//            self.layoutIfNeeded()
//        }, completion: nil)
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
