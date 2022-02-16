//
//  NewInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 23/08/2021.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import DZNEmptyDataSet
class NewInvitationVC: BaseController,IndicatorInfoProvider {
    
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "INVITACIONES")
    }
    //MARK:- here are the iboutlet
    @IBOutlet weak var tblView: UITableView!
    var invitationdata : [GetallInvitationModelData]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tblView.register(UINib.init(nibName: "NewInvitationCell", bundle: nil), forCellReuseIdentifier: "NewInvitationCell")
        self.navigationBarHidShow(isTrue: true)
        //self.getallInviationsByUserID()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInvitationAfterDate()
    }
    ///get-all/by-guest-id/{guestId}/date-after
    

    func getInvitationAfterDate() {
        
        let stringurl = Constant.MainUrl + "invitation-service/get-all/by-guest-id/\(ShareData.shareInfo.obj?.id ?? "")/date-after"
        let url = URL(string: stringurl)
        let timeInMiliSecDate = Date()
        let timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.post.rawValue
        //request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("\(ShareData.shareInfo.token ?? "")",forHTTPHeaderField: "Authorization")
        request.httpBody = "\(timeInMiliSec)".data(using: .utf8)

        AF.request(request).responseJSON { response in
                print("all data ",response)
            do {
               
                let responseModel = try JSONDecoder().decode(GetallInvitationModel.self, from: response.data!)
                self.invitationdata = responseModel.data
                if self.invitationdata?.count == 0 {
                    self.emptyDataSetUp()
                }
                self.tblView.reloadData()
            }
            catch {
                print("Response Error")
            }

        }
    }
    
    
    
}
//MARK:-  tableview delegate 
extension NewInvitationVC : UITableViewDelegate,UITableViewDataSource {
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
        //cell?.lblhostName.text = self.invitationdata?[indexPath.row].zone?.company?.name
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
                vc?.eventid = self.invitationdata?[indexPath.row].id ?? ""
                vc?.eventname = self.invitationdata?[indexPath.row].event ?? ""
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
extension NewInvitationVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "you have no Invitation"
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
        
       
        self.getInvitationAfterDate()
        
    }
    
    
    
}
