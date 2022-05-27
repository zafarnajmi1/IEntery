//
//  UserPersonalInfoVC.swift
//  iEntry
//
//  Created by ZAFAR on 24/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown
import SMDatePicker
class UserPersonalInfoVC: BaseController ,UITextFieldDelegate,SMDatePickerDelegate{
    //MARK:- here are the iboutlet
    @IBOutlet weak var btndropdown: UIButton!
    @IBOutlet weak var lblupdatetitle: UILabel!
    @IBOutlet weak var btnupdate: UIButton!
    @IBOutlet weak var lblinformationtitle: UILabel!
    @IBOutlet weak var bottomView: UIView!
    //@IBOutlet weak var txtCURP: MDCOutlinedTextField!
    @IBOutlet weak var txtDob: MDCOutlinedTextField!
    @IBOutlet weak var ttxphoneNumber: MDCOutlinedTextField!
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    @IBOutlet weak var txtpassword: MDCOutlinedTextField!
    @IBOutlet weak var txtgender: MDCOutlinedTextField!
    //@IBOutlet weak var txtactive: MDCOutlinedTextField!
    @IBOutlet weak var txtname: MDCOutlinedTextField!
    //@IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    var MainDrowpDown = DropDown()
    var timeInMiliSec = 0
    var myDatePicker: SMDatePicker = SMDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblinformationtitle.text = "Información".localized
        configData()
        self.navigationBarHidShow(isTrue: true)
        mainView.roundCorners([.topLeft,.topRight], radius: 20)
        self.lblupdatetitle.text = "ACTUALIZAR DATOS".localized
    
        bottomView.roundViewWithCustomRadius(radius:8 )
        
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized, imageIcon: UIImage(named: "user-regular")!)
        //setMDCTxtFieldDesign(txtfiled: txtactive, Placeholder: "Activo", imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtgender, Placeholder: "Masculino".localized, imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtpassword, Placeholder: "CONTRASEÑA".localized, imageIcon: UIImage(named: "eye-regular")!)
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "CORREO".localized, imageIcon: UIImage(named: "ic-invitation")!)
        setMDCTxtFieldDesign(txtfiled: ttxphoneNumber, Placeholder: "NO CELULAR".localized, imageIcon: UIImage(named: "mobile-alt-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtDob, Placeholder: "CUMPLEAÑOS".localized, imageIcon: UIImage(named: "ic-calendar-1")!)
        //setMDCTxtFieldDesign(txtfiled: txtCURP, Placeholder: "CURP", imageIcon: UIImage())
        txtDob.delegate = self
    }

    func configData(){
        txtDob.text = "\(ShareData.shareInfo.obj?.dob ?? 0)"
        ttxphoneNumber.text = ShareData.shareInfo.obj?.phoneNumber
        txtemail.text = ShareData.shareInfo.obj?.email
        txtpassword.text = ShareData.shareInfo.obj?.password
        txtgender.text = ShareData.shareInfo.obj?.gender?.name
        //@IBOutlet weak var txtactive: MDCOutlinedTextField!
        txtname.text = ShareData.shareInfo.obj?.name
        
        //ShareData.shareInfo.contractData?.company?.id
        
        if ShareData.shareInfo.userRole == .contractoremplyee || ShareData.shareInfo.userRole == .provideremployee{
            btndropdown.isUserInteractionEnabled = false
            txtDob.isUserInteractionEnabled = false
            ttxphoneNumber.isUserInteractionEnabled = false
            txtemail.isUserInteractionEnabled = false
            txtpassword.isUserInteractionEnabled = false
            txtgender.isUserInteractionEnabled = false
            //@IBOutlet weak var txtactive: MDCOutlinedTextField!
            txtname.isUserInteractionEnabled = false
            btnupdate.isUserInteractionEnabled = false
        } else {
            txtDob.isUserInteractionEnabled = true
            ttxphoneNumber.isUserInteractionEnabled = true
            txtemail.isUserInteractionEnabled = true
            txtpassword.isUserInteractionEnabled = true
            txtgender.isUserInteractionEnabled = true
            //@IBOutlet weak var txtactive: MDCOutlinedTextField!
            txtname.isUserInteractionEnabled = true
            btnupdate.isUserInteractionEnabled = true
            btndropdown.isUserInteractionEnabled = true
        }
        
        
        
    }
    
    //MARK:- textfield delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDob {
            self.datePickerConfig(DatePickerMood:.date)
            myDatePicker.showPickerInView(view, animated: true)
        }
    }
    
    
    
    //MARK:- general datepicker funtion
    func datePickerConfig(DatePickerMood:UIDatePicker.Mode) {
        myDatePicker.delegate = self
        myDatePicker.maximumDate = Date()
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
            let timeInMiliSecDate = picker.date
             timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
            print(timeInMiliSec)
            self.txtDob.text = stringDate
            
        }
    }
    
    
    // //MARK:- datepicker delegates
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        if picker.pickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            let timeInMiliSecDate = picker.pickerDate
             timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
            print(timeInMiliSec)
            self.txtDob.text = stringDate
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

    
    func updateuserApi(){
        showLoader()

        
        let dic :[String:Any] = ["id":ShareData.shareInfo.obj?.id ?? "","name":txtname.text!,"phoneNumber":ttxphoneNumber.text!,"dob":self.timeInMiliSec,"email":txtemail.text!,"password":txtpassword.text ?? "","deviceId":"","firebaseId":"ASDKJS-438h3D_ASJD!)RKASDJA","secret":"RTWUFGOLRDXALQ5R","gender":["id": txtgender.text!.lowercased() == "male" ? "1":"2"],"userType":["id":ShareData.shareInfo.obj?.userType?.id ?? 0],"status":["id":ShareData.shareInfo.obj?.status?.id ?? 0]]
        
        userhandler.updateuser(companyid: ShareData.shareInfo.contractData?.company?.id ?? "", param: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                ShareData.shareInfo.saveUser(user: response?.data)
                UserDefaults.standard.save(customObject: response?.data, inKey: "user")
                self.navigationController?.popViewController(animated: true)
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message:error.message)
        })
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func checkData() -> Bool {
        if txtname.text == ""{
            self.alert(message: "Enter the Name")
            return false
        }  else if ttxphoneNumber.text! == "" {
            self.alert(message: "Enter the Number ")
            return false
        }else if txtemail.text! == "" {
            self.alert(message: "Enter the Email ")
            return false
        }else if txtpassword.text! == "" {
            self.alert(message: "Enter the password ")
            return false
        }else if txtgender.text! == "" {
            self.alert(message: "Enter the Gender ")
            return false
        }
        return true
    }
    
    
    @IBAction func bottomAction(_ sender: UIButton) {
        if checkData() {
           self.updateuserApi()
        }
    }
    
    @IBAction func genderDropDownAction(_ sender: UIButton) {
        dropDownConfig(txtField : txtgender, data:["Male","Female"])
    }
    //MARK:- its a genral dropdown function to appear the dropdown
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
          self.txtgender.text = item

        }
        MainDrowpDown.show()
    }
}
