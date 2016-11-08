//
//  ViewController.swift
//  Biosensor App
//
//  Created by bhansali on 10/7/16.
//  Copyright © 2016 Vishal. All rights reserved.
//

import UIKit

class LoginPage: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        
        if(userNameField.text != "vish" && passwordField.text != "123"){
            var alert : UIAlertView = UIAlertView(title: "Login Failed", message: "Please enter correct username and password",       delegate: nil, cancelButtonTitle: "OK")
            
            alert.show()
        }
        else{
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "afterLogin") as! UITabBarController
            nextViewController.selectedIndex = 0
            
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var loginBtn: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

