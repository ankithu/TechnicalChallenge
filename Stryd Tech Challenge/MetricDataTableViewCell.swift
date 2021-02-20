//
//  MetricDataTableViewCell.swift
//  Stryd Tech Challenge
//  Data table view cell holds the labels for the cells in the table showing detailed information about each specific metric
//  Created by Ankith Udupa on 2/20/21.
//

import UIKit

class MetricDataTableViewCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    ///UITABLEVIEW CELL FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }//awakeFromNib()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }//setSelected()

}//class
