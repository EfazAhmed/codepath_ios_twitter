//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Efaz on 7/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    
    // Declaring dictionaries
    var dict = NSDictionary()
    var followings = NSDictionary()
    
    
    // Creating our outlets from our storyboard
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var tagLineLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    
    // Returns the usere to the home page
    @IBAction func home(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // URL for account creds
        let url = "https://api.twitter.com/1.1/account/verify_credentials.json"
        
        
        TwitterAPICaller.client?.getDictionaryRequest(url: url, parameters: ["include_entities": false], success: { (dict: NSDictionary) in
            let prof_img_url = URL(string: "\(dict["profile_image_url_https"]!)")
            let tag_line = "\(dict["description"]!)"
            let userId = "\(dict["id"]!)"
            let screenName = "\(dict["name"]!)"
            let followerCount = "\(dict["followers_count"]!)"
            let followingCount = "\(dict["following"]!)"
            
            print(followerCount + "-follower")
            print(followingCount + "-following")
            
            let myUrl = "https://api.twitter.com/1.1/users/profile_banner.json"
            TwitterAPICaller.client?.getDictionaryRequest(url: myUrl, parameters: ["screen_name": screenName], success: { (users: NSDictionary) in
                let sizes = users["sizes"] as! NSDictionary
                let selection = sizes["1080x360"] as! NSDictionary
                let banner_url_string = selection["url"] as! String
                let banner_img_url = URL(string: banner_url_string)
                
                self.bannerImageView.af_setImage(withURL: banner_img_url!)
                
            }, failure: { (Error) in
                print(Error)
            })
            
            
//            let userIdURL = "https://api.twitter.com/2/users/:id/tweets"
//            TwitterAPICaller.client?.getDictionaryRequest(url: userIdURL, parameters: ["id": userId], success: { (tweets: NSDictionary) in
//                print(tweets)
//
//            }, failure: { (Error) in
//                print(Error)
//            })
            
            self.profileImageView.layer.borderWidth = 5
            self.profileImageView.layer.borderColor = UIColor.black.cgColor
            self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width/2
            
            self.tagLineLabel.text = tag_line
            self.profileImageView.af_setImage(withURL: prof_img_url!)
            self.userNameLabel.text = screenName
            self.followersLabel.text = followerCount
            //self.followingLabel.text = followingCount
            
            
        }, failure: { (Error) in
            print("Error 1")
        })
        
        
        
        
     
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
