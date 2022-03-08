//
//  CurrentOrderVC.swift
//  iEntry
//
//  Created by ZAFAR on 15/11/2021.
//

import UIKit
import XLPagerTabStrip
class CurrentOrderVC: UIViewController,IndicatorInfoProvider {
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ORDENES EN CURSO")
    }
    //MARK:- here are the iboutlet 
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblView.register(UINib.init(nibName: "CurrentOrderCells", bundle: nil), forCellReuseIdentifier: "CurrentOrderCells")
    }
    
//    @IBAction func CreateAction(_ sender: UIButton) {
//        let storyBoard = UIStoryboard.init(name:StoryBoards.Contract.rawValue, bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier:"CreateContractVC") as? CreateContractVC
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
    
    @IBAction func mapAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name:StoryBoards.Home.rawValue, bundle: nil)
             let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
             self.navigationController?.pushViewController(vc!, animated: true)
    }
}
//MARK:- table view delegate
extension CurrentOrderVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentOrderCells") as? CurrentOrderCells
        
        
        
    
        cell?.callBack = { Istrue in
            if Istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
            self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            if !Istrue {
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"GeneralQRCodeVC") as? GeneralQRCodeVC
            self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
        
        cell?.moreDetailcallBack = { Ismore in
//            let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier:"ContractDetailVC") as? ContractDetailVC
//            self.navigationController?.pushViewController(vc!, animated: true)
            
            
            let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ContractInformationVC") as? ContractInformationVC
        self.navigationController?.pushViewController(vc!, animated: true)
        }
        return cell!
    }
    
    
}
