 //
//  socialShare.swift
//  igniteApp
//
//  Created by tesco on 24/08/17.
//  Copyright © 2017 tesco. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit
import FBSDKShareKit
import FBSDKLoginKit
import FacebookCore
import FacebookShare

class socialShare: UIViewController {

    @IBOutlet var facebookPostButton: UIButton!
    @IBOutlet var timelineView: UIView!
    var fbShareButton: FBSDKShareButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TweetsTimeline")
        self.addChildViewController(vc)
        vc.view.frame = CGRect(x: 0, y: 140, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-140)
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }

    @IBOutlet var showTimeline: UITableView!
    
    @IBAction func twitterButton(_ sender: Any) {

        if (Twitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            // App must have at least one logged-in user to compose a Tweet
            let composer = TWTRComposerViewController.emptyComposer()
            let composedTweet = TWTRComposer()
            composedTweet.setText("@AngelaAnamika #igniteDay")
            composedTweet.show(from: self) { result in
                if (result == TWTRComposerResult.cancelled) {
                    print("Tweet composition cancelled")
                }
                else {
                    print("Sending tweet!")
                }
            }
            present(composer, animated: true, completion: nil)
            
        } else {
            // Log in, and then check again
            Twitter.sharedInstance().logIn { session, error in
                if session != nil { // Log in succeeded
                    let composer = TWTRComposerViewController.emptyComposer()
                    self.present(composer, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
    
    
    
    @IBAction func postOnFacebook(_ sender: Any) {
        do{
            var myContent = LinkShareContent(url: URL(string: "http://www.facebook.com/TescoBengaluru/")!)
            myContent.hashtag = Hashtag("#8MWC")
            
            let shareDialog = ShareDialog(content: myContent)
            shareDialog.mode = .feedWeb
            shareDialog.failsOnInvalidData = true
            shareDialog.completion = { result in
                switch result {
                case .success:
                    print("Share succeeded")
                case .failed:
                    print("failed")
                case .cancelled:
                    print("Share cancelled")
                }
            }
            
            try shareDialog.show()
        } catch {
            print("Error: \(error)")
        }
    }
}



