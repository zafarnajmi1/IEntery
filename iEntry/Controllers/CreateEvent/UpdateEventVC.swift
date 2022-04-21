//
//  UpdateEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 18/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import SMDatePicker
class UpdateEventVC: BaseController,UITextFieldDelegate, SMDatePickerDelegate {
    @IBOutlet weak var lblchooseyourguesttitle: UILabel!
    //MARK:- here are iboutlet
    @IBOutlet weak var lblupdatetitle: UILabel!
    
    @IBOutlet weak var txtmint: MDCOutlinedTextField!
    @IBOutlet weak var lblsavechangestitle: UILabel!
    @IBOutlet weak var btncontactlisttitle: UIButton!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var lblcompanyname: UILabel!
    var invitationsData : [getAllInvitationsAgainstEventModelData]? = nil
    var eventdata : EventModuleData? = nil
    var eventDetaildata : EventDetailModelData? = nil
    var  commenAreasdata = [CommenAreasModelsData]()
    var usersIDsarr = [String]()
    var checkRegisterUser = [checkUserExistModel]()
    var invitationlist = [InvitationsHistoryModel]()
    var reservationName = ""
    var reservationId = ""
    var isNewReservation = false
    @IBOutlet weak var lblchoosdatetitle: UILabel!
    @IBOutlet weak var reserveTableView: UITableView!
    @IBOutlet weak var reserveTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var stripView: UIView!
    
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblcount: UILabel!
    @IBOutlet weak var innerSearchView: UIView!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var txtEvent: MDCOutlinedTextField!
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    @IBOutlet weak var txttime: MDCOutlinedTextField!
    @IBOutlet weak var topBannerView: UIView!
    var myDatePicker: SMDatePicker = SMDatePicker()
    
    @IBOutlet weak var lblreservationTitle: UILabel!
    var startDatemyDate = Date()
    var endDatemyDate = Date()
    var startMiliSecond = 0
    var endMiliSecond = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btncontactlisttitle.setTitle("O ELÍGE DE LA LISTA DE CONTACTOS".localized, for: .normal)
        self.txtsearch.placeholder = "Escribe para buscar ...".localized
        self.lblchooseyourguesttitle.text = "ESCOGE TUS INVITADOS:".localized
        self.lblreservationTitle.text = "RESERVACIÓN".localized
        self.lblupdatetitle.text = "A C T U A L I Z A R".localized
        self.lblchoosdatetitle.text = "NUEVA FECHA DEL EVENTO".localized
        self.lblsavechangestitle.text = "GUARDAR CAMBIOS".localized
        txtsearch.delegate = self
        self.reserveTableView.isScrollEnabled = false
        setMDCTxtFieldDesign(txtfiled: txtEvent, Placeholder: "NOMBRE DEL EVENTO".localized, imageIcon: UIImage(named: "ic-piñata")!)
        
