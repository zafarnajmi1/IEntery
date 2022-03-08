//
//  RecordVC.swift
//  iEntry
//
//  Created by ZAFAR on 11/08/2021.
//

import UIKit
import XLPagerTabStrip
import DZNEmptyDataSet
class RecordVC: BaseController,IndicatorInfoProvider {
    //MARK:- this delegate of tab
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "HISTORIAL")
    }
    
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    
    //MARK:- here are iboutlete
    @IBOutlet weak var tblView: UITableView!
    
    var eventdata : [EventModuleData]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.register(UINib.init(nibName: "SchedualCell", bundle: nil), forCellReuseIdentifier: "SchedualCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getEventsAfterDate()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tblView.frame = tblView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0))
    }
    
    func getEventsAfterDate(){
        self.showLoader()
        let timeInMiliSecDate = Date()
        let timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
        //* 1 * 24 * 60 * 60 * 1000
        let dic : [String:Any] = ["date":timeInMiliSec, "userId":ShareData.shareInfo.obj?.id ?? ""]
        userhandler.getEventsBeforeDate(params: dic, Success: {response in
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
//MARK:- here are Table  delegates
extension RecordVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchedualCell") as? SchedualCell
        cell?.mapView.isHidden = true
        cell?.qrView.isHidden  = true
        
        cell?.lblhostName.text = self.eventdata?[indexPath.row].user?.name
        cell?.lbleventName.text = self.eventdata?[indexPath.row].name
        cell?.lblplace.text = self.eventdata?[indexPath.row].reservation?.zone?.name
        cell?.lblinvitations.text = "\(self.eventdata?[indexPath.row].invitationNo ?? 0)"
        cell?.lblstartDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].startDate) ?? 0)", formatter: "")
        cell?.lblendDate.text = self.getFormattedMilisecondstoDate(seconds: "\((self.eventdata?[indexPath.row].endDate) ?? 0)", formatter: "")
        cell?.lblstatus.text = self.eventdata?[indexPath.row].reservation?.zone?.company?.status?.name
        cell?.lblreservation.text = self.eventdata?[indexPath.row].reservation?.zone?.name
        cell?.moreDetailcallBack = { Istrue in
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"RecordDetailVC") as? RecordDetailVC
            vc?.isfromHistory = true
            vc?.eventdata = self.eventdata?[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        return cell!
    }
    
    
}

extension RecordVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "you have no Events"
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let text = "Try Again!"
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4712097049, green: 0.7777811885, blue: 0.758687973, alpha: 1)
            ] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!){
        
       
        self.getEventsAfterDate()
        
    }
    
    
    
}
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}