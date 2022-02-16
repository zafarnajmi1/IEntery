//
//  ContractInformationVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/11/2021.
//

import UIKit

class ContractInformationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
