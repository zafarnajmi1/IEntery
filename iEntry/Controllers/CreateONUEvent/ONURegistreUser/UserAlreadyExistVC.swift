//
//  UserAlreadyExistVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/05/2022.
//

import UIKit

class UserAlreadyExistVC: UIViewController {
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblname: UILabel!
    var phone = ""
    var email = ""
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblphone.text = phone
        self.lblname.text = name
        self.lblemail.text = email
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
