//
//  OrderHistoryCell.swift
//  iEntry
//
//  Created by ZAFAR on 15/11/2021.
//

import UIKit

class OrderHistoryCell: UITableViewCell {
    //MARK:- here the iboutlet
    
    
    
    
    @IBOutlet weak var lblstatus: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var lblcompany: UILabel!
    
    @IBOutlet weak var lblemployee: UILabel!
    
    @IBOutlet weak var lblvehicle: UILabel!
    
    @IBOutlet weak var lbldeliverydate: UILabel!
    @IBOutlet weak var lbldeliverycompany: UILabel!
    
    @IBOutlet weak var lbldeliveryproduct: UILabel!
    @IBOutlet weak var lbldeliverydetail: UILabel!
    
    
    @IBOutlet weak var lblrecieverdate: UILabel!
    @IBOutlet weak var lblreceiver: UILabel!
    
    
    
    
    @IBOutlet weak var mainView: UIView!
    //MARK:- calback funtion intializing here
    var callBack: ((_ done: Bool) -> (Void))? = nil
    var moreDetailcallBack: ((_ done: Bool) -> (Void))? = nil
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewDesign()
    }

    func viewDesign() {
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowColor = #colorLiteral(red: 0.423489809, green: 0.4235547483, blue: 0.4234756231, alpha: 1)
        mainView.layer.shadowRadius = 4.0
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.masksToBounds = false
    }
    
    
    @IBAction func moreDetailAction(_ sender: UIButton) {
        moreDetailcallBack?(true)
    }
    
}
