//
//  ViewController.swift
//  iEntry
//
//  Created by ZAFAR on 04/08/2021.
//

import UIKit
import Firebase
import FirebaseMessaging
class SplashVC: BaseController {

    //MARK:- Splash screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBarHidShow(isTrue: true)
        //moveOnLang()
        //fatalError()
        if let token = Messaging.messaging().fcmToken {
           print("FCM Token", token)
            ShareData.shareInfo.fcmToken = token
        }
        
        TokenManager.shareToken.token(email: ShareData.shareInfo.Email ?? "", password: ShareData.shareInfo.password ?? "", token: { accessToken in
            ShareData.shareInfo.token = accessToken
        })
        
        
        if (ShareData.shareInfo.obj != nil) {
            
            if Network.isAvailable {
                print("Internet connection OK")
                if ShareData.shareInfo.saveLanguage?.isEmpty == true  {
                    moveOnLang()
                } else {
                    //moveOnHome()
                    moveOnLogin()
                }
               
            } else {
                
//                if ShareData.shareInfo.saveLanguage?.isEmpty == true  {
//                    moveOnLang()
//                } else {
//                    moveOnHome()
//                }
                //moveOnLogin()
                AppUtility.showErrorMessage(message: "No Internet Connection")
                
                return
             }
        } else {
            
            if ShareData.shareInfo.saveLanguage?.isEmpty == true  {
                moveOnLang()
            } else {
                moveOnLogin()
            }
            
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHidShow(isTrue: true)
    }

    //MARK:- This is funtion helps to move on other Screen
    
    func moveOnLang() {
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LanguageVC") as? LanguageVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func moveOnLogin() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func moveOnHome() {
//        if  ShareData.shareInfo.obj?.deviceId == UUID || ShareData.shareInfo.obj?.deviceId == "" || ShareData.shareInfo.obj?.deviceId?.isEmpty == true {
//
//            self.userDeviceLinkApi()
        
        
        
        if ShareData.shareInfo.obj?.status?.id == 2 {
                self.moveOnVerificationCode()
            } else if ShareData.shareInfo.obj?.userType?.id == 1 {
                ShareData.shareInfo.userRole = .employees
                self.moveOnEmployeeRole()
                
            }  else if ShareData.shareInfo.obj?.userType?.id == 3 {
                ShareData.shareInfo.userRole = .contractor
                self.ContractorRole()
            } else if ShareData.shareInfo.obj?.userType?.id == 4 {
                ShareData.shareInfo.userRole = .contractoremplyee
                self.ContractorRole()
                
            }else if ShareData.shareInfo.obj?.userType?.id == 5{
                            ShareData.shareInfo.userRole = .provider
                            self.providorRole()
                        
            } else if ShareData.shareInfo.obj?.userType?.id == 6{
                ShareData.shareInfo.userRole = .provideremployee
                            self.providorRole()
                       
            }
//        } else  if ShareData.shareInfo.obj?.deviceId != UUID  {
//            AppUtility.showErrorMessage(message:"you can not login in other device, first must unlik the other device or log in the same device" )
//            return
//        }
        
    }
    
    func userDeviceLinkApi(){
        userhandler.LinkUserDevice(deviceID: UUID ?? "", Success: {response in
            if response?.success == true {
                
            } else {
                
            }
        }, Failure: {error in
            
        })
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
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"VerificationCodeVC") as? VerificationCodeVC
        vc?.email = ShareData.shareInfo.Email ?? ""
        vc?.isfrom = true
        self.navigationController?.pushViewController(vc!, animated: true)
    
         
    }

}

