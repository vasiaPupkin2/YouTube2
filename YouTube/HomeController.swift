//
//  ViewController.swift
//  YouTube
//
//  Created by leanid niadzelin on 24.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let homeCellId = "homeCellId"
    let trendingCellId = "trendingCellId"
    let subscriptionsCellId = "subscriptionsCellId"
    let accountCellId = "accountCellId"
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    let redBackgroundView: UIView = {
        let bv = UIView()
        bv.backgroundColor = UIColor.rgb(red: 230, green: 31, blue: 31)
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.hidesBarsOnSwipe = true
        
        
        
    
        setupCollectionView()
        setupNavigationTitle()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupCollectionView() {
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeControllerCell.self, forCellWithReuseIdentifier: homeCellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellId)
        collectionView?.register(AccountCell.self, forCellWithReuseIdentifier: accountCellId)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
    }
    
    
    
    func setupNavigationTitle() {
        let navigationTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationTitle.textColor = .white
        navigationTitle.font = UIFont.systemFont(ofSize: 20)
        navigationTitle.text = "  Home"
        navigationItem.titleView = navigationTitle
    }
    
    func setupTitleForIndex(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    func setupMenuBar() {
        view.addSubview(redBackgroundView)
        redBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        redBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        redBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        redBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    func handleSearch() {
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
        setupTitleForIndex(index: menuIndex)
    }
    
    
    lazy var settingLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    func handleMore() {
            settingLauncher.showSettings()
    }
    
    func showController(setting: Setting) {
        let dummyController = UIViewController()
        dummyController.view.backgroundColor = .white
        dummyController.title = setting.titleName.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.show(dummyController, sender: self)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalViewLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: item, section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        
       setupTitleForIndex(index: item)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indentifier: String
        if indexPath.item == 1 {
            indentifier = trendingCellId
        } else if indexPath.item == 2 {
            indentifier = subscriptionsCellId
        } else if indexPath.item == 3 {
            indentifier = accountCellId
        } else {
            indentifier = homeCellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.reloadData()
        navigationController?.reloadInputViews()
    }
    

}



