//
//  ContractorDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 02/09/2021.
//

import UIKit

class ContractorDetailVC: UIViewController {
    //MARK:- here are the iboutlet
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidShow(isTrue: true)
    }
    

    @IBAction func updateAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name:StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"UpdateContractorVC") as? UpdateContractorVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
