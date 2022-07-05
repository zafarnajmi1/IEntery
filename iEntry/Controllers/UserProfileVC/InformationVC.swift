//
//  InformationVC.swift
//  iEntry
//
//  Created by ZAFAR on 08/11/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class InformationVC: BaseController {
    var extraData : ExtradataModelData?
    
    @IBOutlet weak var lblupdattitle: UILabel!
    @IBOutlet weak var lblinfotitle: UILabel!
    //MARK:- here are the iboutlet
    @IBOutlet weak var txtaddress: MDCOutlinedTextField!
    
    @IBOutlet weak var txtaddress2: MDCOutlinedTextField!
    
    @IBOutlet weak var txtstate: MDCOutlinedTextField!
    
    @IBOutlet weak var txtcountery: MDCOutlinedTextField!
    
    @IBOutlet weak var txtpostcode: MDCOutlinedTextField!
    
    @IBOutlet weak var txtArabicName: MDCOutlinedTextField!
    @IBOutlet weak var txtphonenumber: MDCOutlinedTextField!
    
    @IBOutlet weak var txtblood: MDCOutlinedTextField!
    
    @IBOutlet weak var btnupdate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblupdattitle.text = "ACTUALIZAR DATOS".localized
        self.lblinfotitle.text = "Información".localized
        setMDCTxtFieldDesign(txtfiled: txtaddress, Placeholder: "ADDRESS 1".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtaddress2, Placeholder: "ADDRESS 2".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtstate, Placeholder: "STATE".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtcountery, Placeholder: "COUNTRY".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtpostcode, Placeholder: "POST CODE".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtphonenumber, Placeholder: "HOME NUMBER".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtArabicName, Placeholder: "ARABIC NAME".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtblood, Placeholder: "BLOOD TYPE".localized, imageIcon: UIImage())
        
        if ShareData.shareInfo.userRole == .contractoremplyee || ShareData.shareInfo.userRole == .provideremployee {
            self.txtcountery.isUserInteractionEnabled = false
            self.txtstate.isUserInteractionEnabled = false
            self.txtblood.isUserInteractionEnabled = false
            self.txtaddress.isUserInteractionEnabled = false
            self.txtaddress2.isUserInteractionEnabled = false
            self.txtphonenumber.isUserInteractionEnabled = false
            self.txtpostcode.isUserInteractionEnabled = false
            self.txtArabicName.isUserInteractionEnabled = false
            self.btnupdate.isUserInteractionEnabled = false
        } else {
            self.txtcountery.isUserInteractionEnabled = true
            self.txtstate.isUserInteractionEnabled = true
            self.txtblood.isUserInteractionEnabled = true
            self.txtaddress.isUserInteractionEnabled = true
            self.txtaddress2.isUserInteractionEnabled = true
            self.txtphonenumber.isUserInteractionEnabled = true
            self.txtpostcode.isUserInteractionEnabled = true
            self.txtArabicName.isUserInteractionEnabled = true
            self.btnupdate.isUserInteractionEnabled = true
        }
        if Network.isAvailable {
           getExtraDataApi()
        } else {
            AppUtility.showErrorMessage(message: "No internet Connection")
        }
    }
    
    
    func getExtraDataApi() {
        self.showLoader()
        userhandler.getExtraData(id: ShareData.shareInfo.obj?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.extraData =  response?.data
                
                self.txtcountery.text = self.extraData?.country
                self.txtstate.text = self.extraData?.town
                self.txtblood.text = self.extraData?.bloodType
                self.txtaddress.text = self.extraData?.address1
                self.txtaddress2.text = self.extraData?.address2
                self.txtphonenumber.text = self.extraData?.homePhone
                self.txtpostcode.text = self.extraData?.postalCode
                self.txtArabicName.text = self.extraData?.arabicName
                
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }

    @IBAction func saveDataAction(_ sender: UIButton) {
        
        if Network.isAvailable {
            print("Internet connection OK")
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"AcceptORRejectionPopUpVC") as? AcceptORRejectionPopUpVC
            vc?.modalPresentationStyle = .overFullScreen
            vc?.callBack = {
                vc?.dismiss(animated: true, completion: nil)
                self.updateExtraDataApi()
            }
            self.present(vc!, animated: false, completion: nil)
        } else {
            print("Internet connection FAILED")
            AppUtility.showErrorMessage(message: "No internet Connection")
            
        }
        
        
        //self.navigationController?.popViewController(animated: true)
    }
    
    
    func updateExtraDataApi(){
        showLoader()
        let dic : [String:Any] = ["id":ShareData.shareInfo.obj?.extraData?.id ?? "","town":txtstate.text!,"country":txtcountery.text!,"postalCode":txtpostcode.text!,"homePhone":txtphonenumber.text!,"arabicName":txtArabicName.text!,"bloodType":txtblood.text!,"contractorName":"9JSAJSDAI343","note":"none","wasVaccinated":true,"address1":txtaddress.text!,"address2":txtaddress2.text!]
        userhandler.updateExtradatauser(params: dic,id:ShareData.shareInfo.obj?.id ?? "", Success: {response in
            self.hidLoader()
            if response?.success == true {
               
                self.navigationController?.popViewController(animated: true)
                AppUtility.showSuccessMessage(message: response?.message ?? "")
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    @IBAction func backAction(_ sender: UIButton) {
        
        
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
       let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationDownloadImageAlertVC") as? NotificationDownloadImageAlertVC
        vc?.titlofDialog = "CAMBIOS EN EL PERFIL".localized
        vc?.detailofDialog = "Si sales sin guardar los cambios, todo lo registrado se perderá y tendrás nuevamente que volver a hacer los cambios. ¿Estás seguro que quieres descartar los cambios?".localized
        vc?.acceptbuttontitle = "ACEPTAR".localized
       vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { isok in 
            self.navigationController?.popViewController(animated: true)
        }
       self.present(vc!, animated: false, completion: nil)
    }
    
}
