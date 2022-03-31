//
//  VerificationCodeVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit

class VerificationCodeVC: BaseController,UITextFieldDelegate {
    
    //MARK:- Here are the IBOutlet
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fiveView: UIView!
    
    @IBOutlet weak var sixView: UIView!
    @IBOutlet weak var fourView: UIView!
    
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblwelcome: UILabel!
    
    @IBOutlet weak var lbltimerdetail: UILabel!
    
    
    @IBOutlet weak var txtone: UITextField!
    @IBOutlet weak var txttwo: UITextField!
    @IBOutlet weak var txtthree: UITextField!
    
    @IBOutlet weak var txtfour: UITextField!
    
    @IBOutlet weak var txtsix: UITextField!
    @IBOutlet weak var txtfive: UITextField!
    private var timer: Timer?
    
    var count = 1*59
    var otpTex = ""
    var email = ""
    var isfrom = false
    var loginVM = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congFigUI()
        self.startTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    func startTime() {
        
                guard timer == nil else { return }
            timer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
    }
    
    @objc func updateTimer() {
        if count > 0 {
            count -= 1
            lbltime.text = "\(count),s"
        } else {
            timer?.invalidate()
            timer = nil
            //self.sendEmailApi()
        }
    }
    
    //MARK:- This Funtion use to set the UI
    func congFigUI() {
        let yourAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Montserrat-Regular", size: 12)!,
              .foregroundColor:#colorLiteral(red: 0.7175678015, green: 0.7176927924, blue: 0.7175598741, alpha: 1),
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        
        let attributeString = NSMutableAttributedString(
                string: "Nunca llevo el mensaje, enviarlo nuevamente",
                attributes: yourAttributes
             )
             btnBottom.setAttributedTitle(attributeString, for: .normal)
        
        
        self.oneView.VerificationcodeViews()
        self.twoView.VerificationcodeViews()
        self.threeView.VerificationcodeViews()
        self.fourView.VerificationcodeViews()
        self.fiveView.VerificationcodeViews()
        self.sixView.VerificationcodeViews()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        txtone.delegate = self
        txttwo.delegate = self
        txtthree.delegate = self
        txtfour.delegate = self
        txtfive.delegate = self
        txtsix.delegate = self
    
    
    self.oneView.VerificationcodeViews()
    self.twoView.VerificationcodeViews()
    self.threeView.VerificationcodeViews()
    self.fourView.VerificationcodeViews()
    self.fiveView.VerificationcodeViews()
    self.sixView.VerificationcodeViews()
    self.mainView.roundViewWithCustomRadius(radius: 10)
    
        txtone.textContentType = .oneTimeCode
        txttwo.textContentType = .oneTimeCode
        txtthree.textContentType = .oneTimeCode
        txtfour.textContentType = .oneTimeCode
        txtfive.textContentType = .oneTimeCode
        txtsix.textContentType = .oneTimeCode
        txtone.becomeFirstResponder()
        
        
        self.btnBottom.setTitle("Nunca llevo el mensaje, enviarlo nuevamente".localized, for: .normal)
        self.lblwelcome.text = "BIENVENIDO !!!".localized + (ShareData.shareInfo.obj?.name)!
        self.lbltimerdetail.text = "para continuar necesitamos saber algunos datos personales pero antes necesitamos confirmar tu cuenta. En cuestión de segundos te llegará un mensaje de texto que se leerá solo.".localized
        self.lbltimerdetail.text = "Tiempo de vida del mensaje:".localized

        
    
}

func dismissKeyboard(){

    self.otpTex = "\(self.txtone.text ?? "")\(self.txttwo.text ?? "")\(self.txtthree.text ?? "")\(self.txtfour.text ?? "")\(self.txtfive.text ?? "")\(self.txtsix.text ?? "")"

        print(self.otpTex)
        self.view.endEditing(true)

    }

    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
//            // Range.length == 1 means,clicking backspace
//        if (range.length == 0){
//            if textField == txtone {
//                txttwo?.becomeFirstResponder()
//            }
//            if textField == txttwo {
//                txtthree?.becomeFirstResponder()
//            }
//            if textField == txtthree {
//                txtfour?.becomeFirstResponder()
//            }
//            if textField == txtfour {
//                txtfive?.becomeFirstResponder()
//            }
//            if textField == txtfive {
//                txtsix?.becomeFirstResponder()
//
//            }
//
//
//
//            if textField == txtsix {
//                txtsix?.resignFirstResponder()
//                 /*After the otpbox6 is filled we capture the All the OTP textField and do the server call. If you want to capture the otpbox6 use string.*/
//                self.otpTex = "\((txtone?.text)!)\((txttwo?.text)!)\((txtthree?.text)!)\((txtfour?.text)!)\((txtfive?.text)!)\((txtsix?.text)!)\(textField.text ?? "")"
//                self.otpValidate(otp: otpTex)
//
//            }
//            textField.text? = string
//            print(textField.text ?? "")
//            return false
//        }else if (range.length == 1) {
//                if textField == txtsix {
//                    txtfive?.becomeFirstResponder()
//                }
//                if textField == txtfive {
//                    txtfour?.becomeFirstResponder()
//                }
//                if textField == txtfour {
//                    txtthree?.becomeFirstResponder()
//                }
//                if textField == txtthree {
//                    txttwo?.becomeFirstResponder()
//                }
//                if textField == txttwo {
//                    txtone?.becomeFirstResponder()
//                }
//                if textField == txtone {
//                    txtone?.resignFirstResponder()
//                }
//                textField.text? = ""
//                return false
//        }
//        return true
//        }
      
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
            // Range.length == 1 means,clicking backspace
        if (range.length == 0){
            if textField == txtone {
                txttwo?.becomeFirstResponder()
            }
            if textField == txttwo {
                txtthree?.becomeFirstResponder()
            }
            if textField == txtthree {
                txtfour?.becomeFirstResponder()
            }
            if textField == txtfour {
                txtfive?.becomeFirstResponder()
            }
            if textField == txtfive {
                txtsix?.becomeFirstResponder()
            }
            
           
            if textField == txtsix {
                txtsix?.resignFirstResponder()
                 /*After the otpbox6 is filled we capture the All the OTP textField and do the server call. If you want to capture the otpbox6 use string.*/
                self.otpTex = "\((txtone?.text)!)\((txttwo?.text)!)\((txtthree?.text)!)\((txtfour?.text)!)\((txtfive?.text)!)\(string)"
                self.otpValidate(otp:self.otpTex )
                
            }
            textField.text? = string
            return false
        }else if (range.length == 1) {
                if textField == txtsix {
                    txtfive?.becomeFirstResponder()
                }
                if textField == txtfive {
                    txtfour?.becomeFirstResponder()
                }
                if textField == txtfour {
                    txtthree?.becomeFirstResponder()
                }
                if textField == txtthree {
                    txttwo?.becomeFirstResponder()
                }
                if textField == txttwo {
                    txtone?.becomeFirstResponder()
                }
                if textField == txtone {
                    txtone?.resignFirstResponder()
                }
                textField.text? = ""
                return false
        }
        return true
        }
    
    
    func checkkData() ->Bool {
        if otpTex.count < 6 {
            alert(message: "OTP Is Not Correct Please Enter Correct OTP!")
            return false
        }
        
        if otpTex.count > 6 {
            alert(message: "OTP Is Not Correct Please Enter Correct OTP!")
            return false
        }
        
        if otpTex == "" {
            self.alert(message: "Please Enter Valid OTP")
            return false
        }
        return true
    }
  
    func otpValidate(otp:String) {
        self.showLoader()
//        self.otpTex = "\(self.txtone.text ?? "")\(self.txttwo.text ?? "")\(self.txtthree.text ?? "")\(self.txtfour.text ?? "")\(self.txtfive.text ?? "")\(self.txtsix.text ?? "")"

            print("otp :",otp)
        
        loginVM.otpValidate(email: email, otp: otp, Success: {response , trycatch in
            self.hidLoader()
            if response?.data ?? false {
                self.moveOnChangePassword()
            } else {
                self.hidLoader()
                self.alert(message:trycatch ?? "Something is Wrong")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message:error.message)
        })
        
    }
    
    @IBAction func changePasswordAction(_ sender: UIButton) {
//        if checkkData() {
//            self.otpValidate()
//        }
        
        //self.sendEmailApi()
        
    }
    
    //MARK:- Send Email to change Password
//    func sendEmailApi(){
//        self.showLoader()
//        loginVM.sendEmail(email: email, Success: {response , trycatch in
//            self.hidLoader()
//            if response?.success ?? false {
//                self.startTime()
//                self.alert(message: response?.message ?? "")
//            } else {
//                self.hidLoader()
//                self.alert(message: trycatch ?? "somthing is wrong")
//            }
//        }, Failure: {error in
//            self.hidLoader()
//            self.alert(message: error.message)
//        })
//    }
    
    func moveOnChangePassword() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ChangePasswordVC") as? ChangePasswordVC
        vc?.email = email
        vc?.isfrom = isfrom
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
