//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by siddhant on 2/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var tweetTextView: UITextView!
    
     var charCount = 0;
    @IBOutlet weak var characterCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.layer.cornerRadius = 8
        tweetTextView.clipsToBounds = true
        tweetTextView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return charCount < 140 || text == ""
    }
    func textViewDidChange(_ textView: UITextView) {
        charCount = tweetTextView.text.characters.count
        characterCountLabel.text = "\(charCount)"
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TimelineViewController") as! TimelineViewController
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                //self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        
    }

}
