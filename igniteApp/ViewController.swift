//
//  ViewController.swift
//  igniteApp
//
//  Created by tesco on 23/08/17.
//  Copyright © 2017 tesco. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 480, width: view.frame.width-32, height: 50)
        loginButton.delegate = self
        loginButton.publishPermissions = ["publish_actions"]
        
        //login button setup
        let logInButton = TWTRLogInButton { (session, error) in
            guard let unwrappedSession = session
                
                else {//early return if error
                print("Login error: %@", error!.localizedDescription);
                return
            }
            let alert = UIAlertController(title: "Logged In",
                                          message: "User \(unwrappedSession.userName) has logged in",
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        logInButton.center = CGPoint(x: self.view.center.x, y: 25 + logInButton.frame.size.height)
        self.view.addSubview(logInButton)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton, didCompleteWith result: FBSDKLoginManagerLoginResult, error: Error!) {
        if ((error) != nil)
        {
            print(error)
            
        } else {
            let socialShare = self.storyboard!.instantiateViewController(withIdentifier: "loginIds") as UIViewController
            self.present(socialShare, animated: true, completion: nil)
            print("Successfully logged in")
            print("didCompleteWithResult")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

