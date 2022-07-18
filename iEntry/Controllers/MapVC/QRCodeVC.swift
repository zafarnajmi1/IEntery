//
//  QRCodeVC.swift
//  iEntry
//
//  Created by ZAFAR on 13/08/2021.
//

import UIKit
import XLPagerTabStrip
class QRCodeVC: BaseController, IndicatorInfoProvider {
    @IBOutlet weak var bottomView: UIView!
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "CÓDIGO QR".localized)
    }
    
    
    @IBOutlet weak var btnscantitle: UIButton!
    @IBOutlet weak var lblmaptitle: UILabel!
    var contractdata : GetContractorByUserIdModelData?
    
    @IBOutlet weak var lblprofessional: UILabel!
    var isfromContract = false
    @IBOutlet weak var mpView: UIView!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var qrimg: UIImageView!
    @IBOutlet weak var userimg: UIImageView!
    
    //@IBOutlet weak var btnregenrateQRAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if ShareData.shareInfo.userRole == .provider || ShareData.shareInfo.userRole == .provideremployee {
            self.bottomView.isHidden = false
        } else {
            self.bottomView.isHidden = true
        }
        
        //QR CODE SCAN
        self.lblmaptitle.text = "MAPA A LA COMPAÑIA".localized
        var buttontitle = ""
        if ShareData.shareInfo.saveLanguage == "en"{
            buttontitle = "QR CODE SCAN"
        } else{
            buttontitle = "ESCANEAR CÓDIGO QR"
        }
        self.btnscantitle.setTitle(buttontitle.localized, for: .normal)
        
        if ShareData.shareInfo.userRole == .employees {
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 5 })) != nil {
                self.btnscantitle.isHidden = false
            } else {
                self.btnscantitle.isHidden = true
            }
        }
        
        if isfromContract == true {
            self.mpView.isHidden = false
        } else {
            self.mpView.isHidden = true
        }
        mainView.shadowAndRoundcorner(cornerRadius: 5, shadowColor: #colorLiteral(red: 0.8626509309, green: 0.8627994061, blue: 0.8626416326, alpha: 1), shadowRadius: 2.0, shadowOpacity: 1)
        
        userimg.roundViiew()
        //btnregenrateQRAction.roundButtonWithCustomRadius(radius: 5)
        navigationBarHidShow(isTrue: true)
        let qrString = "\(ShareData.shareInfo.obj?.email ?? "")" + (ShareData.shareInfo.obj?.phoneNumber)!
        qrimg.image = generateQRCode(from: qrString )
        self.lblusername.text = ShareData.shareInfo.obj?.name
        self.lbltime.text = self.getCurrentTime()
        self.lbldate.text = self.getCurrentDate()
        
        if ShareData.shareInfo.obj?.userType?.name == "EMPLOYEE" {
            if myDefaultLanguage == .en {
            self.lblprofessional.text = "EMPLOYEE"
            } else {
                self.lblprofessional.text = "EMPLEADO"
            }
        } else if ShareData.shareInfo.obj?.userType?.name == "GUEST"  {
            if myDefaultLanguage == .en {
            self.lblprofessional.text = "GUEST"
            } else {
                self.lblprofessional.text = "INVITADO"
            }
        }else if ShareData.shareInfo.obj?.userType?.name == "CONTRACTOR_IN_CHARGE"  {
            if myDefaultLanguage == .en {
            self.lblprofessional.text = "CONTRACTOR IN CHARGE"
            } else {
                self.lblprofessional.text = "CONTRATISTA A CARGO"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "CONTRACTORS_EMPLOYEE"  {
            if myDefaultLanguage == .en {
            self.lblprofessional.text = "CONTRACTORS EMPLOYEE"
            } else {
                self.lblprofessional.text = "EMPLEADO DE CONTRATISTA"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "PROVIDER_IN_CHARGE"  {
            if myDefaultLanguage == .en {
            self.lblprofessional.text = "PROVIDER IN CHARGE"
            } else {
                self.lblprofessional.text = "PROVEEDOR A CARGO"
            }
        }
        else if ShareData.shareInfo.obj?.userType?.name == "PROVIDER_EMPLOYEE"  {
            if myDefaultLanguage == .en {
            self.lblprofessional.text = "PROVIDER EMPLOYEE"
            } else {
                self.lblprofessional.text = "EMPLEADO DE PROVEEDOR"
            }
        }
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
       let manager = ZSideMenuManager(isRTL: false)
                    manager.openSideMenu(vc: self)

    }
    @IBAction func mapAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyMapVC") as? CompanyMapVC
        if  ShareData.shareInfo.userRole == .provideremployee {
            
            vc?.companyname =   ShareData.shareInfo.providerEmployeedataValueGetByUserid?.provider?.company?.name ?? ""
            vc?.address = ShareData.shareInfo.providerEmployeedataValueGetByUserid?.provider?.company?.address ?? ""
            vc?.lat = ShareData.shareInfo.providerEmployeedataValueGetByUserid?.provider?.company?.latitud ?? 0
            vc?.long = ShareData.shareInfo.providerEmployeedataValueGetByUserid?.provider?.company?.longitud ?? 0
            
            
            
            
        } else {
            vc?.companyname =   ShareData.shareInfo.contractorListdataValueGetByUserid?.company?.name ?? ""
            vc?.address = ShareData.shareInfo.contractorListdataValueGetByUserid?.company?.address ?? ""
            vc?.lat = ShareData.shareInfo.contractorListdataValueGetByUserid?.company?.latitud ?? 0
            vc?.long = ShareData.shareInfo.contractorListdataValueGetByUserid?.company?.longitud ?? 0
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    
    
    @IBAction func scanAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QRScanVC") as? QRScanVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ValidAction(_ sender: UIButton) {
    }
    
}
