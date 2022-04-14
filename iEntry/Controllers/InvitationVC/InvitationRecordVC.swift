//
//  InvitationRecordVC.swift
//  iEntry
//
//  Created by ZAFAR on 23/08/2021.
//

import UIKit
import DZNEmptyDataSet
class InvitationRecordVC: UIViewController {
    //MARK:- here are the iboutlet
    
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.register(UINib.init(nibName: "InvitationRecordCell", bundle: nil), forCellReuseIdentifier: "InvitationRecordCell")
        self.navigationBarHidShow(isTrue: true)
        
        if ShareData.shareInfo.getBackinvitatiosdataSaved().count == 0 {
            self.emptyDataSetUp()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ShareData.shareInfo.getBackinvitatiosdataSaved().count == 0 {
            self.emptyDataSetUp()
        }
        self.tblView.reloadData()
    }

   

}

//MARK:- tableview delegate
extension InvitationRecordVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShareData.shareInfo.getBackinvitatiosdataSaved().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "InvitationRecordCell") as? InvitationRecordCell
        cell?.lbldate.text = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].date
        cell?.lblname.text = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].name
        cell?.lblphone.text = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].phone
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationPOPUpVC") as? InvitationPOPUpVC
        vc?.isfromHistory = true
        vc?.name = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].name
        vc?.phone =  ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].phone
        vc?.guestid = ShareData.shareInfo.getBackinvitatiosdataSaved()[indexPath.row].guestid
        vc?.modalPresentationStyle = .overFullScreen
        
        self.present(vc!, animated: false, completion: nil)
    }
    
}
extension InvitationRecordVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var text = ""
        if myDefaultLanguage == .en {
         text = "you have no Invitation".localized
        } else {
            text = "no tienes invitación".localized
        }
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text.localized, attributes: attribs)
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
        
        return NSAttributedString(string: text.localized, attributes: attribs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!){
        
       
        self.tblView.reloadData()
        
    }
    
    
    
}
