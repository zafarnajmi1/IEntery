//
//  LanguageChangeAlertVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/06/2022.
//

import UIKit

class LanguageChangeAlertVC: UIViewController {

    //MARK:- here are iboutlet
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var lblinvitationNametitle: UILabel!
    @IBOutlet weak var lblcancelinvitationtitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnconfirm: UIButton!
    var callBack: (()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
        btnconfirm.roundViewWithCustomRadius(radius: 5)
        mainView.roundViewWithCustomRadius(radius: 8)
        
        self.lblcancelinvitationtitle.text = "CAMBIO DE LANGUAGE".localized
        self.lblinvitationNametitle.text = "¿Estas seguro de querer cambiar el lenguage a español? Los cambios se verán reflejados en automático.".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnconfirm.setTitle("ACEPTAR".localized, for: .normal)
    
    }
    
    //MARK:- dismiss the  controller
    @IBAction func crossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        callBack?()
    }
    
    

}
