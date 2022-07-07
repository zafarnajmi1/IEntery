//
//  InvitarVC.swift
//  iEntry
//
//  Created by ZAFAR on 04/10/2021.
//

import UIKit
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class InvitarVC: BaseController, UITextFieldDelegate {
    var checkRegisterUser = [checkUserExistModel]()
    var invitationlist = [InvitationsHistoryModel]()
    
    @IBOutlet weak var lblfindemployee: UILabel!
    @IBOutlet weak var lblfindUser: UILabel!
    var  userListdata = [GetAllUsersListModelData]()
    var MainDrowpDown = DropDown()
    @IBOutlet weak var txtemployee: MDCOutlinedTextField!
    @IBOutlet weak var employeedorpdownView: UIView!
    
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
        
        setMDCTxtFieldDesign(txtfiled: txtemployee, Placeholder: "EMPLOYEE", imageIcon: UIImage(named: "sort-down-solid")!)
        self.lblinvitortitle.text = "INVITAR".localized
        self.txtsearch.placeholder = "Escribe para buscar ...".localized
        self.btnselectnumbertitle.setTitle("O ELIGE EN BASE A TU LISTA DE CONTACTOS".localized, for: .normal)
        txtsearch.delegate = self
        searchView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.866572082, green: 0.8667211533, blue: 0.8665626645, alpha: 1), shadowRadius: 3, shadowOpacity: 1)
        innerSearch.roundCorners([.topRight,.bottomRight], radius: 15)
        self.tblView.register(UINib.init(nibName: "InvitarCell", bundle: nil), forCellReuseIdentifier: "InvitarCell")
        getallUsersListApi()
    }
    
    
    func getallUsersListApi(){
        self.showLoader()
        userhandler.getAllusers(companyid: ShareData.shareInfo.contractData?.company?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.userListdata = response?.data ?? []
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    @IBAction func employeSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            self.employeedorpdownView.isHidden = false
            self.searchView.isHidden = true
            self.lblfindemployee.textColor = #colorLiteral(red: 0.1884683073, green: 0.50359869, blue: 0.4553821087, alpha: 1)
            self.lblfindUser.textColor = #colorLiteral(red: 0.8077545762, green: 0.8078941703, blue: 0.8077457547, alpha: 1)
        } else {
            self.employeedorpdownView.isHidden = true
            self.searchView.isHidden = false
            self.lblfindemployee.textColor = #colorLiteral(red: 0.8077545762, green: 0.8078941703, blue: 0.8077457547, alpha: 1)
            self.lblfindUser.textColor = #colorLiteral(red: 0.1884683073, green: 0.50359869, blue: 0.4553821087, alpha: 1)
        }
    }
    
    @IBAction func employeeDropwAction(_ sender: UIButton) {
        
        var employeeList = [String]()
         
        for item in self.userListdata {
            employeeList.append(item.name ?? "")
        }
        
        dropDownConfig(txtField: txtemployee, data: employeeList)
    }
    
    //MARK:- General dropdown function
    func dropDownConfig(txtField : UITextField, data:[String]) {
        MainDrowpDown.anchorView = txtField
        MainDrowpDown.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        MainDrowpDown.selectionBackgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        MainDrowpDown.dataSource =  data
        DropDown.appearance().textColor = #colorLiteral(red: 0.5527616143, green: 0.5568413734, blue: 0.5609211326, alpha: 1)
        DropDown.appearance().selectedTextColor = UIColor.red
        //DropDown.appearance().textFont = UIFont(name: "JosefinSans-Regular", size: 18)!
        self.MainDrowpDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .left
            
        }
        
        MainDrowpDown.bottomOffset = CGPoint(x: 0, y: txtField.bounds.height)
        MainDrowpDown.selectionAction = { [self](index: Int, item: String) in
            print(item)
//            self.txtselcted.text = item
//            self.question?.selectedAns = index
//            self.question?.answerText = item
//            self.delegate?.myclaimdropdown(cell:self, ind: index, Section: self.mysection  )
            self.txtemployee.text = item
               
            if !self.checkRegisterUser.contains(where: { $0.phoneemail == self.userListdata[index].phoneNumber ?? "" }) {
                self.checkRegisterUser.append(checkUserExistModel(name: self.userListdata[index].name ?? "", phone:self.userListdata[index].phoneNumber ?? "", isregister: false, guestid:self.userListdata[index].id ?? "", registertype: 1, email: self.userListdata[index].email ?? ""))
            }
            self.lbltotalInvitation.text = "\(checkRegisterUser.count)" + "Invitaciones".localized
            self.tblView.reloadData()
        }
        MainDrowpDown.show()
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ContactListVC") as? ContactListVC
        vc?.callBack = { selectedNumbers in
            
            for item in selectedNumbers {
                self.checkUserExistApi(name: item.name!,phone: item.number!, isphone: true)
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
//        if txtsearch.text?.isEmpty == false {
//            searchApi(name:"",phone:txtsearch.text!)
//
//        }
        
        
        if txtsearch.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Email / Phone number")
            return
        } else if txtsearch.text?.isValidEmail == true {
            searchApi(name:"", phone:txtsearch.text!, isphone: false)
            
        } else if isValidPhone(phone: txtsearch.text ?? "") == true {
            searchApi(name:"",phone:txtsearch.text!,isphone:true)
        } else {
            AppUtility.showErrorMessage(message: "Please Enter Valid Email / Phone number")
        }
    }
    
    func isValidPhone(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }
    
    
    func searchApi(name:String,phone:String,isphone:Bool){
         //self.showLoader()
        self.checkRegisterUser.removeAll()
        userhandler.checkUserExist(phone: phone,isphone:isphone, Success: {[self]response in
             self.hidLoader()
             if response?.success == true {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                    self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "", registertype: 1, email:response?.data?.email ?? "" ))
                }
             } else {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                    self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:"", registertype: 0, email: ""))
                }
             }
             self.lbltotalInvitation.text = "\(checkRegisterUser.count)" + "Invitaciones".localized
             //self.filterData =  self.checkRegisterUser
             self.tblView.reloadData()
         }, Failure: {error in
             self.hidLoader()
             //AppUtility.showErrorMessage(message: error.message)
         })
     }
    
    func checkUserExistApi(name:String,phone:String,isphone:Bool){
        //self.showLoader()
        
        userhandler.checkUserExist(phone: phone, isphone: isphone, Success: {[self]response in
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
                        
                        
                        
                ShareData.shareInfo.contactListSaved(isregister: true, name: response?.data?.name ?? "", phoneemail: response?.data?.phoneNumber ?? "", guestid: response?.data?.id ?? "", registertype: 1, email: response?.data?.email ?? "")
                        
                        
                    
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
                    self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "", registertype: 1, email:response?.data?.email ?? "" ))
                    }
                
                
            } else {
                if !self.checkRegisterUser.contains(where: { $0.phoneemail == phone }) {
                    ShareData.shareInfo.contactListSaved(isregister: false, name: name, phoneemail: phone, guestid: response?.data?.id ?? "", registertype: 0, email: response?.data?.email ?? "")
                    self.checkRegisterUser.append(checkUserExistModel(name: name, phone: phone, isregister: false, guestid:"", registertype: 1,email:response?.data?.email ?? ""))
                }
            }
            self.lbltotalInvitation.text = "\(checkRegisterUser.count)" + "Invitaciones".localized
            //self.filterData =  self.checkRegisterUser
            self.tblView.reloadData()
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
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
        
