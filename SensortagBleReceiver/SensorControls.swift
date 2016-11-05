//
//  SensorControls.swift
//  SensortagBleReceiver
//
//  Created by bhansali on 10/27/16.
//  Copyright © 2016 Yuuki NISHIYAMA. All rights reserved.
//

import UIKit

class SensorControls: UIViewController {

    @IBOutlet weak var powerSwitch: UISwitch!
    
    @IBOutlet weak var sleepSwitch: UISwitch!
    @IBOutlet weak var connectSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
