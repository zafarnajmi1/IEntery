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
    
    //MARK:- here are the iboutlet
    @IBOutlet weak var txtaddress: MDCOutlinedTextField!
    
    @IBOutlet weak var txtaddress2: MDCOutlinedTextField!
    
    @IBOutlet weak var txtstate: MDCOutlinedTextField!
    
    @IBOutlet weak var txtcountery: MDCOutlinedTextField!
    
    @IBOutlet weak var txtpostcode: MDCOutlinedTextField!
    
    @IBOutlet weak var txtArabicName: MDCOutlinedTextField!
    @IBOutlet weak var txtphonenumber: MDCOutlinedTextField!
    
    @IBOutlet weak var txtblood: MDCOutlinedTextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMDCTxtFieldDesign(txtfiled: txtaddress, Placeholder: "ADDRESS 1", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtaddress2, Placeholder: "ADDRESS 2", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtstate, Placeholder: "STATE", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtcountery, Placeholder: "COUNTRY", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtpostcode, Placeholder: "POST CODE", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtphonenumber, Placeholder: "HOME NUMBER", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtArabicName, Placeholder: "ARABIC NAME", imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txtblood, Placeholder: "BLOOD TYPE", imageIcon: UIImage())
        getExtraDataApi()
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
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }

    @IBAction func saveDataAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"AcceptORRejectionPopUpVC") as? AcceptORRejectionPopUpVC
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = {
            vc?.dismiss(animated: true, completion: nil)
            self.updateExtraDataApi()
        }
        self.present(vc!, animated: false, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    
    func updateExtraDataApi(){
        showLoader()
        let dic : [String:Any] = ["id":ShareData.shareInfo.obj?.extraData?.id ?? "","town":txtstate.text!,"country":txtcountery.text!,"postalCode":txtpostcode.text!,"homePhone":txtphonenumber.text!,"arabicName":txtArabicName.text!,"bloodType":txtblood.text!,"contractorName":"9JSAJSDAI343","note":"none","wasVaccinated":true,"address1":txtaddress.text!,"address2":txtaddress2.text!]
        userhandler.updateExtradatauser(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
               
                self.navigationController?.popViewController(animated: true)
                self.alert(message: response?.message ?? "")
            } else {
                self.alert(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            self.alert(message: error.message)
        })
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
