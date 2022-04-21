//
//  SchedualVC.swift
//  iEntry
//
//  Created by ZAFAR on 11/08/2021.
//

import UIKit
import XLPagerTabStrip
import DZNEmptyDataSet
class SchedualVC: BaseController,IndicatorInfoProvider {
    //MARK:- this funtion is delegate of tab
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "PROXIMOS".localized)
    }
    //PROXIMOS
    //PROGRAMADOS
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    var eventdata : [EventModuleData]? = nil
    //MARK:- here are iboutle 
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.register(UINib.init(nibName: "SchedualCell", bundle: nil), forCellReuseIdentifier: "SchedualCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getEventsBeforeDate()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tblView.frame = tblView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0))
    }
    
    //* 1 * 24 * 60 * 60 * 1000
    func getEventsBeforeDate(){
        self.showLoader()
        let timeInMiliSecDate = Date()
        let timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
       
        //userId
        let dic : [String:Any] = ["date":timeInMiliSec, "hostId":ShareData.shareInfo.obj?.id ?? ""]
        userhandler.getEventsAfterDate(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.eventdata = response?.data ?? []
                if self.eventdata?.count == 0 {
                    self.emptyDataSetUp()
                }
                self.tblView.reloadData()
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }

}
//MARK:- table view delegate and datasource
extension SchedualVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchedualCell") as? SchedualCell
        cell?.qrView.isHidden = true
        cell?.lblstatus.text = self.eventdata?[indexPath.row].status?.name
        cell?.lblhostName.text =  self.eventdata?[indexPath.row].user?.name
        cell?.lbleventName.text = self.eventdata?[indexPath.row].name
        cell?.lblplace.text = self.eventdata?[indexPath.row].reservation?.zone?.name
        cell?.lblinvitations.text = "\(self.eventdata?[indexPath.row].invitationNo ?? 0)"
        cell?.lblstartDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].startDate) ?? 0)", formatter: "")
        //cell?.lblendDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].endDate) ?? 0)", formatter: "")
        cell?.lblendDate.isHidden = true
        cell?.lbltitleEnddate.isHidden = true 
        cell?.lblreservation.text = self.eventdata?[indexPath.row].reservation?.zone?.name
        cell?.lbldurationmin.text = "\(self.eventdata?[indexPath.row].duration ?? 0) MIN"
        
        if self.eventdata?[indexPath.row].status?.name ==  "EVENT_IN_VALIDATION" {
                cell?.lblstatus.text = "EVENT IN VALIDATION"
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
                cell?.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
        } else  if self.eventdata?[indexPath.row].status?.name ==  "EVENT_APPROVED" {
            cell?.lblstatus.text = "EVENT APPROVED"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.04716654867, green: 0.249147892, blue: 0.1248098537, alpha: 1)
            cell?.lblstatus.textColor = #colorLiteral(red: 0.04335165769, green: 0.2412434816, blue: 0.1210812852, alpha: 1)
    } else  if self.eventdata?[indexPath.row].status?.name ==  "EVENT_CANCEL" {
        cell?.lblstatus.text = "EVENT CANCEL"
        cell?.statusView.backgroundColor = #colorLiteral(red: 0.618992269, green: 0.005741298664, blue: 0.00775064528, alpha: 1)
        cell?.lblstatus.textColor = #colorLiteral(red: 0.6229569912, green: 0.005496537313, blue: 0.00703322608, alpha: 1)
}
        
        cell?.callBack = { Istrue in
            if Istrue {
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            if !Istrue {
                    let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"GeneralQRCodeVC") as? GeneralQRCodeVC
                    self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
        cell?.moreDetailcallBack = { Istrue in
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"RecordDetailVC") as? RecordDetailVC
            vc?.isfromHistory = false
            vc?.eventdata = self.eventdata?[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        return cell!
    }
    
    
}
extension SchedualVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        var text = ""
        if myDefaultLanguage == .en {
            text = "you have no Events".localized
        } else {
            text = "no tienes eventos".localized
        }
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        var text = ""
        if myDefaultLanguage == .en {
         text = "Try Again!".localized
        } else {
            text = "¡Intentar otra vez!".localized
        }
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4712097049, green: 0.7777811885, blue: 0.758687973, alpha: 1)
            ] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!){
        
       
        self.getEventsBeforeDate()
        
    }
    
    
    
}
