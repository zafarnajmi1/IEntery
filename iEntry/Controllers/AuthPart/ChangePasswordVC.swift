//
//  ChangePasswordVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit

import MaterialComponents.MaterialTextControls_OutlinedTextFields

class ChangePasswordVC: BaseController {
    
    @IBOutlet weak var lblenternewpassword: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnEnter: UIButton!

    @IBOutlet weak var txtpassword: MDCOutlinedTextField!
    var userData : GetUserByEmailModel?
     var email = ""
    var isfrom = false
    var loginVM = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        btnEnter.roundButtonWithCustomRadius(radius: 8)
        TextFieldConfig()
        self.getuserUserByEmail()
        
        
        
//        "INGRESE NUEVA CONTRASEÑA PARA CONTINUAR" = "INGRESE NUEVA CONTRASEÑA PARA CONTINUAR";
//        "PASSWORD" = "PASSWORD";
//        "ENTRAR" = "ENTRAR";
        
        self.lblenternewpassword.text = "INGRESE NUEVA CONTRASEÑA PARA CONTINUAR".localized
        self.txtpassword.placeholder = "PASSWORD".localized
        self.btnEnter.setTitle("ENTRAR".localized, for: .normal)
    }
    
    
    func TextFieldConfig() {
        
        setMDCTxtFieldDesign(txtfiled: txtpassword, Placeholder: "PASSWORD", imageIcon: trailingImage)
        
        let number = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        txtpassword.trailingView?.addGestureRecognizer(number)
        
        txtpassword.trailingView?.isUserInteractionEnabled = true
    
//        txtpassword.placeholder = "PASSWORD"
//
//        //txtpassword.delegate = self
//
//        //txtpassword.text = "Grace Hopper"
////        txtpassword.leadingView = UIImageView(image: leadingImage)
////        txtpassword.leadingViewMode = .always
//        txtpassword.trailingView = UIImageView(image: trailingImage)
//        txtpassword.trailingViewMode = .always
//        txtpassword.label.text = "PASSWORD"
//        //txtpassword.placeholder = "555-555-5555"
//
//        txtpassword.floatingLabelColor(for: .normal)
//        txtpassword.tintColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
//
//        txtpassword.setOutlineColor( .black, for: .editing)
//        txtpassword.setOutlineColor( .red , for: .disabled)
//        txtpassword.setOutlineColor( .red , for: .normal)
//        txtpassword.containerRadius = 10
    }
    
    
    
    
    var leadingImage: UIImage = {
      return UIImage.init(named: "eye-regular",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    var trailingImage: UIImage = {
      return UIImage.init(named: "eye-regular",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if  txtpassword.isSecureTextEntry {
            trailingImage = UIImage.init(named: "eye-regular")!
        } else {
            trailingImage = UIImage.init(named: "eye-slash-solid")!
        }
        
        
    
        txtpassword.isSecureTextEntry = !txtpassword.isSecureTextEntry
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    func checkData() -> Bool {
        
        if txtpassword.text == "" {
            self.alert(message: "Please Enter The Password")
            return false
        }
        
        if txtpassword.text!.count < 6 {
            self.alert(message: "Password Minimum Length 6 Characters")
            return false
        }
        if txtpassword.text!.count > 15 {
            self.alert(message: "Password Maximum Length 15 Characters")
            return false
        }
        return true
    }
    
    func getuserUserByEmail() {
        self.showLoader()
        loginVM.getUserByEmail(email: email, Success: { response  in
            self.hidLoader()
            if response?.status?.lowercased() == "ok" {
                self.userData = response
            } else {
                self.alert(message: response?.message ?? "")
            }
            
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    
    //MARK:- this fun use to chnage the password 
    func changePassword() {
        self.showLoader()
        let dic : [String:Any] = ["password":txtpassword.text!]
        loginVM.updatePAssword(userid: email, parms: dic, Success: {response , trycatch in
            self.hidLoader()
            if response?.success ?? true{
                if self.isfrom {
                    self.moveOnLogin()
                } else{
                self.moveOnPermission()
                }
            } else {
                self.hidLoader()
                self.alert(message: trycatch ?? "Sonthing Is Wrong")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    
    func moveOnPermission() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"PermissionVC") as? PermissionVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func moveOnLogin() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func EnterAction(_ sender: UIButton) {
        if checkData() {
            self.changePassword()
        }
    }
    
}
