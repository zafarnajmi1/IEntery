//
//  InvitationPOPUpVC.swift
//  iEntry
//
//  Created by ZAFAR on 24/08/2021.
//

import UIKit
import SMDatePicker
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class InvitationPOPUpVC: BaseController ,UITextFieldDelegate, SMDatePickerDelegate{
    @IBOutlet weak var lblenternumberofguesttitle: UILabel!
    
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var lblinvitationtitle: UILabel!
    var invitationlist = [InvitationsHistoryModel]()
    var callBack : ((_ number:String)->Void)? = nil
    @IBOutlet weak var btnaccept: UIButton!
    var myDatePicker: SMDatePicker = SMDatePicker()
    @IBOutlet weak var txttime: MDCOutlinedTextField!
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    @IBOutlet weak var txtnumberInvitayion: MDCOutlinedTextField!
    
    @IBOutlet weak var txtZone: MDCOutlinedTextField!
    
    @IBOutlet weak var lblnumber: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    var getAllZonedata : [GetAllZonesModelData]? = nil
    var MainDrowpDown = DropDown()
    var zondid = ""
    var guestid = ""
     var name = ""
    var phone = ""
    var isfromHistory = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.lblenternumberofguesttitle.text = "Ingrese el número de invitados que llegarán".localized
        self.lblinvitationtitle.text = "I N V  IT A C I Ó N".localized
        txtnumberInvitayion.keyboardType = .numberPad
        setMDCTxtFieldDesign(txtfiled: txttime, Placeholder: "HORA".localized, imageIcon: UIImage(named: "ic-calendar-2")!)
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "FECHA".localized, imageIcon: UIImage(named: "ic-calendar-1")!)
        
            self.lblname.text = name
            self.lblnumber.text = phone
        
        setMDCTxtFieldDesign(txtfiled: txtZone, Placeholder: "ZONAS".localized, imageIcon: UIImage(named: "sort-down-solid")!)
        
        setMDCTxtFieldDesign(txtfiled: txtnumberInvitayion, Placeholder: "NO INIVITADOS".localized, imageIcon: UIImage())
        
        
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnaccept.setTitle("ENVIAR".localized, for: .normal)
        self.navigationBarHidShow(isTrue: true)
        mainView.roundViewWithCustomRadius(radius: 8)
        btnaccept.roundButtonWithCustomRadius(radius: 6)
        txtdate.delegate = self
        txttime.delegate = self
        getAllZonesApi()
    }
    

    
    func getAllZonesApi(){
        self.showLoader()
        let dic : [String:Any] = ["userId": ShareData.shareInfo.obj?.id ?? "", "companyId":ShareData.shareInfo.conractWithCompany?.company?.id ?? ""]
        userhandler.getAllZone(params: dic) { response in
            self.hidLoader()
            if response?.success == true {
                self.getAllZonedata = response?.data
            } else {
                self.alert(message: response?.message ?? "")
            }
        } Failure: { error  in
            self.hidLoader()
            self.alert(message: error.message)
        }

    }
    
    func createInvitationApi() {
        self.showLoader()
        let timeInMiliSecDate = Date()
        let timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
        print(timeInMiliSec)
        
        let zondic: [String:Any] = ["id":self.zondid]
        let managerdic : [String:Any] = ["id":ShareData.shareInfo.obj?.id ?? ""]
        let guestdic : [String:Any] = ["id": self.guestid]
        let dic : [String:Any] = ["guestNumber":txtnumberInvitayion.text!, "startDate":timeInMiliSec, "host":managerdic,"guest":guestdic,"zone":zondic]
        print(dic)
        //manager
        userhandler.createInvitation(params: dic, Success: {[self]response in
            self.hidLoader()
            if response?.success == true {
                self.cancelAction(UIButton())
                self.alert(message: response?.message ?? "")
                
                
                
                do {
                            // setting a value for a key
                    let newPerson = InvitationsHistoryModel(name:response?.data?.guest?.name ?? "", phone:response?.data?.guest?.phoneNumber ?? "", date:getCurrentDate(), guestid: response?.data?.guest?.id ?? "")
                            
                    self.invitationlist.append(newPerson)
                            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: invitationlist, requiringSecureCoding: false)
                            UserDefaults.standard.set(encodedData, forKey: "invitation")
                           
                        } catch {
                            print("There is Error:",error)
                        }
                
                
                
                self.callBack?(self.phone)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.alert(message: response?.message ?? "")
                self.dismiss(animated: true, completion: nil)
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message:error.message)
        })
    }
    
    
    func checData() -> Bool {
        if txtdate.text == "" {
            self.alert(message: "Please Select The Date")
            return false
            
        } else if txttime.text == "" {
            self.alert(message: "Please Select The Time")
            return false
        } else if txtZone.text == "" {
            self.alert(message: "Please Select The Zone")
            return false
        }
        
        return  true
    }
    
    
    
    @IBAction func zoneAction(_ sender: UIButton) {
        
           var  zoneList = [String]()
        for item in self.getAllZonedata ?? [] {
            zoneList.append(item.name ?? "")
        }
            dropDownConfig(txtField: txtZone
                           , data: zoneList)
           
        
    }
    //MARK:- this is general funtion that will use to appear the dropdown
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

            self.txtZone.text = item
            self.zondid = self.getAllZonedata?[index].id ?? ""
            
        }
        MainDrowpDown.show()
    }
    
    
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func aceptAction(_ sender: UIButton) {
        if checData() {
            createInvitationApi()
        }
    }
    //MARK:- textfield delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtdate {
            self.datePickerConfig(DatePickerMood:.date)
            myDatePicker.showPickerInView(view, animated: true)
        } else {
            self.datePickerConfig(DatePickerMood:.time)
            myDatePicker.showPickerInView(view, animated: true)
        }
    }
    
    
    //MARK:- general datepicker funtion
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
        if picker.datePickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.date)
            self.txtdate.text = stringDate
            
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.date)
            self.txttime.text = stringDate
            
        }
    }
    
    
    // //MARK:- datepicker delegates
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        if picker.pickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txtdate.text = stringDate
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txttime.text = stringDate
        }
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
