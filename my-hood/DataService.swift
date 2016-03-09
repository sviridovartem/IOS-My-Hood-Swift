//
//  DataService.swift
//  my-hood
//
//  Created by Admin on 09/03/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post]()
    var loadedPost:[Post]{
        return _loadedPosts
    }
    func savePost(){
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadPosts(){
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData{
            
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post]{
                _loadedPosts = postsArray
            }
        }
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postLoaded", object: nil))
    }
    
    func saveImgAndCreatePath(image:UIImage)->String{
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFileName(imgPath)
        imgData?.writeToFile(fullPath, atomically: true)
        return imgPath
    }
    
    func imgForPath(path:String)->UIImage?{
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    func addPost(post:Post){
        _loadedPosts.append(post)
        savePost()
        loadPosts()
    }
    
    func documentsPathForFileName(name:String)->String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.stringByAppendingPathComponent(name)
    }
}