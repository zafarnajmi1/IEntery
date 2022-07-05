//
//  CompanyVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/08/2021.
//

import UIKit
 import SimpleAnimation
class CompanyVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var lbledittitle: UILabel!
    @IBOutlet weak var lblcontract: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var companyregisterVM = CompanyregisterModelView()
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var topBanerView: UIView!
    @IBOutlet weak var moreView: UIView!
    
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lblcompanyName: UILabel!
    var contractData : GetContractByUserModelData? = nil
    var getCompanydata :CompanyRistrictionData?
    override func viewDidLoad() {
        super.viewDidLoad()
        topBanerView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 4, shadowOpacity: 1)
        moreView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 5, shadowOpacity: 1)
        navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "CompanyCell", bundle: nil), forCellReuseIdentifier: "CompanyCell")
            
        self.lblcontract.text = "C O N T R A C T".localized
        self.lbledittitle.text = "ACTUALIZAR DATOS".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.lblcontract.text = "C O N T R A C T".localized
        self.lbledittitle.text = "ACTUALIZAR DATOS".localized
        
        if Network.isAvailable {
            print("Internet connection OK")
            self.getContractByUSerIDApi()
        } else {
            print("Internet connection FAILED")
            self.tblView.reloadData()
        }
    }

    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
         if(keyPath == "contentSize"){
             if let newvalue = change?[.newKey]
             {
                 DispatchQueue.main.async {
                 let newsize  = newvalue as! CGSize
                    self.tblHeight.constant = newsize.height
                 }

             }
         }
     }
    //MARK:- menu appering funtion
    @IBAction func menuAction(_ sender: UIButton) {
        let manager = ZSideMenuManager(isRTL: false)
                     manager.openSideMenu(vc: self)
    }
    
    
    //MARK:-  Get Contract By User ID
    
    func getContractByUSerIDApi(){
        
        self.showLoader()
        userhandler.getContractByUserID(id: ShareData.shareInfo.obj?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                
                ShareData.shareInfo.companyid = response?.data?.company?.id ?? ""
                self.getCompanyImageByIDApi(companyid:response?.data?.company?.id ?? "")
                
                ShareData.shareInfo.saveContract(contract: response?.data)
                UserDefaults.standard.save(customObject: response?.data, inKey: "UserContractWithCompany")
                self.contractData = response?.data
                self.lblcompanyName.text =  self.contractData?.company?.name //ShareData.shareInfo.obj?.company?.name
                self.lbladdress.text = self.contractData?.company?.address
               // self.tblHeight.constant = 400
                self.tblView.reloadData()
                self.getCompanyRistrictionbyID()
                
            } else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    func getCompanyImageByIDApi(companyid:String) {
        userhandler.downloadNotificationimage(notificationid: companyid,option: "company", Success: {response in
            if response?.success == true  {
                //self.notificationimg =  self.convierteImagen(base64String: response?.data ?? "") ?? UIImage()
                self.bannerImg.image = self.convierteImagen(base64String: response?.data ?? "") ?? UIImage()
            } else {
                
            }
        }, Failure: {error in
            print("image download error")
        })
    }
    
    
    @IBAction func moreAction(_ sender: UIButton) {
        
        //moreView.slideOut(to: .right, x: 0, y: 0, duration: 1, delay: 0.5, completion: nil)
        moreView.isHidden = !moreView.isHidden
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        print("Edit Profile")
        
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"AddProfileDataVC") as? AddProfileDataVC
        vc?.company = ShareData.shareInfo.conractWithCompany?.company//contractData?.company
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func profileAction(_ sender: UIButton) {
        print("add employedee")
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"AddEmployeeVC") as? AddEmployeeVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func addVehicleAction(_ sender: UIButton) {
        print("addvehicles")
        //AddVehicleVC
        
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"AddVehicleVC") as? AddVehicleVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func manageRoles(_ sender: UIButton) {
        print("manageroles")
    }
    
    @IBAction func manageScheduales(_ sender: UIButton) {
        print("manageSchedual")
    }
    
    func getCompanyRistrictionbyID(){
            //self.showLoader()
        //ShareData.shareInfo.obj?.company?.id ?? ""
        userhandler.getCompanyristrictionByID(id: contractData?.company?.id ?? "", Success: {response  in
                self.hidLoader()
                if response?.success == true {
                    self.getCompanydata = response?.data
                    
                    ShareData.shareInfo.savecompanyRistriction(company: response?.data)
                    
                    
                } else {
                    //AppUtility.showErrorMessage(message: response?.message ?? "")
                }
            }, Failure: {error in
                self.hidLoader()
                //AppUtility.showErrorMessage(message: error.message)
            })
        }
    
    
    
    
}
//MARK:- tabelview delegates 
extension CompanyVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CompanyCell") as? CompanyCell
        
        cell?.lbladdress.text =   ShareData.shareInfo.conractWithCompany?.role?.name // contractData?.role?.name
        cell?.lblownername.text = ShareData.shareInfo.conractWithCompany?.user?.name//contractData?.user?.name
        
        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 2 })) != nil {
            cell?.mapView.isHidden = false
        } else {
            cell?.mapView.isHidden = true
        }
        
        
        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 3 })) != nil {
            cell?.qrCodeView.isHidden = false
        } else {
            cell?.qrCodeView.isHidden = true
        }
        
//        if ((ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.contains(obj: "SHOW_MAP")) != nil) {
//            cell?.mapView.isHidden = false
//        } else {
//            cell?.mapView.isHidden = true
//        }
        

//        let epocTime = TimeInterval(contractData?.startDate ?? 0)
//
//        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//        let dateString = dateFormatter.string(from: myDate)

        
        cell?.lblstartDate.text = self.getMilisecondstoDate(seconds: "\(ShareData.shareInfo.conractWithCompany?.startDate ?? 0)", formatter: "") //dateString
        
      
         //contractData
        cell?.lblendDate.text = self.getMilisecondstoDate(seconds: "\(ShareData.shareInfo.conractWithCompany?.endDate ?? 0)", formatter: "")
        
        cell?.callBack = { Istrue in
            if Istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                
                vc?.companyname = ShareData.shareInfo.conractWithCompany?.company?.name ?? ""//self.contractData?.company?.name ?? ""
                vc?.address = ShareData.shareInfo.conractWithCompany?.company?.address ?? ""//self.contractData?.company?.address ?? ""
                vc?.lat = ShareData.shareInfo.conractWithCompany?.company?.latitud ?? 0//self.contractData?.company?.latitud ?? 0
                vc?.long = ShareData.shareInfo.conractWithCompany?.company?.longitud ?? 0//self.contractData?.company?.longitud ?? 0
            self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            if !Istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationOptionsVC") as? VerificationOptionsVC
            self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
        cell?.updatelanguage()
        return  cell!
    }
    
    
    
   
    
    
}
