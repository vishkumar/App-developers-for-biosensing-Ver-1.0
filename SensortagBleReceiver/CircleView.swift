//
//  CircleView.swift
//  Biosensor App
//
//  Created by bhansali on 10/8/16.
//  Copyright © 2016 Vishal. All rights reserved.
//

import UIKit
class CircleView: UIViewController {

    let makeCircle = MainInterface()
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var mergeText: UITextField!
    
    var parentConnector : ViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        //mergeText.text=randomText
//        makeCircle.frame =  CGRectMake(0, 150, self.view.frame.width, self.view.frame.height*0.8)
//        makeCircle.backgroundColor = UIColor.clearColor()
//        myView.addSubview(makeCircle)
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        makeCircle.frame =  CGRect(x: 0, y: 150, width: self.view.frame.width, height: self.view.frame.height*0.8)
        makeCircle.backgroundColor = UIColor.clear
        myView.addSubview(makeCircle)
    }
}
