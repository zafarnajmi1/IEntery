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
    override func viewDidLoad() {
        super.viewDidLoad()
        mainBottomView.roundCorners([.topLeft,.topRight], radius: 20)
        authenticationWithTouchID()
    }
    
    
    
    @IBAction func passwordAction(_ sender: Any) {
        //authenticationWithTouchID()
        self.dismiss(animated: true, completion: nil)
    }
    
    func authenticationWithTouchID() {
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

            var authorizationError: NSError?
            let reason = "Authentication required to access the secure data"

            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
                
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                    
                    if success {
                        DispatchQueue.main.async() {
                            let alert = UIAlertController(title: "Success", message: "Authenticated succesfully!", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        // Failed to authenticate
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
