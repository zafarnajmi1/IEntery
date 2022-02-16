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
    @IBOutlet weak var tblView: UITableView!
    var companyregisterVM = CompanyregisterModelView()
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var topBanerView: UIView!
    @IBOutlet weak var moreView: UIView!
    
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lblcompanyName: UILabel!
    var contractData : GetContractByUserModelData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        topBanerView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 4, shadowOpacity: 1)
        moreView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 5, shadowOpacity: 1)
        navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "CompanyCell", bundle: nil), forCellReuseIdentifier: "CompanyCell")
//        self.lblcompanyName.text = "" //ShareData.shareInfo.obj?.company?.name
//        self.lbladdress.text = "" //ShareData.shareInfo.obj?.company?.address
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getContractByUSerIDApi()
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        //self.tblHeight.constant = tblView.contentSize.height
//    }
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        self.tblHeight.constant = 400//tblView.contentSize.height
//    }

    
    
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
                ShareData.shareInfo.saveContract(contract: response?.data)
                UserDefaults.standard.save(customObject: response?.data, inKey: "UserContractWithCompany")
                self.contractData = response?.data
                self.lblcompanyName.text =  self.contractData?.company?.name //ShareData.shareInfo.obj?.company?.name
                self.lbladdress.text = self.contractData?.company?.address
               // self.tblHeight.constant = 400
                self.tblView.reloadData()
            } else {
                self.hidLoader()
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
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
        vc?.company = contractData?.company
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
        
        cell?.lbladdress.text = contractData?.role?.name
        cell?.lblownername.text = contractData?.user?.name
        

//        let epocTime = TimeInterval(contractData?.startDate ?? 0)
//
//        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//        let dateString = dateFormatter.string(from: myDate)

        
        cell?.lblstartDate.text = self.getMilisecondstoDate(seconds: "\(contractData?.startDate ?? 0)", formatter: "") //dateString
        
      
        
        cell?.lblendDate.text = self.getMilisecondstoDate(seconds: "\(contractData?.endDate ?? 0)", formatter: "")
        
        cell?.callBack = { Istrue in
            if Istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
                
                vc?.companyname = self.contractData?.company?.name ?? ""
                vc?.address = self.contractData?.company?.address ?? ""
                vc?.lat = self.contractData?.company?.latitud ?? 0
                vc?.long = self.contractData?.company?.longitud ?? 0
            self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            if !Istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationOptionsVC") as? VerificationOptionsVC
            self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        return  cell!
    }
    
    
    
   
    
    
}
