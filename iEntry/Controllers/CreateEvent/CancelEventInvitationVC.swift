//
//  CancelEventInvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 20/08/2021.
//

import UIKit

class CancelEventInvitationVC: UIViewController {
    //MARK:- here are iboutlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnconfirm: UIButton!
    var callBack: (()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
        btnconfirm.roundViewWithCustomRadius(radius: 5)
        mainView.roundViewWithCustomRadius(radius: 8)
    }
    
    //MARK:- dismiss the  controller 
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
