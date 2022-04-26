//
//  NotificationVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/08/2021.
//

import UIKit
import DZNEmptyDataSet
class NotificationVC: BaseController {
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    //MARK:- here are the iboutlet
    @IBOutlet weak var lblnotificationsTitle: UILabel!
    @IBOutlet weak var inerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var tblView: UITableView!
    var notificationdata : [NotificationModelData]? = nil
    var notificationList = [CreatedNotification]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonView.roundViiew()
        self.inerView.roundViiew()
        navigationBarHidShow(isTrue: true)
        tblView.register(UINib.init(nibName: "NotificationsCell", bundle: nil), forCellReuseIdentifier: "NotificationsCell")
        if ShareData.shareInfo.userRole == .contractor ||  ShareData.shareInfo.userRole == .contractoremplyee
        {
            buttonView.isHidden = true
        } else if ShareData.shareInfo.userRole == .provider ||  ShareData.shareInfo.userRole == .provideremployee{
            buttonView.isHidden = true
        } else {
            buttonView.isHidden = false
        }
//        let prefs = UserDefaults.standard
//        prefs.removeObject(forKey:"notification")
        self.lblnotificationsTitle.text = "N O T I F I C A C I O N E S".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotificationApi()
        
    }
//    @IBAction func backAction(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func menuaction(_ sender: UIButton) {
        
        let manager = ZSideMenuManager(isRTL: false)
                     manager.openSideMenu(vc: self)
    }
    
    @IBAction func addnotification(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewNotificationVC") as? NewNotificationVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func getNotificationApi(){
        showLoader()
        let timeInMiliSec = Date()
        let sectimeInMili = Int (timeInMiliSec.timeIntervalSince1970 * 1000)
        
        //30 * 24 * 60 * 60 * 1000
        var dic : [String:Any] = [:]
        
        if ShareData.shareInfo.userRole == .provideremployee{
            
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.providerEmployeedataValueGetByUserid?.provider?.company?.id ?? "","date":sectimeInMili]
            
        }else
        if ShareData.shareInfo.userRole == .provider{
            
            
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.contractorListdataValueGetByUserid.company?.id ?? "","date":sectimeInMili]
            
        } else if ShareData.shareInfo.userRole == .contractor {
            
            
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.contractorListdataValueGetByUserid.company?.id ?? "","date":sectimeInMili]
            
        }else if ShareData.shareInfo.userRole == .contractoremplyee {
            //contractorEmployeeId
            dic = ["userId":ShareData.shareInfo.contractorEmployeedataValueGetByUserid?.id ?? "", "companyId":ShareData.shareInfo.contractorListdataValueGetByUserid.company?.id ?? "","date":sectimeInMili]
            
        } else if ShareData.shareInfo.userRole == .employees{
            
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.conractWithCompany?.company?.id ?? "","date":sectimeInMili]
        }
        
        
            
        userhandler.getNotificationAfterDate(afterdate: sectimeInMili, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.notificationdata = response?.data
                self.notificationList.removeAll()
                
                for item in ShareData.shareInfo.getBacNotificationsSaved() {
                    self.notificationList.append(CreatedNotification(qualification:item.qualification, message: item.message, notificationkind: item.notificationkind, Notificationtime:"\(item.Notificationtime)" , Notificationdate: "\(item.Notificationdate)", notificationType:item.notificationType, username:item.username, createdAt: item.createdAt, type:item.type))
                }
                
                
                for item in self.notificationdata ?? []{
                    self.notificationList.append(CreatedNotification(qualification: item.title ?? "", message: item.message ?? "", notificationkind: item.type ?? "", Notificationtime:"\(item.dateMeeting ?? 0)" , Notificationdate: "\(item.dateMeeting ?? 0)", notificationType:item.notificationType?.name ?? "", username: item.user?.name ?? "", createdAt: "\(item.createdAt ?? 0)", type: item.type ?? "" ))
                }
                
                self.notificationList.sort(by: {$0.createdAt > $1.createdAt})
                
                
                if self.notificationList.count == 0 {
                    self.emptyDataSetUp()
                }
                self.tblView.reloadData()
            } else {
                self.hidLoader()
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
}
//MARK:- tableview delegates
extension NotificationVC :  UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NotificationsCell") as? NotificationsCell
        let obj = notificationList[indexPath.row]
        cell?.configdate(obj:obj )
        return cell!
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in

                    debugPrint("Delete tapped")
                self.notificationList.remove(at: indexPath.row)
                self.tblView.reloadData()
                    success(true)
                })

            deleteAction.image = UIImage(named: "ic-trash-outline")
            deleteAction.backgroundColor = UIColor.red

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    
}
extension NotificationVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var text = ""
        if myDefaultLanguage == .en {
         text = "you have no Notification".localized
        } else {
            text = "no tienes notificación".localized
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
        
       
        self.getNotificationApi()
        
    }
    
    
    
}
