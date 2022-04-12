//
//  EventInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 04/01/2022.
//

import UIKit
import XLPagerTabStrip
import DZNEmptyDataSet
class EventInvitationVC: BaseController,IndicatorInfoProvider {
    
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "INVITACIONES".localized)
    }
    //MARK:- here are the iboutlet
    @IBOutlet weak var tblView: UITableView!
    
    var invitationdata : [EventInvitationsModelsData]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.register(UINib.init(nibName: "NewInvitationCell", bundle: nil), forCellReuseIdentifier: "NewInvitationCell")
        self.navigationBarHidShow(isTrue: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getallInviationsAfterDate()
    }
    ///get-all/by-guest-id/{guestId}/date-after
    
    
    
    /////get-all-invitations/by-user-id/after-date   for invitations.
    func getallInviationsAfterDate() {
        self.showLoader()
        let timeInMiliSecDate = Date()
        let timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
        
        let dic : [String:Any] = ["date":timeInMiliSec,"userId":ShareData.shareInfo.obj?.id ?? ""]
        userhandler.getEventsinvitatinsAftereDate(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.invitationdata = response?.data
                if self.invitationdata?.count == 0 {
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
//MARK:-  tableview delegate
extension EventInvitationVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.invitationdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NewInvitationCell") as? NewInvitationCell
        //cell?.tick.image = UIImage(named:"chevron-right-solid")
        cell?.lblhostName.text = self.invitationdata?[indexPath.row].guest?.name
        cell?.lblcompanyName.text = self.invitationdata?[indexPath.row].zone?.company?.name
        cell?.lbldate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.invitationdata?[indexPath.row].startDate ?? 0)", formatter: "")
        cell?.callBack = { istrue in
            if istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
            
                self.navigationController?.pushViewController(vc!, animated: true)
            
            }  else {
                
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"GeneralQRCodeVC") as? GeneralQRCodeVC
                
                vc?.name = self.invitationdata?[indexPath.row].guest?.name ?? ""
                vc?.date = self.getMilisecondstoDate(seconds: "\(self.invitationdata?[indexPath.row].startDate ?? 0)", formatter: "")
                vc?.time = self.getMilisecondstoTime(seconds: "\(self.invitationdata?[indexPath.row].startDate ?? 0)", formatter: "")
                vc?.eventid = self.invitationdata?[indexPath.row].event?.id ?? ""
                vc?.eventname = self.invitationdata?[indexPath.row].event?.name ?? ""
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in

                    debugPrint("Delete tapped")

                    success(true)
                })

            deleteAction.image = UIImage(named: "ic-trash-outline")
            deleteAction.backgroundColor = UIColor.red

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
}
extension EventInvitationVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "you have no Events Invitations".localized
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let text = "Try Again!".localized
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4712097049, green: 0.7777811885, blue: 0.758687973, alpha: 1)
            ] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!){
        
       
        self.getallInviationsAfterDate()
        
    }
    
    
    
}
