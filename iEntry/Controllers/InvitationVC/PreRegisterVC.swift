//
//  PreRegisterVC.swift
//  iEntry
//
//  Created by ZAFAR on 25/12/2021.
//

import UIKit
import SMDatePicker
import DropDown
import FlagPhoneNumber
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class PreRegisterVC: BaseController,UITextFieldDelegate, SMDatePickerDelegate{
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var lbluserdatatitle: UILabel!
    var phoneNumberCode = ""
    var callback : ((_ number:String, _ name:String)->Void)? = nil
    @IBOutlet weak var btnaccept: UIButton!
    var myDatePicker: SMDatePicker = SMDatePicker()
    @IBOutlet weak var txtname: MDCOutlinedTextField!
    @IBOutlet weak var txtemail: MDCOutlinedTextField!
//    lazy var closeButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(image: UIImage(contentsOfFile:"ic-cancel"),
//                        style: .plain,
//                        target: self,
//                        action: #selector(closeNumberPickerView))
//        button.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//        return button
//    }()
    @IBOutlet weak var phoneNumberTextField:MDCOutlinedTextField!
        
        
        
//        FPNTextField! {
//        didSet {
//            phoneNumberTextField.displayMode = .list
//            phoneNumberTextField.flagButtonSize = CGSize(width: 36, height: 36)
//            phoneNumberTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
////            phoneNumberTextField.placeHolderColor = Asset.Colors.lightGray.color
////            phoneNumberTextField.trailingCodeImage = Asset.Media.downArrow.image
////            phoneNumberTextField.font = .init(commonFont: PoppinsFontStyle.regular, size: 16)
//            phoneNumberTextField.delegate = self
//            phoneNumberTextField.setFlag(key: .FR)
//            phoneNumberTextField.setFlag(countryCode: .FR)
//
//        }
//    }
    var number = ""
    var name = ""
    @IBOutlet weak var mainView: UIView!
    
    var MainDrowpDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.2935282726)
        setMDCTxtFieldDesign(txtfiled: txtname, Placeholder: "NOMBRE".localized, imageIcon: UIImage(named: "ic-user")!)
        setMDCTxtFieldDesign(txtfiled: txtemail, Placeholder: "Email".localized, imageIcon: UIImage(named: "ic-invitation")!)
        
        
        setMDCTxtFieldDesign(txtfiled: phoneNumberTextField, Placeholder: "CELULAR".localized, imageIcon: UIImage(named: "mobile-alt-solid")!)
        
        self.lbluserdatatitle.text = "D A T O S DE U S U A R I O".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnaccept.setTitle("ENVIAR".localized, for: .normal)
        self.navigationBarHidShow(isTrue: true)
        mainView.roundViewWithCustomRadius(radius: 8)
        btnaccept.roundButtonWithCustomRadius(radius: 6)
        self.phoneNumberTextField.text = number
        self.txtname.text = name
        self.phoneNumberTextField.delegate = self
    }

    func checkData() ->Bool {
        
        if txtname.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter The Name")
            return  false
        } else if txtemail.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter The Email")
            return  false
        }else if phoneNumberTextField.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter The Phone")
            return  false
        }
        return true
    }
    
    
    func preRegisterUser(){
        self.showLoader()
        let dic : [String:Any] = ["name":txtname.text!,"email":txtemail.text!,"phoneNumber":self.phoneNumberTextField.text!]
        print(dic)
        userhandler.preRegisteration(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.cancelAction(UIButton())
                self.callback!(self.phoneNumberTextField.text!, self.txtname.text!)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
                self.dismiss(animated: true, completion: nil)
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 14
    }
    @IBAction func registerAction(_ sender: UIButton) {
        if checkData() {
            
            self.preRegisterUser()
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//extension PreRegisterVC: FPNTextFieldDelegate {
//    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
//        self.phoneNumberCode = dialCode
//        print("Countery Code :",code)
//    }
//
//    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
//
//        if isValid {
//
//                textField.getFormattedPhoneNumber(format: .International)  // Output "+33 6 00 00 00 01"
//             } else {
//                // Do something...
//             }
//    }
//
//    func fpnDisplayCountryList() {
//        let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
//        let navigationViewController = UINavigationController(rootViewController: listController)
//
//        //UINavigationController.navigationBar.tintColor =  #colorLiteral(red: 0.168627451, green: 0.2862745098, blue: 0.5960784314, alpha: 1)//Asset.Colors.gray.color
//
//        listController.title = "Countries"
//
//        listController.setup(repository: phoneNumberTextField.countryRepository)
//        listController.didSelect = { [weak self] country in
//        self?.phoneNumberTextField.setFlag(countryCode: country.code)
//        }
//
//        listController.navigationItem.leftBarButtonItem = closeButton
//
//        self.present(navigationViewController, animated: true, completion: nil)
//    }
//
//    @objc
//    func closeNumberPickerView() {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
