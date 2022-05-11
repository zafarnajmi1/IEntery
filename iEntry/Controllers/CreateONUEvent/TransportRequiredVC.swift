//
//  TransportRequiredVC.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit

class TransportRequiredVC: UIViewController,UITextViewDelegate {
    var param = eventDic()
    @IBOutlet weak var btnswitch: UISwitch!
    @IBOutlet weak var txtvalidationmsg: UITextView!
    
    /*{
     "user":{
         "id": "36932667-041e-43e6-bede-edac0d7935ab"
     },
     "host":{
         "id": "36932667-041e-43e6-bede-edac0d7935ab"
     },
     "reservation":{
         "zone":{
             "id": "0155968c-3f84-476a-a343-2bd2e96d9f4b"
         }
     },
     "name": "Holiday Party II",
     "visitPurpose": "Other description.",
     "duration": 180,
     "startDate": 1638040086000,
     "endDate": 1638040086000, // Can be null, the server can calculate with the startDate and duration attributes //
     "accompanied": "Only with one person", // Extra data ONU //
     "unitSection": "UNITAD/IBL", // Extra data ONU //
     "visitorComment": "No comments.", // Extra data ONU //
     "validationComment": "No comments.", // Extra data ONU //
     "requiredTransportation": false // Extra data ONU //
 }*/
    
    
    
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
