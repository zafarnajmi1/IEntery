//
//  LoginVC.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import UIKit
import Alamofire
let UUID = UIDevice.current.identifierForVendor?.uuidString
class LoginVC: BaseController {
    
    //MARK:- Here are the outlets
    @IBOutlet weak var btneye: UIButton!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var btnforgot: UIButton!
    @IBOutlet weak var lblhaveyou: UILabel!
    //let UUID = UIDevice.current.identifierForVendor?.uuidString
    var loginVM = LoginViewModel()
    var isBioMatricCanceled = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isTranslucent = false
//        KeychainService.saveUDID(token: "\(UUID)" as NSString)
//        let savedUDID = KeychainService.loadUDID()
          //print("UDID",savedUDID)
        
        //MARK:- Provider employee
           //"john@gmail.com"
           //"WbxbE7q5LA90"
        
        //MARK:- Provider
            //"Luis122@gmail.com"
            //"IdIxk3f89MTd"
        
        //MARK:- Cpntractor employeee
         //"luis45@gmail.com"
        //"odq4JM26KVsv"
        
        //MARK:- Contractor
         //"najm.technology786@gmail.com"
            //"lomTO2WqTQ87"
        
        //MARK:- Company
          //"luis.cornejo.2610@gmail.com"
        //"rootroot"
        
        if ShareData.shareInfo.Email != nil {
        self.txtemail.text = ShareData.shareInfo.Email
        }
        //"luis.cornejo.2610@gmail.com"
       // self.txtpassword.text = "root"
        conFigUI()
        
        
        if Network.isAvailable {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            
        }
        
    
        if (ShareData.shareInfo.obj != nil) {
            
            if Network.isAvailable {
                print("Internet connection OK")
                self.txtemail.text = ShareData.shareInfo.Email
               
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHidShow(isTrue: true)
        
        self.navigationController?.navigationBar.setNeedsLayout()
        if #available(iOS 15, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .white
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.tintColor = UIColor.white
            } else {
            
        }
        
    }
    
    func conFigUI() {
        self.txtemail.setPlaceHolderColor(color: #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1))
        self.txtpassword.setPlaceHolderColor(color: #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1))
        self.navigationBarHidShow(isTrue: true)
        emailView.roundViiew()
        passwordView.roundViiew()
        btnlogin.roundButtonWithCustomRadius(radius: 10)
        
        self.txtemail.placeholder = "NOMBRE DE USUARIO".localized
        self.txtpassword.placeholder = "CONTRASEÑA".localized
        self.btnlogin.setTitle("INICIAR SESIÓN".localized, for: .normal)
        self.lblhaveyou.text = "¿Has olvidado tu".localized
        self.btnforgot.setTitle("contraseña?".localized, for: .normal)

    }
    
    
    func checkData() -> Bool {
        if txtemail.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Email")
            return false
            
        } else if txtpassword.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter The Password")
            return false
        } else if self.txtemail.text?.isValidEmail == false{
            AppUtility.showErrorMessage(message: "Please Enter Valid Email")
            return false
        }
        return true
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if Network.isAvailable {
            print("Internet connection OK")
            if checkData() {
                if ShareData.shareInfo.isBiomatric == true {
                    
                    LoginBiomatric()
                } else {
                    LoginApiCall()
                }
                    
            }
        } else {
            print("Internet connection FAILED")
            
            if Network.isAvailable != true {
                AppUtility.showErrorMessage(message: "No Internet Exist")
                return
            }
            
        }
        
        
        //moveOnSelectRoleContractor()
        
    }
    
