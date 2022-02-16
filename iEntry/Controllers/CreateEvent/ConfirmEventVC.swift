//
//  ConfirmEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/08/2021.
//

import UIKit

class ConfirmEventVC: BaseController {
    //MARK:- here are the iboutlet
    @IBOutlet weak var btncancel: UIStackView!
    @IBOutlet weak var btnconfirm: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblendtime: UILabel!
    @IBOutlet weak var lblreservation: UILabel!
    var callBack :((_ Ok : Bool, _ eventid:String)->(Void))? = nil
    var isfromupdate = false 
    var name = ""
    var startDate = ""
    var endDate = ""
    var resevationid = ""
    var reservationName = ""
    var eventid = ""
    var usersIDsarr = [String]()
    var guestNumber = 0
    var isNewReservation = false
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.roundViewWithCustomRadius(radius: 8)
        btnconfirm.roundButtonWithCustomRadius(radius: 5)
        
        

        
        self.lblname.text = name
        self.lbltime.text = getMilisecondstoDate(seconds: startDate, formatter: "")
        
        self.lblendtime.text =  getMilisecondstoTime(seconds: endDate, formatter: "")
        self.lblreservation.text = reservationName
    }
    
    

    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
    
    @IBAction func crossAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        
        if isfromupdate {
            updateEventapi() //updateInvidationUsers()
        } else {
             createEventApi()
        }
//        self.dismiss(animated: false, completion: {
//            self.callBack!(true)
//        })
    }
    
    func createEventApi(){
        self.showLoader()
        /*
         {
             "user":{
                 "id": "36932667-041e-43e6-bede-edac0d7935ab"
             },
             "reservation":{
                 "zone":{
                     "id": "0155968c-3f84-476a-a343-2bd2e96d9f4b"
                 }
             },
             "name": "Holiday Party",
             "description": "",
             "startDate": 1640368800000,
             "endDate": 1640390400000
         }**/
        let userDic = ["id":ShareData.shareInfo.obj?.id ?? ""]
        let reservation = ["zone":["id":resevationid]]
        let dic : [String:Any] = ["name":name,"reservation":reservation,"user":userDic,"description":"","startDate":startDate,"endDate":endDate]
        userhandler.createEvent(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.eventid = response?.data?.id ?? ""
                self.dismiss(animated: true, completion: nil)
                self.alert(message: response?.message ?? "")
                self.dismiss(animated: false, completion: {
                    self.callBack!(true, self.eventid)
                })
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }

    
    
    
    func updateEventapi(){
       self.showLoader()
        
        /*{
         "id": "c1643699-559f-4f39-8f1f-e160a98a650c",
         "name": "New Name",
         "comment": "New Comment",
         "wasApprove": true,
         "reservation":{
             "zone":{
                 "id": "a2f76bb5-bac9-4a53-9b0b-5a8a976a8859"
             }
         }
     }*/
        var dic : [String:Any] = [:]
        if isNewReservation == true {
        let reservation = ["zone":["id":resevationid]]
         dic  = ["id":eventid,"name":name,"wasApprove":true,"comment":"new one", "reservation":reservation,"startDate":startDate,"endDate":endDate]
        } else {
            dic  = ["id":eventid,"name":name,"wasApprove":true,"comment":"new one"]
        }
        
        userhandler.updateEvent(param: dic, Success: {response in
            if response?.success == true {
                self.updateInvidationUsers()
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    
        
    }
    
    func updateInvidationUsers() {
       // self.showLoader()
        let dic : [String:Any] = ["eventId":eventid,"usersIds":usersIDsarr,"guestNumber":guestNumber]
        userhandler.sendInvitation(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                
                self.dismiss(animated: true, completion: nil)
                self.alert(message: response?.message ?? "")
                self.dismiss(animated: false, completion: {
                    
                    
                    self.callBack!(true, self.eventid)
                })
                
                
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    
    
}
