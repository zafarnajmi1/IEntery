//
//  LanguageVC.swift
//  iEntry
//
//  Created by ZAFAR on 07/04/2022.
//

import UIKit

class LanguageVC: UIViewController {

    @IBOutlet weak var btnenglish: UIButton!
    @IBOutlet weak var btnspanish: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnenglish.setTitle("", for: .normal)
        btnspanish.setTitle("", for: .normal)
        self.navigationBarHidShow(isTrue: true)
    }
    

    @IBAction func spanishAction(_ sender: UIButton) {
        ShareData.shareInfo.saveLanguage = "es"
        myDefaultLanguage = .es
        moveOnLogin()
        
    }
    
    
    @IBAction func englishAction(_ sender: UIButton) {
        ShareData.shareInfo.saveLanguage = "en"
        myDefaultLanguage = .en
        moveOnLogin()
    }
    
    func moveOnLogin() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
