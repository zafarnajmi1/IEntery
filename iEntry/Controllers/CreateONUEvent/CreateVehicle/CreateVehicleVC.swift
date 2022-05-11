//
//  CreateVehicleVC.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class CreateVehicleVC: BaseController {

    @IBOutlet weak var txtvin: MDCOutlinedTextField!
    
    @IBOutlet weak var txtmarca: MDCOutlinedTextField!
    
    @IBOutlet weak var txtsubmarca: MDCOutlinedTextField!
    
    @IBOutlet weak var txtmodel: MDCOutlinedTextField!
    @IBOutlet weak var txtcolor: MDCOutlinedTextField!
    @IBOutlet weak var txtsn: MDCOutlinedTextField!
    
    @IBOutlet weak var txtplaces: MDCOutlinedTextField!
    
    var callBack: (()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMDCTxtFieldDesign(txtfiled: txtmarca, Placeholder: "MARCA".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtsubmarca, Placeholder: "SUB - MARCA".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtmodel, Placeholder: "MODELO".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtplaces, Placeholder: "PLACAS".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtcolor, Placeholder: "COLOR".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtsn, Placeholder: "S/N".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtvin, Placeholder: "VIN".localized, imageIcon:UIImage())
        
        
    }
    
    
    
    func checkData() -> Bool {
        if txtmarca.text == "" {
            self.alert(message: "Please Enter Marca")
            return false
        } else if txtsubmarca.text == "" {
            self.alert(message: "Please Enter Sub-Marca")
            return false
        } else if txtmodel.text == "" {
            self.alert(message: "Please Enter Model")
            return false
        } else if txtcolor.text == "" {
            self.alert(message: "Please Enter Color")
            return false
        } else if txtplaces.text == "" {
            self.alert(message: "Please Enter Plate")
            return false
        } else if txtsn.text == "" {
            self.alert(message: "Please Enter S/N")
            return false
        } else if txtvin.text == "" {
            self.alert(message: "Please Enter VIN")
            return false
        }
        return true
    }
    
    
    @IBAction func confirmAction(_ sender: UIButton) {
        if checkData() {
            createVehicleApi()
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createVehicleApi(){
        self.showLoader()
        
        let dic : [String:Any] = ["brand":self.txtmarca.text!,"color":txtcolor.text!,"createdAt":0,"model":txtmodel.text!,"plate":txtplaces.text!,"serialNumber":txtsn.text!,"subBrand":txtsubmarca.text!,"updatedAT":0,"vin":txtvin.text!]
        
        userhandler.createVehicle(parms: dic, Success: {response in
            self.hidLoader()
            if response?.success == true  {
                self.dismiss(animated: true, completion: nil)
                self.callBack?()
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    
    
}