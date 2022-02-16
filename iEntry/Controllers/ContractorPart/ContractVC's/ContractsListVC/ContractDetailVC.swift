//
//  ContractDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit

class ContractDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func UpDateAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"UpdateContractVC") as? UpdateContractVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func qrCodeAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"GeneralQRCodeVC") as? GeneralQRCodeVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
