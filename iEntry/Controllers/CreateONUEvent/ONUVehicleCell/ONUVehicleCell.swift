//
//  ONUVehicleCell.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit

class ONUVehicleCell: UITableViewCell {

    @IBOutlet weak var lblplate: UILabel!
    @IBOutlet weak var lblvin: UILabel!
    @IBOutlet weak var lblsubbrand: UILabel!
    @IBOutlet weak var lblbrand: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
