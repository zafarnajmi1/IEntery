//
//  MethodVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit

class MethodVC: UIViewController {
//MARK:- Here Are IBoutlet
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblemailmethod: UILabel!
    @IBOutlet weak var lblphoneMethos: UILabel!
  var email = ""
    
    //MARK:- Viewdidload Funtion 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        let number = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        lblphoneMethos.addGestureRecognizer(number)
        
        let email = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        lblemailmethod.addGestureRecognizer(email)
        lblemailmethod.isUserInteractionEnabled = true
        lblphoneMethos.isUserInteractionEnabled = true
    }
    
    //MARK:- this funtion use to move on next screen
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationCodeVC") as? VerificationCodeVC ///SendEmailVC
        vc?.email = email
        vc?.isfrom = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

   

   

}
