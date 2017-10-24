//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by leanid niadzelin on 28.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        let set = Setting(titleName: .set, imageName: "settings")
        let privacy = Setting(titleName: .privacy, imageName: "privacy")
        let feedback = Setting(titleName: .feedback, imageName: "feedback")
        let help = Setting(titleName: .help, imageName: "help")
        let switchAccount = Setting(titleName: .switchAccount, imageName: "switch_account")
        let cancel = Setting(titleName: .cancel, imageName: "cancel")
        return [set, privacy, feedback, help, switchAccount, cancel]
    }()
    
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    var homeController: HomeController?
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let heightOfCollectionView: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - heightOfCollectionView
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heightOfCollectionView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
    }
    
    
    func handleDismiss(_ setting: Setting) {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 0
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: { (completion: Bool) in
                
                if setting.titleName != .cancel {
                    self.homeController?.showController(setting: setting)
                }
            })
            
            
        }
    }
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handleDismiss(setting)
    }
    
    
    
    
    
    
    
}
