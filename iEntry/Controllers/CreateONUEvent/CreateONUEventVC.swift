//
//  CreateONUEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 27/04/2022.
//

import UIKit
import SMDatePicker
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class CreateONUEventVC: BaseController,UITextFieldDelegate, SMDatePickerDelegate {

    @IBOutlet weak var txtname: MDCOutlinedTextField!
    
    
    @IBOutlet weak var txtpurpose: MDCOutlinedTextField!
    
    
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    
    @IBOutlet weak var txthours: MDCOutlinedTextField!
    
    @IBOutlet weak var txtduration: MDCOutlinedTextField!
    
    @IBOutlet weak var txtaccompainment: MDCOutlinedTextField!
    @IBOutlet weak var txtzone: MDCOutlinedTextField!
    @IBOutlet weak var txtunitsection: MDCOutlinedTextField!
    
    var starttimeInMiliSecDate = 0
    var endtimeInMiliSecDate = 0
    let timeInMiliSecDate = Date()
    var timeInMiliSec = 0
    var myDatePicker: SMDatePicker = SMDatePicker()
    var getAllZonedata : [GetAllZonesModelData]? = nil
    var MainDrowpDown = DropDown()
    var zondid = ""
    var param = eventDic()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtdate.delegate = self
        txthours.delegate = self
        self.navigationBarHidShow(isTrue: true)
        
        let timeInMiliSecDate = Date()
        let timeInMiliSecEndDate = Date()
    
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate1 = dateFormatter1.string(from: timeInMiliSecDate)
        self.txtdate.text = stringDate1
       
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm:ss"
        let stringDate2 = dateFormatter2.string(from: timeInMiliSecEndDate)
        self.txthours.text = stringDate2
        
     starttimeInMiliSecDate = Int (Date().timeIntervalSince1970 * 1000)
     endtimeInMiliSecDate = Int (Date().timeIntervalSince1970 * 1000)
        
        self.setUIView()
        self.getAllZonesApi()
    }
    
    func setUIView(){
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized, imageIcon: UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtduration, Placeholder: "DURACIÓN".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txthours, Placeholder: "HORA".localized, imageIcon: UIImage(named: "ic-calendar-2")!)
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "FECHA".localized, imageIcon: UIImage(named: "ic-calendar-1")!)
        
        setMDCTxtFieldDesign(txtfiled: txtzone, Placeholder: "ZONAS".localized, imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtaccompainment, Placeholder: "ACOMPAÑAMIENTO".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtpurpose, Placeholder: "PROPOSITO DE LA VISITA".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtunitsection, Placeholder: "UNIDAD / SECCIÓN".localized, imageIcon: UIImage())
        txtduration.keyboardType = .numberPad
       
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func zoneAction(_ sender: UIButton) {
        
        var  zoneList = [String]()
     for item in self.getAllZonedata ?? [] {
         zoneList.append(item.name ?? "")
     }
         dropDownConfig(txtField: txtzone
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

            self.txtzone.text = item
            self.zondid = self.getAllZonedata?[index].id ?? ""
            
        }
        MainDrowpDown.show()
    }
    @IBAction func sendAction(_ sender: UIButton) {
        
        if checData() {
            
            self.param.dic.updateValue(txtname.text ?? "", forKey: "name")
            self.param.dic.updateValue(txtduration.text ?? "", forKey: "duration")
            self.param.dic.updateValue(timeInMiliSec, forKey: "startDate")
            self.param.dic.updateValue(timeInMiliSec, forKey: "endDate")
            self.param.dic.updateValue(txtpurpose.text ?? "", forKey: "visitPurpose")
            self.param.dic.updateValue(txtaccompainment.text ?? "", forKey: "accompanied")
            self.param.dic.updateValue(txtunitsection.text ?? "", forKey: "unitSection")
            self.param.dic.updateValue(self.zondid, forKey: "zonid")
            
            let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"ONUEventInvitationVC") as? ONUEventInvitationVC
            vc?.param = self.param
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    
    func checData() -> Bool {
         if txtname.text == "" {
            self.alert(message: "Please Enter The Name")
            return false
        } else
        if txtdate.text == "" {
            self.alert(message: "Please Select The Date")
            return false
            
        } else if txtduration.text == "" {
            self.alert(message: "Please Enter The Duration")
            return false
        }else if txthours.text == "" {
            self.alert(message: "Please Select The Time")
            return false
        } else if txtunitsection.text == "" {
            self.alert(message: "Please Enter Unit Section")
            return false
        }else if txtpurpose.text == "" {
            self.alert(message: "Please Enter The Purpose")
            return false
        }else if txtaccompainment.text == "" {
            self.alert(message: "Please Enter The compainment")
            return false
        }else if txtzone.text == "" {
            self.alert(message: "Please Select The Zone")
            return false
        }
        
        return  true
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
            self.timeInMiliSec =  Int(picker.date.timeIntervalSince1970 * 1000)
            self.txtdate.text = stringDate
            
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.date)
            self.txthours.text = stringDate
            
        }
    }
    
    
    // //MARK:- datepicker delegates
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        if picker.pickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.timeInMiliSec =  Int(picker.pickerDate.timeIntervalSince1970 * 1000)
            self.txtdate.text = stringDate
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txthours.text = stringDate
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

struct eventDic {
    var dic:[String:Any] = [:]
    var invitationDic:[String:Any] = [:]
    var checkRegisterUser = [checkUserExistModel]()
}

