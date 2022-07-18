//
//  menuCell.swift
//  iEntry
//
//  Created by ZAFAR on 11/08/2021.
//

import UIKit

class menuCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lbltile: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let bgColorView = UIView()
        
        
        if selected {
//        bgColorView.layer.cornerRadius = 5
//        bgColorView.backgroundColor =  #colorLiteral(red: 0.3902164102, green: 0.6604216099, blue: 0.6162803769, alpha: 1)
//                self.selectedBackgroundView = bgColorView
            self.img.tintColor = .white
            self.lbltile.textColor = .white
            bgView.backgroundColor = #colorLiteral(red: 0.3902164102, green: 0.6604216099, blue: 0.6162803769, alpha: 1)
            bgView.layer.cornerRadius = 5
        } else {
//            bgColorView.layer.cornerRadius = 5
//            bgColorView.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                    self.selectedBackgroundView = bgColorView
            self.img.tintColor = .white
            self.lbltile.textColor = .black
            bgView.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            bgView.layer.cornerRadius = 5
        }
        
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
          super.setHighlighted(highlighted, animated: animated)
          
          if highlighted {
              self.lbltile.textColor = .white
              self.img.tintColor = .white
          } else {
              self.lbltile.textColor = .black
              self.img.tintColor = .black
          }
      }
}
