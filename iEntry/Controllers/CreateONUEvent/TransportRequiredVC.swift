//
//  TransportRequiredVC.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit

class TransportRequiredVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var btnswitch: UISwitch!
    @IBOutlet weak var txtvalidationmsg: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        txtvalidationmsg.delegate = self
        txtvalidationmsg.text = "COMENTARIOS PARA VALIDATION."
    }
    

    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.text == "COMENTARIOS PARA VALIDATION." {
            textView.text = nil
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            DispatchQueue.main.async {
                textView.text = "COMENTARIOS PARA VALIDATION."
            }
        }
    }

    @IBAction func switchAction(_ sender: UISwitch) {
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func CeateAction(_ sender: UIButton) {
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
