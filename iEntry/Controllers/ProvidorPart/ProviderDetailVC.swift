//
//  ProviderDetailVC.swift
//  iEntry
//
//  Created by ZAFAR on 10/03/2022.
//

import UIKit

class ProviderDetailVC: BaseController {
    
    @IBOutlet weak var lblsupliretitle: UILabel!
    var isfromcurrentorder = false
    var ordersdata :ProviderModelsData?
    @IBOutlet weak var lbldeliverytitle: UILabel!
    @IBOutlet weak var lblcompany: UILabel!
    @IBOutlet weak var lblemployee: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblvihicl: UILabel!
    
    @IBOutlet weak var lblproducttitle: UILabel!
    @IBOutlet weak var lbluserdeliverytitle: UILabel!
    @IBOutlet weak var lblinformationtitle: UILabel!
    
    
    @IBOutlet weak var lbldeliverydate: UILabel!
    @IBOutlet weak var lbldeliverycompany: UILabel!
    
    @IBOutlet weak var lbldeliveryproduct: UILabel!
    
    @IBOutlet weak var lbldeliveryDiscription: UILabel!
    
    @IBOutlet weak var lbldeliverydatetitle: UILabel!
    @IBOutlet weak var lblcompanytitle: UILabel!
    
    @IBOutlet weak var recieverView: UIView!
    
    @IBOutlet weak var lbldescriptiontitle: UILabel!
    @IBOutlet weak var lblemployeetitle: UILabel!
    
    @IBOutlet weak var lbldeliverycompanytitle: UILabel!
    @IBOutlet weak var lblrecieverDate: UILabel!
    @IBOutlet weak var lblrecieverusername: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblinformationtitle.text = "INFORMACIÓN DEL PROVEEDOR".localized
        self.lblcompanytitle.text = "Compañia".localized
        self.lblemployeetitle.text = "Empleado".localized
        self.lbldeliverytitle.text = "INFORMACIÓN DE ENTREGA".localized
        self.lbldeliverycompanytitle.text = "Compañia".localized
        self.lblproducttitle.text = "Producto".localized
        self.lbldescriptiontitle.text = "Descripción".localized
        self.lblsupliretitle.text = "INFORMACIÓN DEL PROVEEDOR".localized
        self.lbldeliverydatetitle.text = "Fecha de entrega".localized
        self.lbluserdeliverytitle.text = "Recibido por".localized
        self.navigationBarHidShow(isTrue: true)
        if isfromcurrentorder == true  {
            recieverView.isHidden = true
        } else {
            recieverView.isHidden = false
            
        }
        self.configData()
    }
    
    func configData(){
        
        
        
        self.lblcompany.text = self.ordersdata?.company?.name ?? ""
        self.lblemployee.text = self.ordersdata?.providerEmployee?.user?.name ?? ""
//        self.statusView.te
//       lblstatus: UILabel!
        self.lblvihicl.text = self.ordersdata?.providerVehicle ?? ""
        
        
        
        
        self.lbldeliverydate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.ordersdata?.deliveryDate ?? 0)", formatter: "");
        self.lbldeliveryDiscription.text = self.ordersdata?.description ?? ""
        self.lbldeliveryproduct.text = self.ordersdata?.item ?? ""
        self.lbldeliverycompany.text = self.ordersdata?.company?.name ?? ""
    
        if self.ordersdata?.status?.name ?? "" == "ORDER_IN_COMING" {
            self.lblstatus.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            self.statusView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            self.lblstatus.text = self.ordersdata?.status?.name ?? ""
        } else if self.ordersdata?.status?.name ?? "" == "ORDER_ON_COURSE" {
            self.lblstatus.textColor = #colorLiteral(red: 0.002495895373, green: 0.3927112222, blue: 0.5756467581, alpha: 1)
            self.statusView.backgroundColor = #colorLiteral(red: 0.002665568143, green: 0.3928266764, blue: 0.5716279745, alpha: 1)
            self.lblstatus.text = self.ordersdata?.status?.name ?? ""
        }else if self.ordersdata?.status?.name ?? "" == "ORDER_DELIVERED" {
            self.lblstatus.textColor = #colorLiteral(red: 0.9481226802, green: 0.630784452, blue: 0, alpha: 1)
           self.statusView.backgroundColor = #colorLiteral(red: 0.9402042627, green: 0.6268541217, blue: 0, alpha: 1)
            self.lblstatus.text = self.ordersdata?.status?.name ?? ""
        }else if self.ordersdata?.status?.name ?? "" == "ORDER_CANCELED" {
            self.lblstatus.textColor = #colorLiteral(red: 0.7379251719, green: 0.001223876374, blue: 0, alpha: 1)
            self.statusView.backgroundColor = #colorLiteral(red: 0.7379251719, green: 0.001223876374, blue: 0, alpha: 1)
            self.lblstatus.text = self.ordersdata?.status?.name ?? ""
        }
        
        
        self.lblrecieverDate.text = self.getFormattedMilisecondstoDate(seconds: "\(self.ordersdata?.createdAt ?? 0)", formatter: "");
        self.lblrecieverusername.text = self.ordersdata?.userReceived ?? ""

        
    }

    
    @IBAction func backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
