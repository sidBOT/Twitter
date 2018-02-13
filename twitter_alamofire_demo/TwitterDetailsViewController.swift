//
//  TwitterDetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by siddhant on 2/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TwitterDetailsViewController: UIViewController {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tweet = tweet {
            tweetLabel.text = tweet.text
            likeLabel.text = String(describing: tweet.favoriteCount!)
            retweetLabel.text = String(tweet.retweetCount)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func replyButtonAction(_ sender: Any) {
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        if ( tweet?.favorited != true) {
            
            tweet.favoriteCount = tweet.favoriteCount! + 1
            likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            likeLabel.text = String(tweet.favoriteCount!)
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
            likeLabel.text = String(tweet.favoriteCount!)
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
            retweetLabel.text = String(tweet.retweetCount)
            
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
            retweetLabel.text = String(tweet.retweetCount)
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
