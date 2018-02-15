//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by siddhant on 2/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire


class ProfileViewController: UIViewController {

    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var user: User! {
        didSet {
           
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = 9
        profileImage.clipsToBounds = true
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
