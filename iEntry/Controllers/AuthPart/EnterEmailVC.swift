//
//  EnterEmailVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class EnterEmailVC: BaseController {
    //MARK:- Here are IBOutlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var btncancel: UIButton!
    
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    
    var loginVM = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        btnEnter.roundButtonWithCustomRadius(radius: 8)
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "EMAIL".localized, imageIcon: trailingImage)

        
        
        self.lbldetail.text = "INGRESE CORREO DEL LA CUENTA A RECUPERAR CONTRASEÑA".localized
        self.txtemail.placeholder = "EMAIL".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        
        self.btnEnter.setTitle("ACEPTAR".localized, for: .normal)
        
        
    }
    let trailingImage: UIImage = {
      return UIImage.init(named: "ic-invitation",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
//MARK:- Checking the null able paramters
    func checkData() -> Bool{
        if txtemail.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter the Valid Email")
            return false
        }
        if txtemail.text?.isValidEmail != true {
            AppUtility.showErrorMessage(message: "Please Enter the Valid Email")
            return false
        }
        return true
        
    }
    
    //MARK:- This funtion use to send the Email
    func sendEmailApi(){
        self.showLoader()
        ShareData.shareInfo.token = ""
        loginVM.sendEmail(email: self.txtemail.text!, Success: {response , trycatch in
            self.hidLoader()
            if response?.success ?? false {
                self.moveOnMethod()
            } else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: trycatch ?? "somthing is wrong")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    @IBAction func EnterAction(_ sender: UIButton) {
        if checkData() {
            self.sendEmailApi()
        }
    }
    
    func moveOnMethod(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"MethodVC") as? MethodVC
        vc?.email = txtemail.text!
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func cancelAction(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)
    }
}
