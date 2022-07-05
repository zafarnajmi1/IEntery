//
//  ThumScaningVC.swift
//  iEntry
//
//  Created by ZAFAR on 07/08/2021.
//

import UIKit
import LocalAuthentication
class ThumScaningVC: UIViewController {
    @IBOutlet weak var btnpasswordapp: UIButton!
    
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblbiomatrictitle: UILabel!
    @IBOutlet weak var mainBottomView: UIView!
    var callBack : ((_ isOk :Bool) -> Void)? = nil
    
//    enum AuthenticatinsError: String {
//        case userEnrolled = "User is not enrolled"
//        case passCodeNotSet = "user not set passcode"
//        case biometricNotAvelabel = "Biometric authentication not available"
//        case faild  = "faild to authenticat"
//        case noIssue = ""
//
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainBottomView.roundCorners([.topLeft,.topRight], radius: 20)
        authenticationWithTouchID()
        
        lblbiomatrictitle.text = "Biometric credentials".localized
        
        self.lbldetail.text = "Log in using yout biometric credential".localized
        self.btnpasswordapp.setTitle("Use password App".localized, for: .normal)
    }
    
    
    
    @IBAction func passwordAction(_ sender: Any) {
        //authenticationWithTouchID()
        self.callBack?(false)
        self.dismiss(animated: true, completion: nil)
    }
    
    func authenticationWithTouchID() {
        DispatchQueue.main.async() {
        
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

            var authorizationError: NSError?
            let reason = "Authentication required to access the secure data"

            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
                
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                    
                    if success {
                        DispatchQueue.main.async() {
//                            let alert = UIAlertController(title: "Success", message: "Authenticated succesfully!", preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
                            self.dismiss(animated: true, completion: nil)
                            self.callBack?(true)
                        }
                        
                    } else {
                        // Failed to authenticate
                        self.callBack?(false)
                        guard let error = evaluateError else {
                            return
                        }
                        print(error)
                        
                    }
                }
            } else {
                
                guard let error = authorizationError else {
                    return
                }
                print(error)
            }
        }
        }
    

}
