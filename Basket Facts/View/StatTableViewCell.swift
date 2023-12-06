//
//  StatTableViewCell.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 12/4/23.
//

import UIKit

class StatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var StatBubbleView: UIView!
    
    @IBOutlet weak var statName: UILabel!
    
    @IBOutlet weak var stat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        StatBubbleView.layer.cornerRadius = StatBubbleView.frame.height / 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
