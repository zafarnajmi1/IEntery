//
//  CancelEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/05/2022.
//

import UIKit

class CancelEventVC: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
