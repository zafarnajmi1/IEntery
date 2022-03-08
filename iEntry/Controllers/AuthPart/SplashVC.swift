//
//  ViewController.swift
//  iEntry
//
//  Created by ZAFAR on 04/08/2021.
//

import UIKit
import Firebase
import FirebaseMessaging
class SplashVC: UIViewController {

    //MARK:- Splash screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBarHidShow(isTrue: true)
        moveOnLogin()
        //fatalError()
        if let token = Messaging.messaging().fcmToken {
           print("FCM Token", token)
            ShareData.shareInfo.token = token
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHidShow(isTrue: true)
    }

    //MARK:- This is funtion helps to move on other Screen
    
    func moveOnLogin() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    

}
