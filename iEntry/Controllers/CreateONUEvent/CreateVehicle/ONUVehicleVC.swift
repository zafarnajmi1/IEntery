//
//  ONUVehicleVC.swift
//  iEntry
//
//  Created by ZAFAR on 30/04/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class ONUVehicleVC: BaseController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var txtvehicle: MDCOutlinedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setMDCTxtFieldDesign(txtfiled: txtvehicle, Placeholder: "VEHÍCULOS".localized, imageIcon: UIImage(named: "sort-down-solid")!)
        
        self.tblView.register(UINib.init(nibName: "ONUVehicleCell", bundle: nil), forCellReuseIdentifier: "ONUVehicleCell")
    }
    
    @IBAction func selectionVehicleAction(_ sender: UIButton) {
    }
    
    @IBAction func registerVehicleAction(_ sender: UIButton) {
        
        
        let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"CreateVehicleVC") as? CreateVehicleVC
        
        vc?.modalPresentationStyle = .overFullScreen
        
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "ONUEvent", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"TransportRequiredVC") as? TransportRequiredVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func ActionToBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
extension ONUVehicleVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ONUVehicleCell") as? ONUVehicleCell
        return cell!
    }
    
    
}
