//
//  ONUEventInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 29/04/2022.
//

import UIKit

class ONUEventInvitationVC: BaseController,UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var txtvistorcomments: UITextView!
    
    @IBOutlet weak var lblenduptitle: UILabel!
    @IBOutlet weak var btngetnumber: UIButton!
    
    @IBOutlet weak var lblinvitationtitle: UILabel!
    var invitationsData : [getAllInvitationsAgainstEventModelData]? = nil
    var eventDetaildata : EventDetailModelData? = nil
    var  commenAreasdata : [CommenAreasModelsData]? = nil
    var usersIDsarr = [String]()
    var checkRegisterUser = [checkUserExistModel]()
    var invitationlist = [InvitationsHistoryModel]()
    var param = eventDic()
    var eventid = ""
    var guestNumber = 0
    //MARK:- here are the ibOUtlet
    @IBOutlet weak var lblnumberofInvitation: UILabel!
    
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtvistorcomments.delegate = self
        txtvistorcomments.text = "COMENTARIOS PARA VISITANTES."
        searchView.shadowAndRoundcorner(cornerRadius: Float(searchView.layer.frame.height) / 2, shadowColor: #colorLiteral(red: 0.8430451751, green: 0.843190372, blue: 0.843035996, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
        
        searchButtonView.roundCorners([.topRight,.bottomRight], radius: 25)
        self.tblView.register(UINib.init(nibName: "RecordDetailCell", bundle: nil), forCellReuseIdentifier: "RecordDetailCell")
        stripView.roundViiew()
        txtsearch.delegate = self
        tblView.isScrollEnabled = false
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.lblinvitationtitle.text = "CREAR EVENTO".localized
        self.txtsearch.placeholder = "Escribe no celular / email para invitar".localized
        self.btngetnumber.setTitle("O ELIGE EN BASE A TU LISTA DE CONTACTOS".localized, for: .normal)
        self.lblenduptitle.text = "TERMINAR".localized
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.text == "COMENTARIOS PARA VISITANTES." {
            textView.text = nil
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            DispatchQueue.main.async {
                textView.text = "COMENTARIOS PARA VISITANTES."
            }
        }
    }
    
    @IBAction func acctiontoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
         if(keyPath == "contentSize"){
             if let newvalue = change?[.newKey]
             {
                 DispatchQueue.main.async {
                 let newsize  = newvalue as! CGSize
                    self.tblHeight.constant = newsize.height
                   
                    self.view.layoutIfNeeded()
                 }

             }
         }
     }
    
    
    func checkData() ->Bool{
        if txtvistorcomments.text == "COMENTARIOS PARA VISITANTES." || txtvistorcomments.text == "" {
            self.alert(message: "Please Enter The Commnets")
            return false
        } else if self.checkRegisterUser.count < 1 {
            self.alert(message: "Please Invite At Least One Person")
            return false
        }
        return true
    }
    
    @IBAction func endupAction(_ sender: UIButton) {
        
        if checkData() {
            
                self.param.dic?.updateValue(txtvistorcomments.text ?? "", forKey: "visitorComment")
            
                let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ONUVehicleVC") as? ONUVehicleVC
                vc?.param = self.param
                self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
        
//        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier:"PopUpNumberOFInvitationVC") as? PopUpNumberOFInvitationVC
//
//        vc?.callBack = {number in
//            self.guestNumber = Int(number) ?? 0
//            self.updateInvidationUsers()
//        }
//        vc?.modalPresentationStyle = .overFullScreen
//
//        self.present(vc!, animated: false, completion: nil)
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tblHeight.constant =  self.tblView.contentSize.height
    }
    
    @IBAction func searchaction(_ sender: UIButton) {
        if txtsearch.text == "" {
            
            return
        }
        searchApi(phone:txtsearch.text!)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != ""{
            //searchApi(phone:textField.text!+string)
        }
        
        
        if string == ""{
            self.checkRegisterUser.removeAll()
            for item in invitationsData ?? [] {
                self.checkRegisterUser.append(checkUserExistModel(name: item.guest?.name ?? "", phone: item.guest?.phoneNumber ?? "", isregister: true, guestid: item.guest?.id ?? ""))
            }
            self.tblView.reloadData()
        }
        
        return true
    }
    
    
    @IBAction func contactListAction(_ sender: UIButton) {
        self.checkRegisterUser.removeAll()
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ContactListVC") as? ContactListVC
        vc?.callBack = { selectedNumbers in
            
            for item in selectedNumbers {
                
                self.checkUserExistApi(name: item.name!,phone: item.number!)
            }
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func searchApi(phone:String){
        //self.showLoader()
       self.checkRegisterUser.removeAll()
        userhandler.checkUserExist(phone: phone, Success: {[self]response in
            self.hidLoader()
            if response?.success == true {
               if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? ""))
               }
            }
            
//            else {
//               if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
//                self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: phone, isregister: false, guestid:""))
//               }
//            }
            //self.lbltotalInvitation.text = "\(checkRegisterUser.count) Invitaciones)"
            //self.filterData =  self.checkRegisterUser
            self.tblView.reloadData()
        }, Failure: {error in
            self.hidLoader()
            //self.alert(message: error.message)
        })
    }
   
   
   
   
  
   func checkUserExistApi(name:String,phone:String){
       //self.showLoader()
       
       userhandler.checkUserExist(phone: phone, Success: {[self]response in
           self.hidLoader()
           if response?.success == true {
               DispatchQueue.main.async {
                   
                       ShareData.shareInfo.saveExistUser(existuser: (response?.data)!)
                       UserDefaults.standard.save(customObject: response?.data, inKey: "checkuserExist")
                       ShareData.shareInfo.invitatiosdataSaved(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", date: getCurrentDate(), guestid: response?.data?.id ?? "")
                       
                       do {
                                   // setting a value for a key
                           let newPerson = InvitationsHistoryModel(name:response?.data?.name ?? "", phone:response?.data?.phoneNumber ?? "", date:getCurrentDate(), guestid: response?.data?.id ?? "")
                                   
                           invitationlist.append(newPerson)
                                   let encodedData = try NSKeyedArchiver.archivedData(withRootObject: invitationlist, requiringSecureCoding: false)
                                   UserDefaults.standard.set(encodedData, forKey: "invitation")
                                  
                               } catch {
                                   print("There is Error:",error)
                               }
                       
                       
                       
                       ShareData.shareInfo.contactListSaved(isregister: true, name: response?.data?.name ?? "", phoneemail: response?.data?.phoneNumber ?? "", guestid: response?.data?.id ?? "")
                       
                       
                   
                   do {
                               // setting a value for a key
                       let newPerson = checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "")
                       
                            if !self.checkRegisterUser.contains(where: { $0.phoneemail == response?.data?.phoneNumber ?? "" }){
                                       
                                        checkRegisterUser.append(newPerson)
                                  }
                       
                               let encodedData = try NSKeyedArchiver.archivedData(withRootObject: checkRegisterUser, requiringSecureCoding: false)
                               UserDefaults.standard.set(encodedData, forKey: "contactList")
                               
                           } catch {
                               print("There is Error:",error)
                           }
               }
              
               if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                   self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? ""))
                   }
               
               
           } else {
               if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                       ShareData.shareInfo.contactListSaved(isregister: false, name: name, phoneemail: phone, guestid: response?.data?.id ?? "")
                       self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:""))
               }
           }
           self.lblnumberofInvitation.text = "\(checkRegisterUser.count) " + "Invitaciones".localized
           //self.filterData =  self.checkRegisterUser
           self.tblView.reloadData()
       }, Failure: {error in
           self.hidLoader()
           self.alert(message: error.message)
       })
   }
    
    
    func updateInvidationUsers() {
        self.showLoader()
        
        self.usersIDsarr.removeAll()
        var mainArr = [[String:Any]]()
        for item in self.checkRegisterUser {
            if item.isregister == true {
                mainArr.append(["guest":["id":item.guestid],"guestNumber":guestNumber])
                //usersIDsarr.append("\(item.guestid)")
            }
        }
        
        
        
        let dic : [String:Any] = ["eventId":eventid,"userInvitations":mainArr]
        //
        //usersIds
        userhandler.sendInvitation(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                self.dismiss(animated: true, completion: nil)
                
                
                self.dismiss(animated: false, completion: {
                    
                })
                self.navigationController?.popToViewController(ofClass: HomeVC.self)
                self.alert(message: response?.message ?? "")
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
}
//MARK:- tableview datesource and delegate
extension ONUEventInvitationVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
           return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return self.checkRegisterUser.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
            let cell =  tableView.dequeueReusableCell(withIdentifier: "RecordDetailCell") as? RecordDetailCell
            if self.checkRegisterUser[indexPath.row].isregister == true {
                
                cell?.tick.image = UIImage(named:"ic-check-2")
            } else {
                cell?.tick.image = UIImage(named:"ic-cancel")
            }
            
            
            cell?.lblname.text = self.checkRegisterUser[indexPath.row].name
            cell?.lblphone.text = self.checkRegisterUser[indexPath.row].phoneemail
//            cell?.callBack = { istrue in
//
//                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier:"CancelEventInvitationVC") as? CancelEventInvitationVC
//                vc?.modalPresentationStyle = .overFullScreen
//
//                self.present(vc!, animated: false, completion: nil)
//            }
            return cell!
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            if self.checkRegisterUser[indexPath.row].isregister == true {
                
                
                
                let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ONURegisterUserVC") as? ONURegisterUserVC
                //vc?.number = self.checkRegisterUser[indexPath.row].phoneemail
//                vc?.callback = {number, name in
//                    for item in self.checkRegisterUser {
//                        if item.phoneemail == number {
//                            self.checkRegisterUser[indexPath.row].isregister = true
//                            self.checkRegisterUser[indexPath.row].name = name
//
//                        }
//                    }
//                    self.tblView.reloadData()
//                }
                vc?.modalPresentationStyle = .overFullScreen
                
                self.present(vc!, animated: false, completion: nil)
                
                
            } else {
                    let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"UserNotRegisterPopUpVC") as? UserNotRegisterPopUpVC
                    vc?.number = self.checkRegisterUser[indexPath.row].phoneemail
                    vc?.callback = {number, name in
                        for item in self.checkRegisterUser {
                            if item.phoneemail == number {
                                self.checkRegisterUser[indexPath.row].isregister = true
                                self.checkRegisterUser[indexPath.row].name = name
                              
                            }
                        }
                        self.tblView.reloadData()
                    }
                    vc?.modalPresentationStyle = .overFullScreen
                    
                    self.present(vc!, animated: false, completion: nil)
            }
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tblView == tableView {
            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
   
                    debugPrint("Delete tapped")
                self.checkRegisterUser.remove(at: indexPath.row)
                self.lblnumberofInvitation.text = "\(self.checkRegisterUser.count)" + "Invitaciones".localized
                self.tblView.reloadData()
                    success(true)
                })

            deleteAction.image = UIImage(named: "ic-trash-outline")
            deleteAction.backgroundColor = UIColor.red

            return UISwipeActionsConfiguration(actions: [deleteAction])
        } else {
            
        }
        let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in

                debugPrint("Delete tapped")

                success(true)
            })

        deleteAction.image = UIImage(named: "ic-trash-outline")
        deleteAction.backgroundColor = UIColor.red

        return UISwipeActionsConfiguration(actions: [deleteAction])
        }
}
