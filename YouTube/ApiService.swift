//
//  ApiService.swift
//  YouTube
//
//  Created by leanid niadzelin on 01.05.17.
//  Copyright © 2017 Leanid Niadzelin. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrlString = "http://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchCurrentVideos(url: String, completion: @escaping ([Video]) -> ()) {
        let urlString = URL(string: baseUrlString + url)
        fetchVideos(urlString: urlString!, completion: completion)
    }
    
    func fetchVideos(urlString: URL, completion: @escaping ([Video]) -> ()) {
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                
            if  let unwrappedData = data,
                let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
                    DispatchQueue.main.async {
                        completion(jsonDictionaries.map({Video(dictionary: $0)}))
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        
    
    
    }.resume()
    }
    
}


//func fetchVideos(urlString: URL, completion: @escaping ([Video]) -> ()) {
//    URLSession.shared.dataTask(with: urlString) { (data, response, error) in
//        if error != nil {
//            print(error!)
//            return
//        }
//        do {
//            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//            
//            var videos = [Video]()
//            for dictionary in json as! [[String: AnyObject]] {
//                
//                let video = Video()
//                video.setValuesForKeys(dictionary)
//                video.title = dictionary["title"] as? String
//                video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                
//                let chanelDictionary = dictionary["channel"] as! [String: AnyObject]
//                let chanel = Chanel()
//                chanel.setValuesForKeys(chanelDictionary)
//                video.channel = chanel
//                
//                videos.append(video)
//            }
//            
//            DispatchQueue.main.async {
//                completion(videos)
//            }
//            
//        } catch let jsonError {
//            print(jsonError)
//        }
//        }.resume()

