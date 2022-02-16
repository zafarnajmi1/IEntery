//
//  LogOutPopUpVC.swift
//  iEntry
//
//  Created by ZAFAR on 09/02/2022.
//

import UIKit

class LogOutPopUpVC: UIViewController {
    var callBack : (() ->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

   
    @IBAction func acceptAction(_ sender: UIButton) {
        callBack?()
    }
    

}
