//
//  UpdateContractVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class UpdateContractVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var txtstartDate: MDCOutlinedTextField!
    @IBOutlet weak var txtendDate: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
        setMDCTxtFieldDesign(txtfiled: txtstartDate, Placeholder: "INICIO DE CONTRATO", imageIcon: UIImage(named: "ic-calendar-2")!)
        setMDCTxtFieldDesign(txtfiled: txtendDate, Placeholder: "FIN DE CONTRATO", imageIcon: UIImage(named: "ic-calendar-2")!)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func UpdateAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
