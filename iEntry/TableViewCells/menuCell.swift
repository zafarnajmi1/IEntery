//
//  menuCell.swift
//  iEntry
//
//  Created by ZAFAR on 11/08/2021.
//

import UIKit

class menuCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var lbltile: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
