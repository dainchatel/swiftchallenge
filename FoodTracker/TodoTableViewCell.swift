//
//  TodoTableViewCell.swift
//  FoodTracker
//
//  Created by Dain Chatel on 4/19/17.
//
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
