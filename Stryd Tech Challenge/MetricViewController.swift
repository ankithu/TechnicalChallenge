//
//  MetricViewController.swift
//  Stryd Tech Challenge
//  Final Page of the app which shows a detailed view of the desiered metric
//  Created by Ankith Udupa on 2/20/21.
//

import UIKit

class MetricViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    //outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var metricNameLabel: UILabel!
    
    //data members that will be passed from original view controller
    var metricData : [[Double]] = []
    var metricHeadings : [String] = []
    var units: [String] = []
    var index : Int = 0
    
    ///TABLEVIEW FUNCTIONS
    
    //update cells in tableview with number of seconds and the value of interest. Use passed index value to determine correct output
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metricDataIdentifier") as! MetricDataTableViewCell;
        let secondsString = convertToSecondsString(input: indexPath.row);
        cell.label.text = "    " + secondsString;
        cell.dataLabel.text = "\(metricData[index][indexPath.row].truncate(places: 3)) " + units[index]
        return cell;
    }//tableView()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }//numberOfSections()
    
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metricData[index].count;
    }//tableView()
    
    
    ///VIEW CONTROLLER SPECIFIC FUNCTIONS

    override func viewDidLoad() {
        super.viewDidLoad()
        metricNameLabel.text = metricHeadings[index];
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 10
    }//viewDidLoad()
    
    ///UTILITY
    
    //converts index to a string representing seconds
    func convertToSecondsString(input: Int) -> String{
        let true_input = input + 1
        let minutes = true_input / 60
        let seconds = true_input % 60
        var minutesString = ""
        var secondsString = ""
        if (minutes < 10){
            minutesString = "0\(minutes)"
        }
        else{
            minutesString = "\(minutes)"
        }
        if (seconds < 10){
            secondsString = "0\(seconds)"
        }
        else{
            secondsString = "\(seconds)"
        }
        return minutesString + ":" + secondsString;
    }//convertToSecondsString()
    
    
}//class

