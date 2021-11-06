//
//  LoginViewController.swift
//  Twitter
//
//  Created by Efaz on 7/22/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: Any) {
        
        // Used to access the Twitter API
        let myUrl = "https://api.twitter.com/oauth/request_token"
        
        // Process to actually login to Twitter if the account if account is valid
        // It will perform a segue called "LoginToHome" to the Home Screen
        // If the account is not valid, it will print a message in the console
        TwitterAPICaller.client?.login(url: myUrl, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
            
        }, failure: { (Error) in
            print("Login Failed.")
        })
    }
    
    // If the account was previously logged into before, it will go straight into the home screen
    // Called when the view is loaded in completely
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }
    }
    
    // Called once when the controller is created
    override func viewDidLoad() {
        super.viewDidLoad()

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
