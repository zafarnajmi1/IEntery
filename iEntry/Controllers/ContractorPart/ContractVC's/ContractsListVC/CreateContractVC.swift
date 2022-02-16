//
//  CreateContractVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class CreateContractVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var txtendDate: MDCOutlinedTextField!
    @IBOutlet weak var txtstartDate: MDCOutlinedTextField!
    @IBOutlet weak var txtcompany: MDCOutlinedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
        setMDCTxtFieldDesign(txtfiled: txtcompany, Placeholder: "COMPAÑIA", imageIcon: UIImage(named: "sort-down-solid")!)
        setMDCTxtFieldDesign(txtfiled: txtstartDate, Placeholder: "INICIO DE CONTRATO", imageIcon: UIImage(named: "ic-calendar-2")!)
        setMDCTxtFieldDesign(txtfiled: txtendDate, Placeholder: "FIN DE CONTRATO", imageIcon: UIImage(named: "ic-calendar-2")!)
        self.stripView.roundViiew()
    }
    

    @IBAction func stripAction(_ sender: UIButton) {
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
