//
//  UserProfileVC.swift
//  iEntry
//
//  Created by ZAFAR on 24/08/2021.
//

import UIKit
import SDWebImage
class UserProfileVC: BaseController {
    @IBOutlet weak var lblspanishtitle: UILabel!
    
    @IBOutlet weak var lbldevicetitle: UILabel!
    @IBOutlet weak var lblbiomatrictitle: UILabel!
    @IBOutlet weak var lblaccetypetitle: UILabel!
    @IBOutlet weak var lblpostcodetitle: UILabel!
    @IBOutlet weak var lblcountrytitl: UILabel!
    @IBOutlet weak var lbladdresstwotitle: UILabel!
    @IBOutlet weak var lblextradatatitle: UILabel!
    @IBOutlet weak var lblgendertitle: UILabel!
    //MARK:- here are the iboutlet
    @IBOutlet weak var lblnametitle: UILabel!
    
    @IBOutlet weak var lblhomenumertitle: UILabel!
    @IBOutlet weak var lblstatetitle: UILabel!
    @IBOutlet weak var lbladdressonetitle: UILabel!
    @IBOutlet weak var lbldateofBirhTitle: UILabel!
    @IBOutlet weak var lblpasswordtitle: UILabel!
    @IBOutlet weak var lblinformationpersonaltitle: UILabel!
    @IBOutlet weak var lblpersonalinfotitle: UILabel!
    @IBOutlet weak var lbltypeAccess: UILabel!
    @IBOutlet weak var hideshowtype: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblpostalCode: UILabel!
    @IBOutlet weak var lbllanguage: UILabel!
    
    @IBOutlet weak var lblbloodtitle: UILabel!
    @IBOutlet weak var lblmailtitle: UILabel!
    @IBOutlet weak var lblBloodGroup: UILabel!
    @IBOutlet weak var lblarabicname: UILabel!
    @IBOutlet weak var lblhomenumber: UILabel!
    @IBOutlet weak var lblcountery: UILabel!
    @IBOutlet weak var lblstate: UILabel!
    @IBOutlet weak var lbladdress2: UILabel!
    @IBOutlet weak var lbladdress1: UILabel!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    
    @IBOutlet weak var lblenglishtitle: UILabel!
    @IBOutlet weak var lblphonetitle: UILabel!
    @IBOutlet weak var spanishView: UIView!
    @IBOutlet weak var btnswitch: UISwitch!
    
    @IBOutlet weak var lblarabicnametitle: UILabel!
    
    @IBOutlet weak var frechView: UIView!
    @IBOutlet weak var englishView: UIView!
    
    @IBOutlet weak var lblphone: UILabel!
    var isenglish = true
    var isespainssion = true
    var isfrench = true
    var istypeAccess =  true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        if ShareData.shareInfo.saveLanguage == "en" {
//            englishAction(UIButton())
//        } else {
//            espanission(UIButton())
//        }
//
        
        
        if ShareData.shareInfo.saveLanguage == "en" {
            //englishAction(UIButton())
            
            isfrench = false
            isespainssion = false
             isenglish = true
        
                englishimg.image = UIImage(named: "ic-check-2")
                frenchimg.image = UIImage(named: "")
                espainimg.image = UIImage(named: "")
                ShareData.shareInfo.saveLanguage = "en"
                myDefaultLanguage = .en
        } else {
            //espanission(UIButton())
            
            isfrench = false
            isespainssion = true
             isenglish = false
        
                englishimg.image = UIImage(named: "")
                frenchimg.image = UIImage(named: "")
                espainimg.image = UIImage(named: "ic-check-2")
            ShareData.shareInfo.saveLanguage = "es"
            myDefaultLanguage = .es
        }
        
        
        
        self.lblpersonalinfotitle.text = "Información personal".localized
        
        self.lblinformationpersonaltitle.text = "Información personal".localized
        
        self.lblnametitle.text = "Nombre".localized
        self.lblpasswordtitle.text = "Contraseña".localized
        self.lblmailtitle.text = "Correo".localized
        self.lblphonetitle.text = "Celular".localized
        self.lbldateofBirhTitle.text = "Fecha de cumpleaños".localized
        
        self.lblgendertitle.text = "Género".localized
        self.lblextradatatitle.text = "Información extra".localized
        
        self.lbladdressonetitle.text = "ADDESS 1".localized
        self.lbladdresstwotitle.text = "ADDESS 2".localized
        self.lblstatetitle.text = "STATE".localized
        self.lblcountrytitl.text = "COUNTRY".localized
        self.lblpostcodetitle.text = "POST CODE".localized
        self.lblhomenumertitle.text = "HOME NUMBER".localized
        self.lblarabicnametitle.text = "ARABIC NAME".localized
        self.lblbloodtitle.text = "BLOOD TYPE".localized
        self.lbllanguage.text = "Idiomas".localized
        
        self.lblspanishtitle.text = "Español".localized
        self.lblenglishtitle.text = "Ingles".localized
        self.lblaccetypetitle.text = "Tipo de Acceso".localized
        self.lblbiomatrictitle.text = "Use biometrics store in the phone".localized
        self.lbldevicetitle.text = "DESVINCULAR DISPOSITIVO".localized
        if ShareData.shareInfo.isBiomatric == true {
            btnswitch.isOn = true
        } else {
            btnswitch.isOn = true
        }
        self.navigationBarHidShow(isTrue: true)
        mainView.roundCorners([.topLeft,.topRight], radius: 20)
        userimg.roundViiew()
        //englishAction(UIButton())
       // setDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        getUserInfo()
    }
    
