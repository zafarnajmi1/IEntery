//
//  InvitarVC.swift
//  iEntry
//
//  Created by ZAFAR on 04/10/2021.
//

import UIKit

class InvitarVC: BaseController, UITextFieldDelegate {
    var checkRegisterUser = [checkUserExistModel]()
    var invitationlist = [InvitationsHistoryModel]()
    
    @IBOutlet weak var btnselectnumbertitle: UIButton!
    @IBOutlet weak var lblinvitortitle: UILabel!
    //MARK:- here are the iboutlet
    @IBOutlet weak var tblView: UITableView! {
        didSet{
            tblView.reloadData()
        }
    }
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var lbltotalInvitation: UILabel!
    @IBOutlet weak var innerSearch: UIView!
    var totalinvitation = 0
    //var filterData = [checkUserExistModel]()
    
    var isSearch = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblinvitortitle.text = "INVITAR".localized
        self.txtsearch.placeholder = "Escribe para buscar ...".localized
        self.btnselectnumbertitle.setTitle("O ELIGE EN BASE A TU LISTA DE CONTACTOS".localized, for: .normal)
        txtsearch.delegate = self
        searchView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.866572082, green: 0.8667211533, blue: 0.8665626645, alpha: 1), shadowRadius: 3, shadowOpacity: 1)
        innerSearch.roundCorners([.topRight,.bottomRight], radius: 15)
        self.tblView.register(UINib.init(nibName: "InvitarCell", bundle: nil), forCellReuseIdentifier: "InvitarCell")
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ContactListVC") as? ContactListVC
        vc?.callBack = { selectedNumbers in
            
            for item in selectedNumbers {
                self.checkUserExistApi(name: item.name!,phone: item.number!)
            }
            
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if string != ""{
//            //searchApi(phone:textField.text!+string)
//        }
//
//
//        if string == ""{
//
//            self.checkRegisterUser.removeAll()
//
//            for item in  0..<ShareData.shareInfo.getBackcontactListSaved().count {
//                checkUserExistApi(name:ShareData.shareInfo.getBackcontactListSaved()[item].name,phone:ShareData.shareInfo.getBackcontactListSaved()[item].phoneemail)
//            }
//
//            self.tblView.reloadData()
//        }
//
//        return true
//    }
    
    
    
    
    @IBAction func searchAction(_ sender: UIButton) {
        if txtsearch.text?.isEmpty == false {
            searchApi(name:"",phone:txtsearch.text!)
            
        }
    }
    
    
     func searchApi(name:String,phone:String){
         //self.showLoader()
        self.checkRegisterUser.removeAll()
         userhandler.checkUserExist(phone: phone, Success: {[self]response in
             self.hidLoader()
             if response?.success == true {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                 self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? ""))
                }
             } else {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                 self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:""))
                }
             }
             self.lbltotalInvitation.text = "\(checkRegisterUser.count)" + "Invitaciones".localized
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
//                DispatchQueue.main.async {
                    
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
                        
                        
                    
//                    do {
//                                // setting a value for a key
//                        let newPerson = checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "")
//
//                        checkRegisterUser.append(newPerson)
//                                let encodedData = try NSKeyedArchiver.archivedData(withRootObject: checkRegisterUser, requiringSecureCoding: false)
//                                UserDefaults.standard.set(encodedData, forKey: "contactList")
//
//                            } catch {
//                                print("There is Error:",error)
//                            }
//                }
               
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                    self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? ""))
                    }
                
                
            } else {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                        ShareData.shareInfo.contactListSaved(isregister: false, name: name, phoneemail: phone, guestid: response?.data?.id ?? "")
                        self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:""))
                }
            }
            self.lbltotalInvitation.text = "\(checkRegisterUser.count)" + "Invitaciones".localized
            //self.filterData =  self.checkRegisterUser
            self.tblView.reloadData()
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    
}

//MARK:- tableview delegate
extension InvitarVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.checkRegisterUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "InvitarCell") as? InvitarCell
        cell?.lblname.text = self.checkRegisterUser[indexPath.row].name
        cell?.lblnumber.text = self.checkRegisterUser[indexPath.row].phoneemail
        
        if  self.checkRegisterUser[indexPath.row].isregister == true {
            cell?.indicatorimg.image = UIImage(named: "chevron-right-solid")
        } else {
            cell?.indicatorimg.image = UIImage(named: "exclamation-solid-1")
        }
//        cell?.callBack = { istrue in
//            
//            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationPOPUpVC") as? InvitationPOPUpVC
//            vc?.modalPresentationStyle = .overFullScreen
//            
//            self.present(vc!, animated: false, completion: nil)
//        }
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
        let objec = self.checkRegisterUser[indexPath.row]
        if objec.isregister == true {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationPOPUpVC") as? InvitationPOPUpVC
            
            vc?.guestid = self.checkRegisterUser[indexPath.row].guestid
            vc?.name = self.checkRegisterUser[indexPath.row].name
            vc?.phone = self.checkRegisterUser[indexPath.row].phoneemail
            
            vc?.callBack = {number in
                for item in 0..<self.checkRegisterUser.count {
                    if self.checkRegisterUser[item].phoneemail == number {
                        self.checkRegisterUser.remove(at: item)
                        break
                    }
                   
                }
                self.lbltotalInvitation.text = "\(self.checkRegisterUser.count) Invitaciones)"
                self.tblView.reloadData()
            }
            
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
        } else {
            
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"UserNotRegisterPopUpVC") as? UserNotRegisterPopUpVC
            vc?.number = self.checkRegisterUser[indexPath.row].phoneemail
            vc?.name = self.checkRegisterUser[indexPath.row].name
            vc?.callback = {number, name in
                for item in self.checkRegisterUser.uniqued() {
                    if item.phoneemail == number {
                        self.checkRegisterUser[indexPath.row].isregister = true
                        self.checkRegisterUser[indexPath.row].name = name
                    }
                }
                self.lbltotalInvitation.text = "\(self.checkRegisterUser.count) Invitaciones)"
                self.tblView.reloadData()
            }
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
        }
    }
}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
