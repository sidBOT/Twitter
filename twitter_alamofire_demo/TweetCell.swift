//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

//import AlamofireImage
import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    var tweet: Tweet! {
        didSet {
            userNameLabel.text = tweet.user.name
            tweetTextLabel.text = tweet.text
            
            likeCountLabel.text = String(tweet.favoriteCount!)
            
            retweetCountLabel.text = String(tweet.retweetCount)
            
            if(tweet.favorited)!{
                self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
                
            } else{
                self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal) }
            
            if(tweet.retweeted){
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            } else{
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal) }
            
            
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        if ( tweet?.favorited != true) {
            
            tweet.favoriteCount = tweet.favoriteCount! + 1
            likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            likeCountLabel.text = String(tweet.favoriteCount!)
            tweet.favorited = true
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print(error.localizedDescription)
                    
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            
            tweet.favoriteCount = tweet.favoriteCount! - 1
            
            likeButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            likeCountLabel.text = String(tweet.favoriteCount!)
            tweet.favorited = false
            
            APIManager.shared.unfavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print(error.localizedDescription)
                    
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    @IBAction func retweetButtonAction(_ sender: Any) {
        if ( tweet?.retweeted != true) {
            
            tweet.retweetCount += 1
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            //retweetButton.setTitle(String(describing: tweet.retweetCount), for: UIControlState.normal )
            retweetCountLabel.text = String(tweet.retweetCount)

            tweet.retweeted = true
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("Successfully retweed the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            tweet.retweetCount -= 1
            
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            retweetCountLabel.text = String(tweet.retweetCount)
            tweet.retweeted = false
            
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print(error.localizedDescription)
                    
                } else if let tweet = tweet {
                    print("unretweeted")
                }
            }
        }
        
    }
    
    
}
