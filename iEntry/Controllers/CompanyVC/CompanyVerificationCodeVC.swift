//
//  CompanyVerificationCodeVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/09/2021.
//

import UIKit
import XLPagerTabStrip
class CompanyVerificationCodeVC: BaseController, UITextFieldDelegate,IndicatorInfoProvider {
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TOKEN".localized)
    }
    @IBOutlet weak var lbltokentitle: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    //MARK:- here are iboutlet
    @IBOutlet weak var mainView: UIView!
    //@IBOutlet weak var btncode: UIButton!
    @IBOutlet weak var usrimg: UIImageView!
    @IBOutlet weak var txtSix: UITextField!
    @IBOutlet weak var txtFive: UITextField!
    @IBOutlet weak var txtFour: UITextField!
    @IBOutlet weak var txtThree: UITextField!
    @IBOutlet weak var txtTwo: UITextField!
    @IBOutlet weak var txtOne: UITextField!
    @IBOutlet weak var CodeViewOne: UIView!
    @IBOutlet weak var CodeViewTwo: UIView!
    @IBOutlet weak var CodeViewThree: UIView!
    @IBOutlet weak var CodeViewFour: UIView!
    @IBOutlet weak var CodeViewFive: UIView!
    @IBOutlet weak var CodeViewSix: UIView!
    //@IBOutlet weak var lbltimedetail: UILabel!
    var otpTex = ""
    var loginVM = LoginViewModel()
    var tokenData : SixDigitCodeModel?
    private var timer: Timer?
    
    var count = 1*5 //59
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbltokentitle.text = "TOKEN DE ACCESO".localized
        //self.lbltimedetail.text = "Valido por los siguientes 30 segundos.".localized
       // btncode.setTitle("VOLVER A GENERAR".localized, for: .normal)
        self.lblusername.text = ShareData.shareInfo.obj?.name
        self.lbltime.text = self.getCurrentTime()
        self.lbldate.text = self.getCurrentDate()
        mainView.shadowAndRoundcorner(cornerRadius: 5, shadowColor: #colorLiteral(red: 0.8626509309, green: 0.8627994061, blue: 0.8626416326, alpha: 1), shadowRadius: 2.0, shadowOpacity: 1)
        self.navigationBarHidShow(isTrue: true)
        self.usrimg.roundViiew()
        
        txtOne.delegate = self
        txtTwo.delegate = self
        txtThree.delegate = self
        txtFour.delegate = self
        txtFive.delegate = self
        txtSix.delegate = self
        
        txtOne.textContentType = .oneTimeCode
        txtTwo.textContentType = .oneTimeCode
        txtThree.textContentType = .oneTimeCode
        txtFour.textContentType = .oneTimeCode
        txtFive.textContentType = .oneTimeCode
        txtSix.textContentType = .oneTimeCode
         txtOne.becomeFirstResponder()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Network.isAvailable {
          self.geneRateOtpApiCall()
        } else{
            AppUtility.showErrorMessage(message: "No Internet Connection")
            
        }
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
//                lbltimedetail.isUserInteractionEnabled = true
//        lbltimedetail.addGestureRecognizer(tap)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    @objc
        func tapFunction(sender:UITapGestureRecognizer) {
            self.geneRateOtpApiCall()
        }
    
    //MARK:- this funtion to start timer
    func startTime() {
        
                guard timer == nil else { return }
            timer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
    }
    
    //MARK:- stop the timer
    @objc func updateTimer() {
        if count > 0 {
            count -= 1
           // lbltimedetail.text = "Valido por los siguientes \(count),s segundos."
        } else {
            timer?.invalidate()
            timer = nil
           // lbltimedetail.text = "Resend Code"
            if Network.isAvailable {
            self.geneRateOtpApiCall()
            } else{
                AppUtility.showErrorMessage(message: "No Internet Connection")
                
            }
        }
    }
    
    
    
    //MARK:- this funtion use to generate the otp
    func geneRateOtpApiCall() {
        userhandler.getSixDigitCode(Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.count = 1*5 //59
                self.startTime()
                self.tokenData = response
                
                let token = "\(self.tokenData?.data ?? "")"
                print("my token new:",token.digits)
                self.assigntoken(arr: token.digits)
            } else {
                self.hidLoader()
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    //MARK:- assignening OTP
    func assigntoken(arr:[Int]){
        txtOne.text = "\(arr[0])"
        txtTwo.text = "\(arr[1])"
        txtThree.text = "\(arr[2])"
        txtFour.text = "\(arr[3])"
        txtFive.text = "\(arr[4])"
        txtSix.text = "\(arr[5])"
        txtSix.becomeFirstResponder()
    }
    
    //MARK:- textfield delegate 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
            // Range.length == 1 means,clicking backspace
        if (range.length == 0){
            if textField == txtOne {
                txtTwo?.becomeFirstResponder()
            }
            if textField == txtTwo {
                txtThree?.becomeFirstResponder()
            }
            if textField == txtThree {
                txtFour?.becomeFirstResponder()
            }
            if textField == txtFour {
                txtFive?.becomeFirstResponder()
            }
            if textField == txtFive {
                txtSix?.becomeFirstResponder()
            }
            
           
            if textField == txtSix {
                txtSix?.resignFirstResponder()
                 /*After the otpbox6 is filled we capture the All the OTP textField and do the server call. If you want to capture the otpbox6 use string.*/
                self.otpTex = "\((txtOne?.text)!)\((txtTwo?.text)!)\((txtThree?.text)!)\((txtFour?.text)!)\((txtFive?.text)!)\(string)"
                
                
            }
            textField.text? = string
            return false
        }else if (range.length == 1) {
                if textField == txtSix {
                    txtFive?.becomeFirstResponder()
                }
                if textField == txtFive {
                    txtFour?.becomeFirstResponder()
                }
                if textField == txtFour {
                    txtThree?.becomeFirstResponder()
                }
                if textField == txtThree {
                    txtTwo?.becomeFirstResponder()
                }
                if textField == txtTwo {
                    txtOne?.becomeFirstResponder()
                }
                if textField == txtOne {
                    txtOne?.resignFirstResponder()
                }
                textField.text? = ""
                return false
        }
        return true
        }
   
    
    
    
    func dismissKeyboard(){

        self.otpTex = "\(self.txtOne.text ?? "")\(self.txtTwo.text ?? "")\(self.txtThree.text ?? "")\(self.txtFour.text ?? "")\(self.txtFive.text ?? "")\(self.txtSix.text ?? "")"

            print(self.otpTex)
            self.view.endEditing(true)

        }

    
    func verifycode(){
        self.showLoader()
        userhandler.verifySixDigitCode(Success: {response in
            self.hidLoader()
            if response?.success == true {
                
                self.navigationController?.popViewController(animated: true)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
    @IBAction func sendCodeAction(_ sender: UIButton) {
        //self.geneRateOtpApiCall()
        verifycode()
    }
    
}