        setMDCTxtFieldDesign(txtfiled: txttime, Placeholder: "HORA".localized, imageIcon: UIImage(named: "ic-calendar-2")!)
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "FECHA".localized, imageIcon: UIImage(named: "ic-calendar-1")!)
        
        setMDCTxtFieldDesign(txtfiled: txtmint, Placeholder: "DURACIÓN".localized, imageIcon: UIImage())
        
        self.navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "RecordDetailCell", bundle: nil), forCellReuseIdentifier: "RecordDetailCell")
        self.reserveTableView.register(UINib.init(nibName: "NearChoosCell", bundle: nil), forCellReuseIdentifier: "NearChoosCell")
        searchView.shadowAndRoundcorner(cornerRadius: 15, shadowColor: #colorLiteral(red: 0.866572082, green: 0.8667211533, blue: 0.8665626645, alpha: 1), shadowRadius: 3, shadowOpacity: 1)
        innerSearchView.roundCorners([.topRight,.bottomRight], radius: 15)
        topBannerView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.6744349003, green: 0.6745528579, blue: 0.6744274497, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1.0)
        stripView.roundViiew()
        txttime.delegate = self
        txtdate.delegate = self
        conFigData()
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.reserveTableView.addObserver(self, forKeyPath: "contentSize1", options: .new, context: nil)
        
    }
    
    
   
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
         if(keyPath == "contentSize"){
             if let newvalue = change?[.newKey]
             {
                 DispatchQueue.main.async {
                 let newsize  = newvalue as! CGSize
                    self.tblViewHeight.constant = newsize.height
                    self.reserveTableHeight.constant = self.reserveTableView.contentSize.height
                    self.view.layoutIfNeeded()
                 }

             }
         } else if(keyPath == "contentSize1")  {
            if let newvalue = change?[.newKey]
            {
                DispatchQueue.main.async {
                let newsize  = newvalue as! CGSize
                   //self.tblViewHeight.constant = newsize.height
                   self.reserveTableHeight.constant = newsize.height
                   self.view.layoutIfNeeded()
                }

            }
         }
     }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tblViewHeight.constant = self.tblView.contentSize.height
        self.reserveTableHeight.constant = self.reserveTableView.contentSize.height
        
        self.view.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tblViewHeight.constant = self.tblView.contentSize.height
        self.reserveTableHeight.constant = self.reserveTableView.contentSize.height
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func conFigData(){
        
        
        self.checkRegisterUser.removeAll()
        for item in invitationsData ?? [] {
            self.checkRegisterUser.append(checkUserExistModel(name: item.guest?.name ?? "", phone: item.guest?.phoneNumber ?? "", isregister: true, guestid: item.guest?.id ?? ""))
        }
        
        
        
        self.lblcount.text = "\(checkRegisterUser.count) Invitaciones)"
        self.tblView.reloadData()
        
        self.lblcompanyname.text = ShareData.shareInfo.conractWithCompany?.company?.name
        self.lbladdress.text = ShareData.shareInfo.conractWithCompany?.company?.address
        txtEvent.text =  eventDetaildata?.name
        txtdate.text = self.getMilisecondstoDate(seconds: "\(self.eventDetaildata?.startDate ?? 0)", formatter: "")
        txttime.text = self.getMilisecondstoTime(seconds: "\(self.eventDetaildata?.endDate ?? 0)", formatter: "")
        
        self.reservationName =  eventdata?.reservation?.zone?.name ?? ""
        self.reservationId = eventdata?.reservation?.zone?.id ?? ""
        self.txtmint.text = "\(eventdata?.duration ?? 0)"
       getallCommenAreasApi(startdate:self.eventDetaildata?.startDate ?? 0,endDate:self.eventDetaildata?.endDate ?? 0)
        
      
        
        
           // if self.eventdata?.reservation?.zone?.id
//        self.commenAreasdata[0].isSelected = true
//        self.commenAreasdata[0].name = self.eventdata?.reservation?.zone?.name
//        self.commenAreasdata[0].zoneId = self.eventdata?.reservation?.zone?.id
//
//        self.reservationName = self.eventdata?.reservation?.zone?.name ?? ""
//        self.reservationId =  self.eventdata?.reservation?.zone?.id ?? ""
//        self.reserveTableView.reloadData()
//        self.reserveTableHeight.constant =  self.reserveTableView.contentSize.height
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
        
    }
    
    func getallCommenAreasApi(startdate:Int,endDate:Int){
        self.showLoader()
        
//        let timeInMiliSecDate = startdate//Date()
//        let timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
//
//        let timeInMiliSecEndDate = endDate//Date()
//        let secEndDatetimeInMili = Int (timeInMiliSecEndDate.timeIntervalSince1970 * 1000)
        
          startMiliSecond = startdate
          endMiliSecond = endDate
       
        //30 * 24 * 60 * 60 * 1000
        let dic : [String:Any] = ["startDate":startMiliSecond,"endDate": endMiliSecond,"userId":ShareData.shareInfo.obj?.id ?? ""]
        userhandler.getallCommenAreas(params: dic) { response in
            self.hidLoader()
            if response?.success == true {
                self.commenAreasdata =  (response?.data)!
                
                for item in self.commenAreasdata ?? [] {
                    if self.eventdata?.reservation?.zone?.id == item.zoneId {
                        item.isSelected = true
                        self.reservationName =  item.name ?? ""
                        self.reservationId = item.zoneId ?? ""
                    }
                }
                
                self.reserveTableView.reloadData()
                self.reserveTableHeight.constant =  self.reserveTableView.contentSize.height
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
               
            } else {
                self.alert(message: response?.message ?? "")
            }
        } Failure: { error in
            self.hidLoader()
            self.alert(message: error.message)
        }

    }
    
    
    @IBAction func searchAction(_ sender: UIButton) {
        
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
    
    
    func searchApi(phone:String){
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
                self.checkRegisterUser.append(checkUserExistModel(name: response?.data?.name ?? "", phone: phone, isregister: false, guestid:""))
               }
            }
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
                       
                       
                   
