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
    
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
    
    var loginVM = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        btnEnter.roundButtonWithCustomRadius(radius: 8)
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "EMAIL", imageIcon: trailingImage)
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
            self.alert(message: "Please Enter the Valid Email")
            return false
        }
        if txtemail.text?.isValidEmail != true {
            self.alert(message: "Please Enter the Valid Email")
            return false
        }
        return true
        
    }
    
    //MARK:- This funtion use to send the Email
    func sendEmailApi(){
        self.showLoader()
        loginVM.sendEmail(email: self.txtemail.text!, Success: {response , trycatch in
            self.hidLoader()
            if response?.success ?? false {
                self.moveOnMethod()
            } else {
                self.hidLoader()
                self.alert(message: trycatch ?? "somthing is wrong")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
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
