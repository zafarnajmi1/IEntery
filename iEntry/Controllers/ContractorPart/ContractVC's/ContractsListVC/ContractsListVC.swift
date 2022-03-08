//
//  ContractListVC.swift
//  iEntry
//
//  Created by ZAFAR on 01/09/2021.
//

import UIKit
import XLPagerTabStrip
import DZNEmptyDataSet
class ContractsListVC: BaseController,IndicatorInfoProvider {
    var contractoEmplyeeData:GetContractorEmployeeByUserIDModelData?
    var contractListdata = [IncomingContractListModelData]()
    fileprivate func  emptyDataSetUp() {
        self.tblView.emptyDataSetSource = self
        self.tblView.emptyDataSetDelegate = self
        self.tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CONTRATOS")
    }
    //MARK:- here are the iboutlet
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblView.register(UINib.init(nibName: "ContractsListCell", bundle: nil), forCellReuseIdentifier: "ContractsListCell")
        if ShareData.shareInfo.userRole == .contractoremplyee {
            self.getcontractorEmployeeApi()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getContractList()
    }
    
    func getcontractorEmployeeApi(){
        userhandler.getContractorEmployeeByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            if response?.success == true {
                self.contractoEmplyeeData = response?.data
                ShareData.shareInfo.saveContractorEmployeeGetByUserid(contractoremployee: (response?.data)!)
                print(ShareData.shareInfo.contractorEmployeedataValueGetByUserid)
            } else {
                
            }
        }, Failure: {error in
            
        })
    }
    
    
    
    
    
    @IBAction func CreateAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name:StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"CreateContractVC") as? CreateContractVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
//    @IBAction func mapAction(_ sender: UIButton) {
//
//        let storyBoard = UIStoryboard.init(name:StoryBoards.Home.rawValue, bundle: nil)
//             let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
//             self.navigationController?.pushViewController(vc!, animated: true)
//    }
    
    
    func getContractList(){
        var dic : [String:Any] = [:]
        self.showLoader()
         var url = ""
        if ShareData.shareInfo.userRole == .contractor {
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "","date":Int (Date().timeIntervalSince1970 * 1000)]
                url = Constant.MainUrl + Constant.URLs.incomingContractList
           
             
        } else if ShareData.shareInfo.userRole == .contractoremplyee{
            //contractorEmployeeId
            //ShareData.shareInfo.contractorEmployeedataValueGetByUserid?.id ?? ""
            dic = ["userId":ShareData.shareInfo.obj?.id ?? "","date":Int (Date().timeIntervalSince1970 * 1000)]
            url = Constant.MainUrl + Constant.URLs.getallIncomingContractorEmployee
            
            print(dic)
        }
        
        userhandler.getAllIncomingContractList(params: dic, newurl:url, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.contractListdata = response?.data ?? []
                
                ShareData.shareInfo.saveContractList(contract:response?.data ?? [])
                if self.contractListdata.count == 0 {
                    self.emptyDataSetUp()
                }
                self.tblView.reloadData()
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    
    
}
//MARK:- tableview delegate 
extension ContractsListVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contractListdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractsListCell") as? ContractsListCell
        
        cell?.lblusername.text = self.contractListdata[indexPath.row].contractor?.user?.name
        cell?.lblstartDate.text = getMilisecondstoDate(seconds: "\(self.contractListdata[indexPath.row].starDate ?? 0)", formatter: "")
        cell?.lblendDate.text = getMilisecondstoDate(seconds: "\(self.contractListdata[indexPath.row].endDate ?? 0)", formatter: "")
        cell?.lblcompanyName.text = self.contractListdata[indexPath.row].company?.name
        cell?.lblcontractNumber.text = "Contrato #\(indexPath.row)"
        
        
        
        if self.contractListdata[indexPath.row].status?.name == "CONTRACT_ACTIVE" {
        cell?.statusView.backgroundColor = #colorLiteral(red: 0.3941653073, green: 0.6643448472, blue: 0.6202048659, alpha: 1)
        cell?.lblstatsu.textColor = #colorLiteral(red: 0.3941653073, green: 0.6643448472, blue: 0.6202048659, alpha: 1)
        cell?.lblstatsu.text = self.contractListdata[indexPath.row].status?.name
        } else if self.contractListdata[indexPath.row].status?.name == "CONTRACT_FINISH" {
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            cell?.lblstatsu.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            cell?.lblstatsu.text = self.contractListdata[indexPath.row].status?.name
            } else if self.contractListdata[indexPath.row].status?.name == "CONTRACT_CANCEL" {
                cell?.statusView.backgroundColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
                cell?.lblstatsu.textColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
                cell?.lblstatsu.text = self.contractListdata[indexPath.row].status?.name
                }
        
        
        
        
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
            vc?.contractListdata = self.contractListdata[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        return cell!
    }
    
    
}
extension ContractsListVC : DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "you have no Contracts"
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let text = "Try Again!"
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4712097049, green: 0.7777811885, blue: 0.758687973, alpha: 1)
            ] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!){
        
       
        self.getContractList()
        
    }
    
    
    
}