//
//  ContractInformationVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/11/2021.
//

import UIKit

class ContractInformationVC: UIViewController {
    @IBOutlet weak var lblendDate: UILabel!
    @IBOutlet weak var lblstartDate: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lblbusinessname: UILabel!
    @IBOutlet weak var lblcontractnumber: UILabel!
    var contractListdata: IncomingContractListModelData?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        configData()
    }
    
    func configData(){
        self.lblendDate.text = getMilisecondstoDate(seconds: "\(contractListdata?.endDate ?? 0)", formatter: "")
        self.lblstartDate.text = getMilisecondstoDate(seconds: "\(contractListdata?.starDate ?? 0)", formatter: "")
        self.lblusername.text = contractListdata?.contractor?.user?.name
        lblbusinessname.text = contractListdata?.company?.name
        self.lblstatus.text = contractListdata?.status?.name
        self.lblcontractnumber.text = "Contrato #10"
        if self.contractListdata?.status?.name == "CONTRACT_ACTIVE" {
            self.statusView.backgroundColor = #colorLiteral(red: 0.3941653073, green: 0.6643448472, blue: 0.6202048659, alpha: 1)
            self.lblstatus.textColor = #colorLiteral(red: 0.3941653073, green: 0.6643448472, blue: 0.6202048659, alpha: 1)
            self.lblstatus.text = self.contractListdata?.status?.name
        } else if self.contractListdata?.status?.name == "CONTRACT_FINISH" {
            self.statusView.backgroundColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            self.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            self.lblstatus.text = self.contractListdata?.status?.name
            } else if self.contractListdata?.status?.name == "CONTRACT_CANCEL" {
                self.statusView.backgroundColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
                self.lblstatus.textColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
                self.lblstatus.text = self.contractListdata?.status?.name
                }
        
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getMilisecondstoDate(seconds: String , formatter:String) -> String{

        let epocTime = TimeInterval(Int(seconds) ?? 0)

        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"  //UTC
        dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
        let dateString = dateFormatter.string(from: myDate)
        return dateString
    }
}
