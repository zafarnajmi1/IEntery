//
//  TransportRequiredVC.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit

class TransportRequiredVC: BaseController,UITextViewDelegate {
    var param = eventDic()
    var selectVehicle = [SelectedVehicleListData]()
    @IBOutlet weak var btnswitch: UISwitch!
    @IBOutlet weak var txtvalidationmsg: UITextView!
    var istraficRequired = false
    var eventid = ""
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
        if sender.isOn == true {
            self.istraficRequired = true
        } else {
            self.istraficRequired = false
        }
    
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func checkData() -> Bool {
        if txtvalidationmsg.text == "" {
            self.alert(message: "Please Enter Validation Comment")
            return false
        }
        return true
    }
    
    
    @IBAction func CeateAction(_ sender: UIButton) {
        
        if checkData() {
            
            createEventApi()
        }
        
    }
    
    
    
    func createEventApi(){
        self.showLoader()
        
        let userDic = ["id":ShareData.shareInfo.obj?.id ?? ""]
        let hostDic = ["id":ShareData.shareInfo.obj?.id ?? ""]
        
        
        let reservation = ["zone":["id":param.dic["zonid"] as? String]]
        let dic : [String:Any] = ["name":param.dic["name"] ?? "","reservation":reservation,"user":userDic,"host":hostDic,"description":"","startDate":param.dic["startDate"] ?? "","endDate":param.dic["endDate"] ?? "","duration":param.dic["duration"] ?? "","visitPurpose":param.dic["visitPurpose"] ?? "","accompanied":param.dic["accompanied"] ?? "","unitSection":param.dic["unitSection"] ?? "","requiredTransportation":istraficRequired,"validationComment":txtvalidationmsg.text ?? ""]
        
        userhandler.createEvent(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
               self.eventid = response?.data?.id ?? ""
                //self.dismiss(animated: true, completion: nil)
               // self.alert(message: response?.message ?? "")
                //self.dismiss(animated: false, completion: {
                 //self.callBack!(true, self.eventid)
                //})
                
                self.InvitationUsers()
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }

    /*{
     "eventId": "9a0de660-2c4b-4c3e-951a-6e16f7fed559",
     "userInvitations":
     [
         {
             "guest": {
                 "id": "f201f8d5-6fd2-4bd6-8f12-ec1571e4531e"
             },
             "guestNumber": 4,
             "sharePdf": true, // Extra data ONU //
             "organization": "IBL/UNITAD", // Extra data ONU //
             "placeToPickUp": "Neer from my house", // Extra data ONU //
             "gzBadge": false // Extra data ONU //
         },
         {
             "guest": {
                 "id": "ad79ab15-dc23-4d1a-8ed6-0cde9c735b17"
             },
             "guestNumber": 1,
             "sharePdf": false, // Extra data ONU //
             "organization": "UNAMI", // Extra data ONU //
             "placeToPickUp": "None.", // Extra data ONU //
             "gzBadge": true // Extra data ONU //
         }
     ]
 }*/
    
    func InvitationUsers() {
        self.showLoader()
        
        //self.usersIDsarr.removeAll()
        var mainArr = [[String:Any]]()
        for item in param.checkRegisterUser {
            if item.isregister == true {
                mainArr.append(["guest":["id":item.guestid],"guestNumber": param.invitationDic["guestNumber"] as? String as Any, "sharePdf": param.invitationDic["sharePdf"] as?String as Any, "organization": param.invitationDic["organization"] as? String as Any, "placeToPickUp":param.invitationDic["placeToPickUp"] as? String as Any, "gzBadge":param.invitationDic["gzBadge"] as? String as Any])
                //usersIDsarr.append("\(item.guestid)")
            }
        }
        
        
        
        let dic : [String:Any] = ["eventId":eventid,"userInvitations":mainArr]
        //
        //usersIds
        userhandler.sendInvitation(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                
                
                if self.selectVehicle.count == 0 {
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popToViewController(ofClass: HomeVC.self)
                    self.alert(message: response?.message ?? "")
                } else {
                    self.sendVehicleInvitationApi()
                }
//                self.dismiss(animated: true, completion: nil)
//
//                self.dismiss(animated: false, completion: {
//
//                })
                //self.navigationController?.popToViewController(ofClass: HomeVC.self)
                //self.alert(message: response?.message ?? "")
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    
    func sendVehicleInvitationApi(){
        
        var idsArr = [String]()
        
        for item in self.selectVehicle {
            idsArr.append(item.id!)
        }
        
        
        
        let dic:[String:Any] = ["eventId":self.eventid, "vehiclesIds":idsArr]
        
        
        userhandler.sendvehicleInvitation(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popToViewController(ofClass: HomeVC.self)
                self.alert(message: response?.message ?? "")
            } else {
                
            }
        }, Failure: {error in
            self.alert(message: error.message)
        })
    }
    
    
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