//        if  self.checkRegisterUser[indexPath.row].isregister == true {
//            cell?.indicatorimg.image = UIImage(named: "chevron-right-solid")
//        } else {
//            cell?.indicatorimg.image = UIImage(named: "exclamation-solid-1")
//        }
        
        if self.checkRegisterUser[indexPath.row].registertype == 0 {
            cell?.indicatorimg.image = UIImage(named:"exclamation-solid")
           
        } else if self.checkRegisterUser[indexPath.row].registertype == 1 {
            cell?.indicatorimg.image = UIImage(named:"chevron-right-solid")
        } else {
            cell?.indicatorimg.image = UIImage(named:"ic-check-2")
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
        
        if objec.registertype == 1 {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationPOPUpVC") as? InvitationPOPUpVC
            
            vc?.guestid = self.checkRegisterUser[indexPath.row].guestid
            vc?.name = self.checkRegisterUser[indexPath.row].name
            vc?.phone = self.checkRegisterUser[indexPath.row].phoneemail
            
            vc?.callBack = {number in
                for item in 0..<self.checkRegisterUser.count {
                    if self.checkRegisterUser[item].phoneemail == number {
                        self.checkRegisterUser[indexPath.row].registertype = 2
                        self.checkRegisterUser.remove(at: item)
                        
                        break
                    }
                   
                }
                self.lbltotalInvitation.text = "\(self.checkRegisterUser.count) Invitaciones)"
                self.tblView.reloadData()
            }
            
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
        } else if objec.registertype == 0 {
            
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"UserNotRegisterPopUpVC") as? UserNotRegisterPopUpVC
            vc?.number = self.checkRegisterUser[indexPath.row].phoneemail
            vc?.name = self.checkRegisterUser[indexPath.row].name
            vc?.callback = {number, name in
                for item in self.checkRegisterUser.uniqued() {
                    if item.phoneemail == number {
                        self.checkRegisterUser[indexPath.row].isregister = true
                        self.checkRegisterUser[indexPath.row].registertype = 1
                        self.checkRegisterUser[indexPath.row].name = name
                    }
                }
                self.lbltotalInvitation.text = "\(self.checkRegisterUser.count) Invitaciones)"
                self.tblView.reloadData()
            }
            vc?.modalPresentationStyle = .overFullScreen
            
            self.present(vc!, animated: false, completion: nil)
        } else {
            let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"ONUInvitationSentVC") as? ONUInvitationSentVC
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
