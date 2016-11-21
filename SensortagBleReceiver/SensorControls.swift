//
//  SensorControls.swift
//  SensortagBleReceiver
//
//  Created by bhansali on 10/27/16.
//  Copyright © 2016 Yuuki NISHIYAMA. All rights reserved.
//

import UIKit

class SensorControls: UIViewController {

    var GetSensorControl : ViewController!
    
    @IBOutlet weak var powerSwitch: UISwitch!
    
    @IBOutlet weak var sleepSwitch: UISwitch!
    @IBOutlet weak var connectSwitch: UISwitch!
    @IBOutlet weak var deviceUUIDLabel: UILabel!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceRSSILabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetSensorControl = ViewController.init()
        GetSensorControl.view.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        self.view.addSubview(GetSensorControl.view)
        
        let timer = Timer(timeInterval: 4, target: self, selector: #selector(updatevalue), userInfo: nil, repeats: true)
        //        RunLoop.add(timer)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)

        
        deviceUUIDLabel.text = "69669875-95EB-A801-2143-6E4EDD8FB90B "
        deviceNameLabel.text = "nRF5x"
        deviceRSSILabel.text = "-78 dBm"
//        deviceUUIDLabel.text = "234234234"
//        deviceNameLabel.text = "fsdfsdfsdf"
//        deviceRSSILabel.text = "32"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        deviceUUIDLabel.text = "69669875-95EB-A801-2143-6E4EDD8FB90B "
        deviceNameLabel.text = "nRF5x"
        deviceRSSILabel.text = "-78 dBm"
    }
    
   
func updatevalue(){
//    deviceUUIDLabel.text = GetSensorControl.deviceUUIDValue
//    deviceNameLabel.text = GetSensorControl.deviceNameValue
//    deviceRSSILabel.text = GetSensorControl.deviceRSSIValue
    deviceUUIDLabel.text = "69669875-95EB-A801-2143-6E4EDD8FB90B "
    deviceNameLabel.text = "nRF5x"
    deviceRSSILabel.text = "-78 dBm"
    //        deviceUUIDLabel.text = "234234234"
    
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
