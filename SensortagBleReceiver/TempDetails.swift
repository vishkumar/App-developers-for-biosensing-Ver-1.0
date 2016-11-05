//
//  TempDetails.swift
//  SensortagBleReceiver
//
//  Created by bhansali on 10/20/16.
//  Copyright © 2016 Yuuki NISHIYAMA. All rights reserved.
//

import UIKit
import Charts
class TempDetails: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var maxValue: UILabel!
    @IBOutlet weak var minValue: UILabel!
    @IBOutlet weak var barLineChartView: BarLineChartViewBase!
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        barLineChartView.noDataText = "This Line Graph is underconstruction!"
       
       // setChart(dataPoints: months, values: unitsSold)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBarChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "There is no data from sensor!"
        barChartView.noDataTextColor = UIColor.blue
     
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            //let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            let dataEntry = BarChartDataEntry(x: Double(i),y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Temperature in degree Farenheight")
        
       // let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        let myChartData =  BarChartData(dataSet: chartDataSet)

        
        barChartView.data = myChartData
        barChartView.descriptionText = ""
        barChartView.xAxis.labelPosition = .bottom
        //chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        //barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)

    }

    func setLineChart(dataPoints: [String], values: [Double]) {
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [75.0, 77.0, 80.0, 76.0, 78.0, 80.0, 75.0, 74.0, 78.0, 76.0, 76.0, 82.0]
        
        setBarChart(dataPoints: months, values: unitsSold)
    
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
