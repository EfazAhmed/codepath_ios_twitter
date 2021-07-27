//
//  TweetViewController.swift
//  Twitter
//
//  Created by Efaz on 7/24/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if !tweetTextView.text.isEmpty {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: {(Error) in
                print("Error posting tweet \(Error)")
            })
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        characterCountLabel.text = "280 Characters Remaining"
        

//         Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        
        let updateText = String(characterLimit - newText.count)
        characterCountLabel.text = "\(updateText) Characters Remaining"
        return newText.count < characterLimit
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
