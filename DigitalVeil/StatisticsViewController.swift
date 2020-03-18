//
//  StatisticsViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 18/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    //Spinner initiallization
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var graphic: PieChartView!
    
    @IBOutlet weak var rangeSelector: UISegmentedControl!
    
    //Initializers
    var statistics: [String : Double] = [:]
    var usageTimeApps = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphic.chartDescription?.text = ""
//        //Get the relative data and populate the stadistics array
//        getUserGraphs()
//        //Set the relative data to the chart
//        setGraphs(statistics: statistics, offset: 0)
//        //Update the graph
//        updateChartData()
    }
    
    //Request function to get the relative data to the user
    func getUserGraphs() {
        //Start loading animation of the spinner
        DataHelpers.toggleLoadingSpinner(animate: true, activityIndicator: activityIndicator)
        
        //Make the fake data request
        NetworkUtils.getUserGraphs(completion: {
            response in
            
            if let graphs = response {
                self.statistics = graphs
            } else {
                //Alert message
                self.present(DataHelpers.displayAlert(userMessage: "Something went wrong! Try again later", alertType: 0), animated: true, completion: nil)
                
                self.statistics.removeAll()
            }
            
            DataHelpers.toggleLoadingSpinner(animate: false, activityIndicator: self.activityIndicator)
        })
    }
    
    // Actualice the piechart elements
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: usageTimeApps, label:nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        //Array of colors
        let colors = [UIColor.init(red: 127/255, green: 0/255, blue: 0/255, alpha: 0.5),UIColor.init(red: 255/255, green: 77/255, blue: 77/255, alpha: 1),UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1),UIColor.init(red: 128/255, green: 38/255, blue: 38/255, alpha: 0.5),UIColor.init(red: 204/255, green: 0/255, blue: 0/255, alpha: 1),UIColor.init(red: 178/255, green: 0/255, blue: 0/255, alpha: 1)]
        
        //Color setting
        chartDataSet.colors = colors
        chartDataSet.valueTextColor = UIColor.white
        
        //Graph general customization
        graphic.data = chartData
        graphic.holeColor = UIColor.clear
        graphic.legend.textColor = UIColor.white
    }
    
    //Function called to populate data of the graphs view
    func setGraphs(statistics: [String:Double], offset: Int) {
        var usageTime: [PieChartDataEntry] = []
        
        for (stringLabel, doubleValue) in statistics {
            let app = PieChartDataEntry(value: 0)
            var newDoubleValue: Double = doubleValue
            
            //Value assignment
            app.label = stringLabel
            if (offset == 1){
                //Set the week values to an aproximated value by the week days in order to change a little the data and make it look real
                newDoubleValue = doubleValue * 7.2
            } else if (offset == 2){
                //Set the month values to an aproximated value by the month days in order to change a little the data and make it look real
                newDoubleValue = doubleValue * 7.2 * 3.9
            }
            app.value = newDoubleValue
            
            //Append the data to the array of PieChartDataEntry type in order to use it on the graphs and show the data
            usageTime.append(app)
        }
        
        //Set the array that will be used to set the graph values
        usageTimeApps = usageTime
        //Update the chart config
        updateChartData()
    }
    
    //Function that sets all the fake data on the graphs depending on the index of the selector
    @IBAction func rangeChange(_ sender: Any) {
        switch rangeSelector.selectedSegmentIndex {
        case 0:
            //Simuation of the request
            getUserGraphs()
            //Set the graphs with te new data
            setGraphs(statistics: statistics, offset: 0)
            break
        case 1:
            //Simuation of the request
            getUserGraphs()
            //Set the graphs with the new data
            setGraphs(statistics: statistics, offset: 1)
            break
        case 2:
            //Simuation of the request
            getUserGraphs()
            //Set the graphs with the new data
            setGraphs(statistics: statistics, offset: 2)
            break
        default:
            break
        }
    }
}
