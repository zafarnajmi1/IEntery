//
//  AddVehicleVC.swift
//  iEntry
//
//  Created by ZAFAR on 17/08/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class AddVehicleVC: BaseController {
    //MARK:- here are iboutlet
    @IBOutlet weak var stripView: UIView!
    @IBOutlet weak var txtstatus: MDCOutlinedTextField!
    @IBOutlet weak var txtDriver: MDCOutlinedTextField!
    @IBOutlet weak var txtvehicleType: MDCOutlinedTextField!
    @IBOutlet weak var txtplates: MDCOutlinedTextField!
    @IBOutlet weak var txtmodel: MDCOutlinedTextField!
    @IBOutlet weak var txtcolor: MDCOutlinedTextField!
    @IBOutlet weak var btnaddimg: UIButton!
    @IBOutlet weak var vehichleimg: UIImageView!
    
    @IBOutlet weak var txtsubBrand: MDCOutlinedTextField!
    @IBOutlet weak var txtbrand: MDCOutlinedTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMDCTxtFieldDesign(txtfiled: txtbrand, Placeholder: "BRAND", imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtsubBrand, Placeholder: "SUB-BRAND", imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtcolor, Placeholder: "COLOR", imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtmodel, Placeholder: "MODEL", imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtplates, Placeholder: "PLATES", imageIcon:UIImage())
        setMDCTxtFieldDesign(txtfiled: txtvehicleType, Placeholder: "VEHICLE TYPE", imageIcon:UIImage(named: "ic-arrow-down")!)
        setMDCTxtFieldDesign(txtfiled: txtDriver, Placeholder: "DRIVER", imageIcon:UIImage(named: "ic-arrow-down")!)
        setMDCTxtFieldDesign(txtfiled: txtstatus, Placeholder: "STATUS", imageIcon:UIImage(named: "ic-arrow-down")!)
       navigationBarHidShow(isTrue: true)
        vehichleimg.roundViiew()
        stripView.roundViiew()
        btnaddimg.roundButton()
        
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        vehichleimg.roundViiew()
    }
    //MARK:- this actin will appear impage picker 
    @IBAction func addimageAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ImagePoPUP") as? ImagePoPUP
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { [self] img in
            self.dismiss(animated: true, completion: nil)
            vehichleimg.image = img
        }
        self.present(vc!, animated: false, completion: nil)
    }
    

}
