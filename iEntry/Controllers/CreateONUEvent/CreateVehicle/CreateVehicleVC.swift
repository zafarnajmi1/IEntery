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
    
    @IBAction func confirmAction(_ sender: UIButton) {
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