//                   do {
//                               // setting a value for a key
//                       let newPerson = checkUserExistModel(name: response?.data?.name ?? "", phone: response?.data?.phoneNumber ?? "", isregister: true, guestid: response?.data?.id ?? "")
//                               
//                       checkRegisterUser.append(newPerson)
//                               let encodedData = try NSKeyedArchiver.archivedData(withRootObject: checkRegisterUser, requiringSecureCoding: false)
//                               UserDefaults.standard.set(encodedData, forKey: "contactList")
//                               
//                           } catch {
//                               print("There is Error:",error)
//                           }
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
           self.lblcount.text = "\(checkRegisterUser.count) Invitaciones)"
           //self.filterData =  self.checkRegisterUser
           self.tblView.reloadData()
       }, Failure: {error in
           self.hidLoader()
           self.alert(message: error.message)
       })
   }
   
    
    
    @IBAction func contactList(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ContactListVC") as? ContactListVC
        
        vc?.callBack = { selectedNumbers in
            
            for item in selectedNumbers {
                self.checkUserExistApi(name: item.name!,phone: item.number!)
            }
        }
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func StripAction(_ sender: UIButton) {
        if isNewReservation == false {
            
        } else {
            
            if self.commenAreasdata.count == 0 {
                self.alert(message: "No free reservarion areas")
                return
            }
        }
        
        if self.checkRegisterUser.count != 0 {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ConfirmEventVC") as? ConfirmEventVC
            vc?.isNewReservation = self.isNewReservation
            vc?.name = txtEvent.text! //eventDetaildata?.name ?? ""
        vc?.startDate = "\(startMiliSecond)"
        vc?.endDate = "\(endMiliSecond)"
        vc?.resevationid = reservationId
        vc?.duration = self.txtmint.text ?? ""
        vc?.reservationName = reservationName
        vc?.eventid = self.eventDetaildata?.id ?? ""
        if self.invitationsData?.count != 0 || self.invitationsData?.count != nil{
             vc?.guestNumber = self.invitationsData?[0].guestNumber ?? 0
        } else {
            vc?.guestNumber = 1
        }
        self.usersIDsarr.removeAll()
        for item in self.checkRegisterUser {
            if item.isregister == true {
               self.usersIDsarr.append(item.guestid)
            }
        }
        vc?.usersIDsarr = self.usersIDsarr
        vc?.isfromupdate = true
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { Ok,eventid in
            if Ok == true {
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                                let vc = storyBoard.instantiateViewController(withIdentifier:"HomeVC") as? HomeVC
                                
                                self.navigationController?.pushViewController(vc!, animated: true)
                
                
//                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier:"EventInvitation") as? EventInvitation
//                vc?.eventid = eventid
//                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        self.present(vc!, animated: false, completion: nil)
        } else {
            self.alert(message: "Please select the contact number whom you want to send invitation")
        }
    }
    
    
    func deleteInvitationApi(invid:String){
        userhandler.deleteInvitation(invitationid: invid, Success: {response in
            if response?.success == true {
                
            } else {
                
            }
        }, Failure: {error in
            self.alert(message: error.message)
        })
    }
    
    //MARK:- datepicker funtion
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtdate {
            self.datePickerConfig(DatePickerMood:.date)
            myDatePicker.showPickerInView(view, animated: true)
        } else if textField == txttime {
            self.datePickerConfig(DatePickerMood:.time)
            myDatePicker.showPickerInView(view, animated: true)
        }
    }
    
    
    //MARK:- datepicker funtion use to pick the time and date
    func datePickerConfig(DatePickerMood:UIDatePicker.Mode) {
        myDatePicker.delegate = self
        myDatePicker.minimumDate = Date()
        myDatePicker.toolbarBackgroundColor = UIColor.white
        myDatePicker.pickerBackgroundColor = UIColor.white
        myDatePicker.pickerMode = DatePickerMood
        // Customize title
        myDatePicker.title = ""
        myDatePicker.titleFont = UIFont.systemFont(ofSize: 16)
        myDatePicker.titleColor = UIColor.white
        if #available(iOS 13.4, *) {
            myDatePicker.picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        myDatePicker.picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(canceleDatePicker))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(onClickDoneButton))
        myDatePicker.leftButtons = [ cancel]
        myDatePicker.rightButtons = [doneButton]
    }
    @objc func canceleDatePicker() {
       /// myDatePicker.hidePicker(true)
        myDatePicker.pressedCancel(self)
    }

    //Toolbar done button function
    @objc func onClickDoneButton() {
        myDatePicker.hidePicker(true)
        
    }
    
    @objc func datePickerValueChanged(_ picker : UIDatePicker) {
        print(picker.date)
        
        if picker.datePickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.date)
            self.txtdate.text = stringDate
            startDatemyDate = picker.date
            
            
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.date)
            self.txttime.text = stringDate
            endDatemyDate = picker.date
            //getallCommenAreasApi(startdate:startDatemyDate,endDate:endDatemyDate)
        }
        getallCommenAreasApi(startdate:Int (startDatemyDate.timeIntervalSince1970 * 1000), endDate: Int (endDatemyDate.timeIntervalSince1970 * 1000))
    }
    
    
    
    
}
//MARK:- tableview datesource and delegate
extension UpdateEventVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
           return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  tableView == reserveTableView  {
            return  self.commenAreasdata.count ?? 0
        } else {
            return self.checkRegisterUser.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView ==  reserveTableView {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "NearChoosCell") as? NearChoosCell
            self.view.setNeedsLayout()
            cell?.lblname.text = self.commenAreasdata[indexPath.row].name
            cell?.lblvenu.text = self.commenAreasdata[indexPath.row].name
            cell?.lblactive.text = self.commenAreasdata[indexPath.row].status?.name
            
            
            if self.commenAreasdata[indexPath.row].isSelected == true {
                cell?.mainView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                cell?.mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            return cell!
        } else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "RecordDetailCell") as? RecordDetailCell
            if self.checkRegisterUser[indexPath.row].isregister == true {
                
                cell?.tick.image = UIImage(named:"ic-check-2")
            } else {
                cell?.tick.image = UIImage(named:"ic-cancel")
            }
            
            
            cell?.lblname.text = self.checkRegisterUser[indexPath.row].name
            cell?.lblphone.text = self.checkRegisterUser[indexPath.row].phoneemail
            cell?.callBack = { istrue in
                
//                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier:"CancelEventInvitationVC") as? CancelEventInvitationVC
//                vc?.modalPresentationStyle = .overFullScreen
//
//                self.present(vc!, animated: false, completion: nil)
            }
            return cell!
    }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == reserveTableView {
            
            for item in 0..<self.commenAreasdata.count{
                self.commenAreasdata[item].isSelected = false
                }
            self.commenAreasdata[indexPath.row].isSelected = true
            reservationName =  self.commenAreasdata[indexPath.row].name ?? ""
            reservationId = self.commenAreasdata[indexPath.row].zoneId ?? ""
            self.isNewReservation = true
                self.reserveTableView.reloadData()
        } else {
            if self.checkRegisterUser[indexPath.row].isregister == true {
                
                
                
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
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tblView == tableView {
            let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
   
                    debugPrint("Delete tapped")
                self.deleteInvitationApi(invid:self.invitationsData?[indexPath.row].id ?? "")
                self.checkRegisterUser.remove(at: indexPath.row)
                self.lblcount.text = "\(self.checkRegisterUser.count) Invitaciones)"
                
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
    
    //MARK:- datepicker delegates 
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        if picker.pickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txtdate.text = stringDate
            startDatemyDate = picker.pickerDate
            //getallCommenAreasApi(startdate:startDatemyDate,endDate:endDatemyDate)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txttime.text = stringDate
            endDatemyDate = picker.pickerDate
            //getallCommenAreasApi(startdate:startDatemyDate,endDate:endDatemyDate)
        }
        getallCommenAreasApi(startdate:Int (startDatemyDate.timeIntervalSince1970 * 1000), endDate: Int (endDatemyDate.timeIntervalSince1970 * 1000))
    }
    func datePickerDidAppear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }

    private func  datePicker(picker: SMDatePicker, didPickDate date: NSDate) {
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    func  datePickerDidCancel(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }

    func  datePickerWillDisappear(_ picker: SMDatePicker) {
        print(picker.pickerDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    func  datePickerDidDisappear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
}
