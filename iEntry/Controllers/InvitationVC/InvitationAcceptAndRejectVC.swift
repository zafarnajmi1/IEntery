//
//  InvitationAcceptAndRejectVC.swift
//  iEntry
//
//  Created by ZAFAR on 11/04/2022.
//

import UIKit

class InvitationAcceptAndRejectVC: UIViewController {

    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnaccept: UIButton!
    
    var acceptInvition : ((_ option:Int) ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
       acceptInvition?(39)
    }
    
    @IBAction func btnAcceptionAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        acceptInvition?(38)
        
        
    }
    
}