    func LoginBiomatric(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ThumScaningVC") as? ThumScaningVC
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { isok in
            if isok {
                print(isok)
                ShareData.shareInfo.isBiomatric = isok
                self.isBioMatricCanceled = false
                vc?.dismiss(animated: true, completion: nil)
                self.LoginApiCall()
            } else {
                print(isok)
                ShareData.shareInfo.isBiomatric = isok
                self.isBioMatricCanceled = true
                DispatchQueue.main.async() {
                    vc?.dismiss(animated: true, completion: nil)
                }
                
            }
            
        }
        self.present(vc!, animated: false, completion: nil)
        //self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    //MARK:- Caling Login Api
    func LoginApiCall() {
        
        //let dic = ["email":txtemail.text!,"password":txtpassword.text!]
        
        ShareData.shareInfo.Email = txtemail.text ?? ""
        ShareData.shareInfo.password = txtpassword.text ?? ""
        
        TokenManager.shareToken.token(email: ShareData.shareInfo.Email ?? "", password: ShareData.shareInfo.password ?? "", token: {
            accessToken in
            if !accessToken.isEmpty {
                ShareData.shareInfo.token = accessToken
                 self.loginCall()
            }else {
                AppUtility.showErrorMessage(message: "email or password is wrong")
            }
        })
        
        

    }
    
    
    
    func loginCall() {
        
        let dic = ["email":txtemail.text!,"password":txtpassword.text!]
        self.showLoader()
        loginVM.loginApiCall(params: dic, Success: { response,trycath  in
            self.hidLoader()
            if response?.success == true {
                
                ShareData.shareInfo.saveUser(user: response?.data)
                UserDefaults.standard.save(customObject: response?.data, inKey: "user")
                self.sendfcmToken()
                
                ShareData.shareInfo.password = self.txtpassword.text
                ShareData.shareInfo.Email = self.txtemail.text
                self.getuserCompanyRestrictionApi()
                //self.userDeviceLinkApi() // after testing i will remove this  function calling
                print("UDID",UUID)
                if response?.data?.deviceId == UUID || response?.data?.deviceId == "" || response?.data?.deviceId?.isEmpty == true || response?.data?.deviceId == nil {
                   
                    self.userDeviceLinkApi()
                
                     if response?.data?.status?.id == 2 {
                        
                        self.moveOnVerificationCode()
                    
                    } else if response?.data?.userType?.id == 1 {
                        
                        ShareData.shareInfo.userRole = .employees
                        self.moveOnEmployeeRole()
                        
                    }  else if response?.data?.userType?.id == 3 {
                        ShareData.shareInfo.userRole = .contractor
                        self.ContractorRole()
                    } else if response?.data?.userType?.id == 4 {
                        ShareData.shareInfo.userRole = .contractoremplyee
                        self.ContractorRole()
                        
                    }else if response?.data?.userType?.id == 5{
                                    ShareData.shareInfo.userRole = .provider
                                    self.providorRole()
                                
                    } else if response?.data?.userType?.id == 6{
                        ShareData.shareInfo.userRole = .provideremployee
                                    self.providorRole()
                               
                    }
                    
                } else  if response?.data?.deviceId != UUID{
                    
                    AppUtility.showErrorMessage(message:"you can not login in other device, first must unlik the other device or log in the same device" )
                    return
                
                    
                }
                
            } else {
                self.hidLoader()
                AppUtility.showErrorMessage(message: trycath ?? "somthing is wrong")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
        
    }
    
    func getuserCompanyRestrictionApi(){
        userhandler.getUserCompanyRistrictionData(Success: {response in
            if response?.success == true {
                ShareData.shareInfo.saveUserCompanyRestriction(user: response?.data)
                if ShareData.shareInfo.userRestrictionObj?.biocrValidationExternal == true {
                    self.checkUserSelfiApi()
                } else {
                    
                }
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    
    
    func checkUserSelfiApi(){
        userhandler.getCheckUserSelfiImage(userid: ShareData.shareInfo.obj?.id ?? "", Success: {response in
            if response?.success == true  {
                
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    
    
    func sendfcmToken() {
        userhandler.sendFCMToken(fcmtoken: ShareData.shareInfo.fcmToken ?? "", Success: {response in
            if response?.success == true {
              
            } else {
                
            }
        }, Failure: {error in
            
        })
    }

    func userDeviceLinkApi(){
        userhandler.LinkUserDevice(deviceID: UUID ?? "", Success: {response in
            if response?.success == true {
                
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    
   
    
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        self.moveOnEnterEmail()
    }
    
    @IBAction func passShwoHide(_ sender: UIButton) {
        if txtpassword.isSecureTextEntry {
            
        btneye.setImage(UIImage(named: "eye-regular"), for: .normal)
        } else {
            btneye.setImage(UIImage(named: "eye-slash-solid"), for: .normal)
        }
        txtpassword.isSecureTextEntry = !txtpassword.isSecureTextEntry
        
    }
    
    
    
    func moveOnEmployeeRole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyVC") as? CompanyVC //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    func companyrole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"HomeVC") as? HomeVC //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func ContractorRole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ContractVC") as? ContractVC//CompanyVC //HomeVC///EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func providorRole() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"OrdersVC") as? OrdersVC//CompanyVC //HomeVC///EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func moveOnEnterEmail() {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Main.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"EnterEmailVC") as? EnterEmailVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func moveOnVerificationCode() {
        
        
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier:"ThumScaningVC") as? ThumScaningVC
//        self.present(vc!, animated: true, completion: nil)
       // self.navigationController?.pushViewController(vc!, animated: true)
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationCodeVC") as? VerificationCodeVC
        vc?.email = txtemail.text!
        vc?.isfrom = false
        self.navigationController?.pushViewController(vc!, animated: true)
    
         
    }
    
    
    func scanThumb(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ThumScaningVC") as? ThumScaningVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}





//        var json = ""
//
//        let encoder = JSONEncoder()
//                if let jsonData = try? encoder.encode(dic) {
//                    if let jsonString = String(data: jsonData, encoding: .utf8) {
//                        json = jsonString
//                        print("Nice Json", jsonString)
//                    }
//                }

//        let url = URL(string: Constant.MainUrl)!
//        let jsonData = dictoJson(dic: dic).data(using:.utf8)//data(using: .utf8, allowLossyConversion: false)!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//
//        AF.request(request).responseJSON {
//            (response) in
//
//            print(response)
//        }
        


//var parentDataDict = [NSDictionary]()
//var childDataDict = [NSDictionary]()
//
////        for i in 0..<3 {
////            let tmpDict: NSDictionary = ["a1": 1, "b1": 2, "c1": 3]
////            childDataDict.append(tmpDict)
////        }
//
//for i in 0..<3 {
//    let tmpDict: NSDictionary = ["a2": 1, "b2": 2, "c2": 3]
//    childDataDict.append(tmpDict)
//}
//
//let tmpDict: NSDictionary = ["a": 1, "b": 2, "c": 3, "d": 4, "e": childDataDict]
//parentDataDict.append(tmpDict)
//
//let tmpDict2: NSDictionary = ["f": 1, "g": 2, "h": 3, "i": 4, "j": childDataDict]
//parentDataDict.append(tmpDict2)
//
//do {
//    let json = try JSONSerialization.data(withJSONObject: parentDataDict, options: .prettyPrinted)
//
//    print(NSString(data: json, encoding: String.Encoding.utf8.rawValue)! as String)
//}
//catch let error as NSError {
//    print(error)
//}
