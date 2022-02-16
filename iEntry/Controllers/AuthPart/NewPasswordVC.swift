//
//  NewPasswordVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class NewPasswordVC: BaseController {
    
    //MARK:- here are iboutlete
    @IBOutlet weak var txtpassword: MDCOutlinedTextField!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnEnter: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.roundViewWithCustomRadius(radius: 10)
        self.navigationBarHidShow(isTrue: true)
        btnEnter.roundButtonWithCustomRadius(radius: 8)
        setMDCTxtFieldDesign(txtfiled: txtpassword, Placeholder: "PASSWORD", imageIcon: trailingImage)
    }
    
    let trailingImage: UIImage = {
      return UIImage.init(named: "eye-regular",
                          in: Bundle(for: ChangePasswordVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- this action use to move send email screen
    @IBAction func EnterAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"SendEmailVC") as? SendEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
