//
//  Helpers.swift
//  YouTube
//
//  Created by leanid niadzelin on 24.04.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageWith(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            
            
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let imageToCache = UIImage(data: data!)
            
            if self.imageUrlString == urlString {
                DispatchQueue.main.async {
                    self.image = imageToCache
                }
            }
            imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
    
}



