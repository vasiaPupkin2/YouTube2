//
//  HomeCell.swift
//  YouTube
//
//  Created by leanid niadzelin on 24.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class HomeCell: BaseCell {
    
    var video: Video? {
        didSet {
            
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let chanelName = video?.channel?.name, let numbersOfViews = video?.number_of_views {
                let numberFormater = NumberFormatter()
                numberFormater.numberStyle = .decimal
                let subtitleText = "\(chanelName) • \(String(describing: numberFormater.string(from: numbersOfViews)!)) • 2 years ago"
                
                textView.text = subtitleText
            }
            
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: attributes, context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightAnchor?.constant = 44
                } else {
                    titleLabelHeightAnchor?.constant = 20
                }
            }
        }
    }
    
    var titleLabelHeightAnchor: NSLayoutConstraint?
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profile_image_name {
            userPofileImageView.loadImageWith(urlString: profileImageUrl)
        }
    }

    func  setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            thumbnailImageView.loadImageWith(urlString: thumbnailImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userPofileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift - Blank space"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "TaylorSwiftVEVO • 1,688,345,567 views • 2 years ago"
        textView.textColor = .lightGray
        textView.contentInset = UIEdgeInsets(top: -8, left: -4, bottom: 0, right: 0)
        textView.font = UIFont.systemFont(ofSize: 10)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        //textView.isScrollEnabled = false
        return textView
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(userPofileImageView)
        addSubview(titleLabel)
        addSubview(textView)
        addSubview(separatorView)
        
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: userPofileImageView.topAnchor, constant: -8).isActive = true
        thumbnailImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        userPofileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        userPofileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -38).isActive = true
        userPofileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        userPofileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: userPofileImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        titleLabelHeightAnchor = titleLabel.heightAnchor.constraint(equalToConstant: 20)
        titleLabelHeightAnchor?.isActive = true
        
        
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        textView.leftAnchor.constraint(equalTo: userPofileImageView.rightAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        separatorView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
}
