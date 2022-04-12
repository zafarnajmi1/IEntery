//
//  UserPersonalInfoVC.swift
//  iEntry
//
//  Created by ZAFAR on 24/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown
class UserPersonalInfoVC: BaseController {
    //MARK:- here are the iboutlet
    @IBOutlet weak var lblupdatetitle: UILabel!
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
    }

    func configData(){
        txtDob.text = ShareData.shareInfo.obj?.dob
        ttxphoneNumber.text = ShareData.shareInfo.obj?.phoneNumber
        txtemail.text = ShareData.shareInfo.obj?.email
        txtpassword.text = ShareData.shareInfo.obj?.password
        txtgender.text = ShareData.shareInfo.obj?.gender?.name
        //@IBOutlet weak var txtactive: MDCOutlinedTextField!
        txtname.text = ShareData.shareInfo.obj?.name
        
        //ShareData.shareInfo.contractData?.company?.id
    }
    
    
    func updateuserApi(){
        showLoader()

        
        let dic :[String:Any] = ["id":ShareData.shareInfo.obj?.id ?? "","name":txtname.text!,"phoneNumber":ttxphoneNumber.text!,"dob":txtDob.text ?? "","email":txtemail.text!,"password":txtpassword.text ?? "","deviceId":"","firebaseId":"ASDKJS-438h3D_ASJD!)RKASDJA","secret":"RTWUFGOLRDXALQ5R","gender":["id": txtgender.text!.lowercased() == "male" ? "1":"2"],"userType":["id":ShareData.shareInfo.obj?.userType?.id ?? 0],"status":["id":ShareData.shareInfo.obj?.status?.id ?? 0]]
        
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
