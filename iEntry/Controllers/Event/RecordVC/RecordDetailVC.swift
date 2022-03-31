//
//  RecordDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 17/08/2021.
//

import UIKit

class RecordDetailVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var lblnametitle: UILabel!
    @IBOutlet weak var lbldetailtitle: UILabel!
    @IBOutlet weak var lblupdateeventtitle: UILabel!
    @IBOutlet weak var lblcanceleventtitle: UILabel!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var bannerIMg: UIImageView!
    @IBOutlet weak var topBannerView: UIView!
    
    @IBOutlet weak var btnmore: UIButton!
    @IBOutlet weak var lblnumberofInvitations: UILabel!
    @IBOutlet weak var lblreservationDate: UILabel!
    @IBOutlet weak var lblreservation: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    
    @IBOutlet weak var lblhostname: UILabel!
    @IBOutlet weak var lbladress: UILabel!
    @IBOutlet weak var lblcompanyname: UILabel!
    
    
    
    var eventdata : EventModuleData? = nil
    var invitationsData : [getAllInvitationsAgainstEventModelData]? = nil
    var eventDetaildata : EventDetailModelData? = nil
    var isfromHistory = false
    @IBOutlet var moreView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblcanceleventtitle.text = "CANCELAR EVENTO".localized
        self.lblupdateeventtitle.text = "ACTUALIZAR EVENTO".localized
        self.lbldetailtitle.text = "D E T A L L E S".localized
        self.lblnametitle.text = "NOMBRE".localized
        
        
        
        
        if isfromHistory == true {
            btnmore.isHidden = true
        } else {
            btnmore.isHidden = false
        }
        topBannerView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 4, shadowOpacity: 1)
        moreView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 5, shadowOpacity: 1)
        self.navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "RecordDetailCell", bundle: nil), forCellReuseIdentifier: "RecordDetailCell")
        //getEventDetailApi()
        //getAllinvitationsAgainstEventApi()
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.lbladress.text =  ShareData.shareInfo.conractWithCompany?.company?.address
        self.lblcompanyname.text =  ShareData.shareInfo.conractWithCompany?.company?.name
        
        
        
        self.lblhostname.text =  self.eventdata?.name
        self.lblreservation.text =  self.eventdata?.reservation?.zone?.name
        
        self.lbltime.text = self.getMilisecondstoTime(seconds: "\(self.eventdata?.endDate ?? 0)", formatter: "")
        
        self.lbldate.text = self.getMilisecondstoDate(seconds: "\(self.eventdata?.startDate ?? 0)", formatter: "")
        self.lblreservationDate.text = "Fecha: " + self.getFormattedMilisecondstoDate(seconds: "\(self.eventdata?.reservation?.toDate ?? 0)", formatter: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getEventDetailApi()
        getAllinvitationsAgainstEventApi()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
         if(keyPath == "contentSize"){
             if let newvalue = change?[.newKey]
             {
                 DispatchQueue.main.async {
                 let newsize  = newvalue as! CGSize
                    self.tblHeight.constant = newsize.height
                 }

             }
         }
     }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tblHeight.constant = self.tblView.contentSize.height
    }

    @IBAction func moreAction(_ sender: UIButton) {
        self.moreView.isHidden = !self.moreView.isHidden
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func updateEventAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"UpdateEventVC") as? UpdateEventVC
        vc?.invitationsData = self.invitationsData
        vc?.eventDetaildata = self.eventDetaildata
        vc?.eventdata = self.eventdata
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func DeleteAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"AcceptORRejectionPopUpVC") as? AcceptORRejectionPopUpVC
        vc?.modalPresentationStyle = .overFullScreen
       
        vc?.callBack = {
            print("iam")
            self.dismiss(animated: true, completion: nil)
            self.cancelEventApi()
        }
        self.present(vc!, animated: false, completion: nil)
    }
    
    func cancelEventApi(){
        userhandler.CancelInvitation(id: self.eventdata?.id ?? "", Success: {response in
            if response?.success == true {
                self.alert(message: response?.message ?? "")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.alert(message: error.message)
        })
    }
    
    
    
    
    func getEventDetailApi(){
        self.showLoader()
        userhandler.getEventDetail(id: eventdata?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.eventDetaildata =  response?.data
                
//                self.lblreservation.text =  self.eventDetaildata?.reservation?.zone?.name
//
//                self.lbltime.text = self.getMilisecondstoTime(seconds: "\(self.eventDetaildata?.startDate ?? 0)", formatter: "")
//
//                self.lbldate.text = self.getMilisecondstoDate(seconds: "\(self.eventDetaildata?.endDate ?? 0)", formatter: "")
//                self.lblreservationDate.text = "Fecha: " + self.getFormattedMilisecondstoDate(seconds: "\(self.eventDetaildata?.reservation?.toDate ?? 0)", formatter: "")
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    func getAllinvitationsAgainstEventApi(){
        self.showLoader()
        userhandler.getInvitationsAgainstEvent(id: eventdata?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.invitationsData = response?.data ?? []
                self.lblnumberofInvitations.text = "\(self.invitationsData?.count ?? 0) Invitations"
                self.tblView.reloadData()
                self.tblHeight.constant = self.tblView.contentSize.height
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
}
//MARK:- here are the tableview delegate and datasource
extension RecordDetailVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.invitationsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "RecordDetailCell") as? RecordDetailCell
        cell?.lblname.text = self.invitationsData?[indexPath.row].guest?.name
        cell?.lblphone.text = self.invitationsData?[indexPath.row].guest?.phoneNumber
        cell?.tick.image = UIImage(named:"Path 213")
        return cell!
    }
    
    
}
