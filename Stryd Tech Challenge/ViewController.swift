//
//  ViewController.swift
//  Stryd Tech Challenge
//  First page of the application which shows the metric headings and averages and allows a user to click on a specific headidng
//  Created by Ankith Udupa on 2/20/21.
//

import UIKit



//easy way to truncate to a specific number of desired digits for better display
extension Double
{
   
    func truncate(places : Int)-> Double
    {
        var totalPlaces = 0
        if (self != 0.0){
            totalPlaces = Int(log10(self) + 1)
        }//if
        let decimalPlaces = places - totalPlaces
        return Double(floor(pow(10.0, Double(decimalPlaces)) * self)/pow(10.0, Double(decimalPlaces)))
    }//truncate()
}//extension

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    //outlets
    @IBOutlet weak var runLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //instance variables
    private var metricHeadings: [String] = []
    private var metricData: [[Double]] = [] //works by holding each double array of interest in the same order as headings
    private var units: [String] = [] //units of measurement in the same order of headings
    private var runName : String = "Loading Data..."
    private var selectedIndex = -1; //which index the user selects to view
    
    
    ///TABLE VIEW SPECIFIC METHODS
    
    //upddates cell in table with either the data of interest or with a loading string if data isn't ready
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "metricIdentifier") as! MetricTableViewCell;
        let text = metricHeadings[indexPath.row];
        cell.label.text = text;
        //if the data is ready to be displayed
        if (metricData.count > 0){
            //sets the output value to the average of the sepcific data array we care about (index = row number)
            cell.outputValue.text = "\(calculateAverage(input: metricData[indexPath.row])) " + units[indexPath.row] + "  ⮕"
        }//if
        else{
            //if data not ready just say loading
            cell.outputValue.text = "loading";
        }//else
        
        return cell;
    }//tableView()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }//numberOfSections()
    
    //numRows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metricHeadings.count
    }//tableView()
    
    //handles user input on any of the rows of the table, sets the selection variable and then performs segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row;
        self.performSegue(withIdentifier: "presentMetric", sender: self)
    }//tableView()
    
    
    ///TRANSITION HANDLER
    
    //creates new view and sends relevant data including selection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let metricViewCont = segue.destination as! MetricViewController
        metricViewCont.metricData = self.metricData
        metricViewCont.units = self.units
        metricViewCont.metricHeadings = self.metricHeadings
        metricViewCont.index = selectedIndex
        //metricViewCont.modalPresentationStyle = .fullScreen
    }//prepare()
    
    ///HTTP HANDLER
    
    //gets data from API, turns it into a JSON object, extracts relevant data, then calls async updatetable method and updates run label
    func getData(){
        let url = URL(string: "https://www.stryd.com/b/interview/data");
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error)
            in
            if let error = error {
                print("ERROR WITH HTTP REQUEST \(error)")
                return
            }//if
            do {
              if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                // Get value by key
                self.runName = convertedJsonIntoDict["name"] as! String
                self.metricData.append(convertedJsonIntoDict["total_power_list"] as! [Double])
                self.metricData.append(convertedJsonIntoDict["heart_rate_list"] as! [Double])
                self.metricData.append(convertedJsonIntoDict["speed_list"] as! [Double])
                self.updateTable();
               }//if
            }//do
            catch let error as NSError {
                print(error.localizedDescription)
            }//catch
        }//task
        task.resume();
    }//getData()
    
    //asyncronously tells the tableview to update
    func updateTable(){
        DispatchQueue.main.async {
            self.tableView.beginUpdates();
            self.tableView.reloadData();
            self.tableView.endUpdates();
            self.runLabel.text = self.runName;
        }//Dispatch.main.async
    }//updateTable()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Sets up original runLabel text and fills up heading and unit lists
        self.runLabel.text = "Loading..."
        metricHeadings.append("Power")
        metricHeadings.append("Heart Rate")
        metricHeadings.append("Speed")
        units.append("W")
        units.append("BPM")
        units.append("m/s")
        //initializes tableview
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 10
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 66
        //fetch data
        getData();
        
    }//viewDidLoad()
    
    
    ///UTILITY
    
    //calcualtes average of data array
    func calculateAverage(input: [Double]) -> Double{
        let sum = input.reduce(0, +)
        return (Double(sum) / Double(input.count)).truncate(places: 3);
    }//calculateAverage()
    
}//class

