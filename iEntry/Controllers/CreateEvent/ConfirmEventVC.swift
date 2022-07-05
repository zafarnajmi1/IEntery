//
//  ConfirmEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/08/2021.
//

import UIKit

class ConfirmEventVC: BaseController {
    //MARK:- here are the iboutlet
    
    @IBOutlet weak var lblreservationtitle: UILabel!
    
    @IBOutlet weak var lblattitle: UILabel!
    
    
    
    @IBOutlet weak var lblduration: UILabel!
    @IBOutlet weak var lblmint: UILabel!
    @IBOutlet weak var lblthetitle: UILabel!
    @IBOutlet weak var lbldatestitle: UILabel!
    @IBOutlet weak var lblnumbertitle: UILabel!
    //@IBOutlet weak var btncancel: UIStackView!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnconfirm: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblendtime: UILabel!
    @IBOutlet weak var lblreservation: UILabel!
    
    @IBOutlet weak var lblcreateeventtitle: UILabel!
    
    
    
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
    var duration = ""
    var isNewReservation = false
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.roundViewWithCustomRadius(radius: 8)
        btnconfirm.roundButtonWithCustomRadius(radius: 5)
        
        

        
        self.lblname.text = name
        self.lbltime.text = getMilisecondstoDate(seconds: startDate, formatter: "")
        
        self.lblendtime.text =  getMilisecondstoTime(seconds: endDate, formatter: "")
        self.lblreservation.text = reservationName
        
        
        self.lblcreateeventtitle.text = "C O N F I R M A R E V E N T O".localized
        self.lblnumbertitle.text = "NOMBRE".localized
    
        self.lbldatestitle.text = "FECHAS".localized
        self.lblthetitle.text = "EL".localized
    
        lblattitle.text = "A LAS".localized
        self.lblreservationtitle.text = "RESERVACIONES".localized
        self.btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnconfirm.setTitle("CONFIMRMAR".localized, for: .normal)
        self.lblmint.text = "\(duration) MIN"
        self.lblduration.text = "DURACIÓN".localized
    
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
        
        let userDic = ["id":ShareData.shareInfo.obj?.id ?? ""]
        let hostDic = ["id":ShareData.shareInfo.obj?.id ?? ""]
        let reservation = ["zone":["id":resevationid]]
        let dic : [String:Any] = ["name":name,"reservation":reservation,"user":userDic,"host":hostDic,"description":"","startDate":startDate,"endDate":endDate,"duration":duration,"visitPurpose":"Other description."]
        userhandler.createEvent(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.eventid = response?.data?.id ?? ""
                self.dismiss(animated: true, completion: nil)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
                self.dismiss(animated: false, completion: {
                    self.callBack!(true, self.eventid)
                })
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }

    
    
    
    func updateEventapi(){
       self.showLoader()
        
        var dic : [String:Any] = [:]
        if isNewReservation == true {
        let reservation = ["zone":["id":resevationid]]
            dic  = ["id":eventid,"name":name,"wasApprove":true,"comment":"new one", "reservation":reservation,"startDate":startDate,"endDate":endDate,"duration":duration,"visitPurpose":"Other description."]
        } else {
            dic  = ["id":eventid,"name":name,"wasApprove":true,"comment":"new one","visitPurpose":"Other description."]
        }
        
        userhandler.updateEvent(param: dic, Success: {response in
            if response?.success == true {
                self.updateInvidationUsers()
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    
        
    }
    
    func updateInvidationUsers() {
       // self.showLoader()
        
        
        var mainArr = [[String:Any]]()
        for item in 0..<usersIDsarr.count {
            
                mainArr.append(["guest":["id":usersIDsarr[item]],"guestNumber":guestNumber])
                //usersIDsarr.append("\(item.guestid)")
            
        }
        
        
        
        let dic : [String:Any] = ["eventId":eventid,"userInvitations":mainArr]
        
        
        
        userhandler.sendInvitation(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                
                self.dismiss(animated: true, completion: nil)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
                self.dismiss(animated: false, completion: {
                    
                    
                    self.callBack!(true, self.eventid)
                })
                
                
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
}
