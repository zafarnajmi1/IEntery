//
//  PopUpNumberOFInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 24/01/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class PopUpNumberOFInvitationVC: BaseController {
    @IBOutlet weak var txtnumber: MDCOutlinedTextField!
    var callBack: ((_ number:String) ->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.2935282726)
        setMDCTxtFieldDesign(txtfiled: txtnumber, Placeholder: "NO INIVITADOS", imageIcon: UIImage())
        
        
    }
    

    @IBAction func acceptAction(_ sender: UIButton) {
        if txtnumber.text == "" {
            self.alert(message: "please enter invitation number")
            return
        }
        self.callBack?(txtnumber.text!)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
