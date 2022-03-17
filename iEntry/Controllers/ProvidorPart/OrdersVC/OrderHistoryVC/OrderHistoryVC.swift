//
//  OrderHistoryVC.swift
//  iEntry
//
//  Created by ZAFAR on 15/11/2021.
//

import UIKit
import XLPagerTabStrip
class OrderHistoryVC: BaseController,IndicatorInfoProvider {
    //MARK:- tab delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "HISTORIAL ORDENES")
    }
    var providerdata : ProviderUserByIdModelData?
    var contractdata : GetContractorByUserIdModelData?
    var ordersdata = [ProviderModelsData]()
    //MARK:- here are the iboutlet 
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //using same model and local storage for provider
        //print(ShareData.shareInfo.contractorListdataValueGetByUserid.id ?? "")
        self.tblView.register(UINib.init(nibName: "OrderHistoryCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryCell")
        //getProviderApi()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          //self.getproviderorderRecordsapi()
        
        if ShareData.shareInfo.userRole == .provideremployee {
           self.getProvideremployeeApi()
        } else {
            self.getProviderApi()
        }

    }
    
    
    
    func getProviderApi(){
        userhandler.getProviderByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            if response?.success == true {
                self.contractdata = response?.data
                ShareData.shareInfo.saveContractorListGetByUserid(contractor: (response?.data)!)
                print(ShareData.shareInfo.contractorListdataValueGetByUserid)

                self.getproviderorderRecordsapi()
            } else {

            }
        }, Failure: {error in

        })
    }
    
    
    func getProvideremployeeApi(){
        userhandler.getProviderEmployeeByUserIDs(userid: ShareData.shareInfo.obj?.id ?? "", Success: { response in
            if response?.success == true {
                self.providerdata = response?.data
                ShareData.shareInfo.saveproviderEmployeeGetByUserid(provideremployee: (response?.data)!)
               
                self.getproviderorderRecordsapi()
            } else {

            }
        }, Failure: {error in

        })
    }
    

    
    func getproviderorderRecordsapi(){
        self.showLoader()
        userhandler.getAfterDateProviderOrdersByUserIDs(userid: ShareData.shareInfo.userRole == .provider ? ShareData.shareInfo.contractorListdataValueGetByUserid.id ?? "" : ShareData.shareInfo.providerEmployeedataValueGetByUserid?.id ?? "", datevalue:"\(Int (Date().timeIntervalSince1970 * 1000))", isproviderEmployee: ShareData.shareInfo.userRole == .provider ? false : true , Success: {response in
               self.hidLoader()
            if response?.success == true {
                self.ordersdata = response?.data ?? []
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
extension OrderHistoryVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ordersdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryCell") as? OrderHistoryCell
        
        cell?.lblcompany.text = self.ordersdata[indexPath.row].company?.name ?? ""
        cell?.lblvehicle.text = self.ordersdata[indexPath.row].providerVehicle
        cell?.lblemployee.text = self.ordersdata[indexPath.row].providerEmployee?.user?.name ?? ""
        cell?.lbldeliverydate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.ordersdata[indexPath.row].deliveryDate ?? 0)", formatter: "");
        cell?.lbldeliverydetail.text = self.ordersdata[indexPath.row].description ?? ""
        cell?.lbldeliveryproduct.text = self.ordersdata[indexPath.row].item ?? ""
        cell?.lbldeliverycompany.text = self.ordersdata[indexPath.row].company?.name ?? ""
    
        cell?.lblreceiver.text = self.ordersdata[indexPath.row].userReceived ?? ""
        cell?.lblrecieverdate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.ordersdata[indexPath.row].createdAt ?? 0)", formatter: "");
        
        if self.ordersdata[indexPath.row].status?.name ?? "" == "ORDER_IN_COMING" {
            cell?.lblstatus.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            cell?.lblstatus.text = self.ordersdata[indexPath.row].status?.name ?? ""
        } else if self.ordersdata[indexPath.row].status?.name ?? "" == "ORDER_ON_COURSE" {
            cell?.lblstatus.textColor = #colorLiteral(red: 0.002495895373, green: 0.3927112222, blue: 0.5756467581, alpha: 1)
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.002665568143, green: 0.3928266764, blue: 0.5716279745, alpha: 1)
            cell?.lblstatus.text = self.ordersdata[indexPath.row].status?.name ?? ""
        }else if self.ordersdata[indexPath.row].status?.name ?? "" == "ORDER_DELIVERED" {
            cell?.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.9402042627, green: 0.6268541217, blue: 0, alpha: 1)
            cell?.lblstatus.text = self.ordersdata[indexPath.row].status?.name ?? ""
        }else if self.ordersdata[indexPath.row].status?.name ?? "" == "ORDER_CANCELED" {
            cell?.lblstatus.textColor = #colorLiteral(red: 0.7379251719, green: 0.001223876374, blue: 0, alpha: 1)
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.7379251719, green: 0.001223876374, blue: 0, alpha: 1)
            cell?.lblstatus.text = self.ordersdata[indexPath.row].status?.name ?? ""
        }
        
    
//        cell?.callBack = { Istrue in
//            if Istrue {
//            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
//            self.navigationController?.pushViewController(vc!, animated: true)
//            }
//
//            if !Istrue {
//            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier:"GeneralQRCodeVC") as? GeneralQRCodeVC
//            self.navigationController?.pushViewController(vc!, animated: true)
//            }
//        }
        
        
        cell?.moreDetailcallBack = { Ismore in
//            let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier:"ContractDetailVC") as? ContractDetailVC
//            self.navigationController?.pushViewController(vc!, animated: true)
            
            let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ProviderDetailVC") as? ProviderDetailVC
            vc?.isfromcurrentorder = false
            vc?.ordersdata = self.ordersdata[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        }
        return cell!
    }
    
    
}
