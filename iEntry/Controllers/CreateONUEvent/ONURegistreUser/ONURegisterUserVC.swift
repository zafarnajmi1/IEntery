//
//  ONURegisterUserVC.swift
//  iEntry
//
//  Created by ZAFAR on 09/05/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class ONURegisterUserVC: BaseController {

    @IBOutlet weak var txtname: MDCOutlinedTextField!
    
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    
    @IBOutlet weak var txtphone: MDCOutlinedTextField!
    
    @IBOutlet weak var txtorganization: MDCOutlinedTextField!
    
    
    @IBOutlet weak var txtpickupsite: MDCOutlinedTextField!
    
    
    @IBOutlet weak var txtnumberofcompanies: MDCOutlinedTextField!
    
    var callBack:((_ name:String, _ email:String, _ phone: String, _ organization:String, _ pickupSite:String, _ numberofCompanoin:String, _ bzbadge:Bool,_ ispdfShare:Bool )->Void)? = nil
    var ispdfshare = false
    var isbzBadge = false
    
    var number = ""
    var name = ""
    var email = ""
    var isAlreadyRegister = false
    @IBOutlet weak var sharePDFSwitch: UISwitch!
    @IBOutlet weak var gzBadgSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
        
        if isAlreadyRegister == true  {
            txtemail.text =  email
            txtphone.text = number
            txtname.text = name
        } else {
            
        }
    }
    

    func setUpView(){
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized, imageIcon:UIImage(named: "ic-user")!)
        
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "CORREO".localized, imageIcon:UIImage(named: "ic-invitation")!)
        setMDCTxtFieldDesign(txtfiled: txtphone, Placeholder: "CELULAR".localized, imageIcon:UIImage(named: "mobile-alt-solid")!)
        
        
        setMDCTxtFieldDesign(txtfiled: txtorganization, Placeholder: "ORGANIZACIÓN".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtpickupsite, Placeholder: "SITIO PARA RECOGER".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtnumberofcompanies, Placeholder: "NÚMERO DE ACOMPAÑANTES".localized, imageIcon:UIImage())
    }
    
    
    func preRegisterUser(){
        self.showLoader()
        let dic : [String:Any] = ["name":txtname.text ?? "","email":txtemail.text ?? "","phoneNumber":txtphone.text ?? ""]
        print(dic)
        userhandler.preRegisteration(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                //self.cancelAction(UIButton())
                //self.callback!(self.phoneNumberTextField.text!, self.txtname.text!)
                self.alert(message: response?.message ?? "")
                self.callBack?(self.txtname.text ?? "", self.txtemail.text ?? "", self.txtphone.text ?? "", self.txtorganization.text ?? "", self.txtpickupsite.text ?? "",self.txtnumberofcompanies.text ?? "",self.isbzBadge,self.ispdfshare)
                   self.dismiss(animated: true, completion: nil)
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    @IBAction func gzBadgeAction(_ sender: UISwitch) {
        
        if sender.isOn == true {
            isbzBadge = true
        } else {
            isbzBadge = false
        }
        
    }
    
    @IBAction func pdfShareAction(_ sender: UISwitch) {
        if sender.isOn == true {
            ispdfshare = true
        } else {
            ispdfshare = false
        }
    }
    
    func checkData() -> Bool {
        
        if txtname.text == "" {
            self.alert(message: "Please Enter Name")
            return false
        } else if txtemail.text == "" {
            self.alert(message: "Please Enter email")
            return false
        } else if txtphone.text == "" {
            self.alert(message: "Please Enter Phone Number")
            return false
        } else if txtpickupsite.text == "" {
            self.alert(message: "Please Enter Pick Up Site")
            return false
        } else if txtorganization.text == "" {
            self.alert(message: "Please Enter Organization")
            return false
        } else if txtnumberofcompanies.text == "" {
            self.alert(message: "Please Enter Companoin Number")
            return false
        }
        return true
    }
    
    
    
    @IBAction func confirmAction(_ sender: UIButton) {
        
        if checkData() {
            
            if isAlreadyRegister == false {
                
                preRegisterUser()
                
            } else {
                
                    self.callBack?(txtname.text ?? "", txtemail.text ?? "", txtphone.text ?? "", txtorganization.text ?? "", txtpickupsite.text ?? "",txtnumberofcompanies.text ?? "",self.isbzBadge,ispdfshare)
                self.dismiss(animated: true, completion: nil)
                 
            }
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
