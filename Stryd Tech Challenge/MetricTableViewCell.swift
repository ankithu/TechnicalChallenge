//
//  MetricTableViewCell.swift
//  Stryd Tech Challenge
//  Metric Table View Cell handles the metric heading and average labels in the first page of the application
//  Created by Ankith Udupa on 2/20/21.
//

import UIKit

class MetricTableViewCell: UITableViewCell {

    //outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var outputValue: UILabel!
    
    ///TABLEVIEWCELL SPECIFIC FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }//awakeFromNib()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }//setSelected()

}//class
