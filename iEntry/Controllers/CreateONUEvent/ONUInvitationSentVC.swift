//
//  ONUInvitationSentVC.swift
//  iEntry
//
//  Created by ZAFAR on 10/05/2022.
//

import UIKit

class ONUInvitationSentVC: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
