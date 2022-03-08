//
//  OrderHistoryVC.swift
//  iEntry
//
//  Created by ZAFAR on 15/11/2021.
//

import UIKit
import XLPagerTabStrip
class OrderHistoryVC: UIViewController,IndicatorInfoProvider {
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "HISTORIAL ORDENES")
    }
    //MARK:- here are the iboutlet 
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //using same model and local storage for provider
        print(ShareData.shareInfo.contractorListdataValueGetByUserid.id ?? "")
        self.tblView.register(UINib.init(nibName: "OrderHistoryCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryCell")
    }
    
    @IBAction func CreateAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name:StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"CreateContractVC") as? CreateContractVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func mapAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name:StoryBoards.Home.rawValue, bundle: nil)
             let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
             self.navigationController?.pushViewController(vc!, animated: true)
    }
}
//MARK:- tableview delegate
extension OrderHistoryVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryCell") as? OrderHistoryCell
        
        
        
    
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
