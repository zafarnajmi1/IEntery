//
//  AddContractorVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class AddContractorVC: BaseController {
    //MARK:- here are the iboutlet 
    @IBOutlet weak var txtDutyManager: MDCOutlinedTextField!
    
    @IBOutlet weak var txtCompany: MDCOutlinedTextField!
    
    @IBOutlet weak var txtEmail: MDCOutlinedTextField!
    
    @IBOutlet weak var txtPhone: MDCOutlinedTextField!
    
    @IBOutlet weak var txtacronmy: MDCOutlinedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
        
        
        setMDCTxtFieldDesign(txtfiled: txtacronmy, Placeholder: "ACRÓNIMO", imageIcon: UIImage())
        
        setMDCTxtFieldDesign(txtfiled: txtCompany, Placeholder: "COMPAÑIA", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtDutyManager, Placeholder: "ENCARGADO", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtEmail, Placeholder: "CORREO", imageIcon: UIImage(named: "ic-invitation")!)
        setMDCTxtFieldDesign(txtfiled: txtPhone, Placeholder: "CELULAR", imageIcon: UIImage(named: "mobile-alt-solid")!)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
