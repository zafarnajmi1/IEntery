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
    
    @IBOutlet weak var sharePDFSwitch: UISwitch!
    @IBOutlet weak var gzBadgSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
    }
    

    func setUpView(){
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized, imageIcon:UIImage(named: "ic-user")!)
        
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "CORREO".localized, imageIcon:UIImage(named: "ic-invitation")!)
        setMDCTxtFieldDesign(txtfiled: txtphone, Placeholder: "CELULAR".localized, imageIcon:UIImage(named: "mobile-alt-solid")!)
        
        
        setMDCTxtFieldDesign(txtfiled: txtorganization, Placeholder: "ORGANIZACIÓN".localized, imageIcon:UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtpickupsite, Placeholder: "SITIO PARA RECOGER".localized, imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtnumberofcompanies, Placeholder: "NÚMERO DE ACOMPAÑANTES".localized, imageIcon:UIImage())
    }
    
    
    @IBAction func gzBadgeAction(_ sender: UISwitch) {
    }
    
    @IBAction func pdfShareAction(_ sender: UISwitch) {
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