    func setDate(){
        
//        userimg.sd_setImage(with: URL(string: ShareData.shareInfo.obj?.userImages?[0] ?? ""), placeholderImage: UIImage(named: ""), options: .refreshCached, context: .none)
        self.lblBloodGroup.text = ShareData.shareInfo.obj?.extraData?.bloodType
        self.lblname.text =  ShareData.shareInfo.obj?.name
        self.lblstate.text = ShareData.shareInfo.obj?.extraData?.town
        self.lblemail.text =  ShareData.shareInfo.obj?.email
        self.lblphone.text = ShareData.shareInfo.obj?.phoneNumber
        self.lblgender.text = ShareData.shareInfo.obj?.gender?.name
        self.lblpassword.text = "*********" //ShareData.shareInfo.obj?.user?.password
        self.lblcountery.text = ShareData.shareInfo.obj?.extraData?.country
        self.lblDOB.text = ShareData.shareInfo.obj?.dob
        self.lbladdress1.text = ShareData.shareInfo.obj?.extraData?.address1
        self.lbladdress2.text =  ShareData.shareInfo.obj?.extraData?.address2
       
    }
    
    
    func getUserInfo(){
        showLoader()
        userhandler.getUser(id: ShareData.shareInfo.obj?.id ?? "", Success: {response in
            self.hidLoader()
            ShareData.shareInfo.saveUser(user: response?.data)
            UserDefaults.standard.save(customObject: response?.data, inKey: "user")
            self.setDate()
            
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    
    @IBAction func accessType(_ sender: UIButton) {
        if istypeAccess == true {
            self.lbltypeAccess.text = ShareData.shareInfo.obj?.userType?.name
            self.hideshowtype.image = UIImage(named: "eye-regular")
        } else {
            self.lbltypeAccess.text = "*****"
            self.hideshowtype.image = UIImage(named: "HideEye")
        }
        self.istypeAccess = !istypeAccess
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            ShareData.shareInfo.isBiomatric = true
        } else {
            ShareData.shareInfo.isBiomatric = false
            
        }
    }
    @IBAction func personalInfoAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"UserPersonalInfoVC") as? UserPersonalInfoVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBOutlet weak var englishimg: UIImageView!
    
    @IBOutlet weak var frenchimg: UIImageView!
    @IBOutlet weak var espainimg: UIImageView!
    
    
    @IBAction func logoutAction(_ sender: UIButton) {
//        let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LogOutPopUpVC") as? LogOutPopUpVC
       
        vc?.callBack = {
            vc?.dismiss(animated: true, completion: nil)
            
            let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
            ShareData.shareInfo.saveUser(user: nil)
            ShareData.shareInfo.saveContract(contract: nil)
            let defaults = UserDefaults.standard
            defaults.set(nil, forKey: "checkuserExist")
            
            defaults.set(nil, forKey: "contractList")
            
            
            defaults.set(nil, forKey: "contractorData")
            UserDefaults.standard.set(nil, forKey: "notification")
            UserDefaults.standard.set(nil, forKey: "contactList")
            self.navigationController?.pushViewController(vc!, animated: true)
            
            defaults.set(nil, forKey: "contractorData")
            defaults.set(nil, forKey: "providerEmployeeData")
            defaults.set(nil, forKey: "contractorEmployeeData")
            defaults.set(nil, forKey: "invitation")
                    
        }
        vc?.modalPresentationStyle = .overFullScreen
        
        self.present(vc!, animated: false, completion: nil)
    }
    
    
    @IBAction func infoAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"InformationVC") as? InformationVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    //ic-check-2
    @IBAction func englishAction(_ sender: UIButton) {
       
            isfrench = false
            isespainssion = false
             isenglish = true
        
        englishimg.image = UIImage(named: "ic-check-2")
        frenchimg.image = UIImage(named: "")
        espainimg.image = UIImage(named: "")
        ShareData.shareInfo.saveLanguage = "en"
        myDefaultLanguage = .en
        view.setNeedsLayout()
        view.setNeedsDisplay()
        self.view.layoutIfNeeded()
        //self.navigationController?.popViewController(animated: true)
         viewDidLoad()
        
        
    }
    
    @IBAction func espanission(_ sender: UIButton) {
        isfrench = false
        isespainssion = true
         isenglish = false
    
            englishimg.image = UIImage(named: "")
            frenchimg.image = UIImage(named: "")
            espainimg.image = UIImage(named: "ic-check-2")
        ShareData.shareInfo.saveLanguage = "es"
        myDefaultLanguage = .es
        view.setNeedsLayout()
        view.setNeedsDisplay()
        self.view.layoutIfNeeded()
        
        viewDidLoad()
        //self.navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func frenchAction(_ sender: UIButton) {
        isfrench = true
        isespainssion = false
         isenglish = false
    
            englishimg.image = UIImage(named: "")
            frenchimg.image = UIImage(named: "ic-check-2")
            espainimg.image = UIImage(named: "")
    }
    
}
