//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by LangDylan on 04/06/2017.
//  Copyright © 2017 Dylan Lang. All rights reserved.
//

import UIKit
import Twitter
class TweetTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Twitter.Tweet? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        tweetTextLabel?.text = tweet?.text
        tweetUserLabel?.text = tweet?.user.description
        
        if let profileImageURL = tweet?.user.profileImageURL{
            //MARK: block main thread
            if let imageData = try? Data(contentsOf: profileImageURL){
                tweetProfileImageView?.image = UIImage(data:imageData)
            }
        }else{
            tweetProfileImageView?.image = nil
        }
        
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            }else{
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from: created)
        }else{
            tweetCreatedLabel?.text = nil
        }
        
    }
    
    
    
    
}
