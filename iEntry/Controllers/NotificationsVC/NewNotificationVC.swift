//
//  AddNotificationVC.swift
//  iEntry
//
//  Created by ZAFAR on 27/08/2021.
//

import UIKit
import Photos
import MaterialComponents.MaterialTextControls_FilledTextFields
import SMDatePicker
import DropDown
class NewNotificationVC: BaseController, UITextViewDelegate,SMDatePickerDelegate, UITextFieldDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var fileView: UIView!
    @IBOutlet weak var lblfilename: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblaceptitle: UILabel!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var lblnewinvitationtitle: UILabel!
    let timeInMiliSec = Date()
    var sectimeInMili = 0
    var  userListdata = [GetAllUsersListModelData]()
    var selectedUsersList = [String]()
    var isEmployee =  false
    var fileName = ""
    var fileUrl : URL?
    var  notificationsdata : [GetAllNotificationTypesModelData]? = nil
    @IBOutlet weak var txtscop: MDCOutlinedTextField!
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    @IBOutlet weak var txttime: MDCOutlinedTextField!
    var createNotifidata : CreateNotificationModelData?
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tblView: UITableView! {
        didSet{
            
            tblView.dataSource = self
            tblView.delegate = self
            //tblView.isScrollEnabled = false
            tblView.register(UINib.init(nibName: "NewNotificationCell", bundle: nil), forCellReuseIdentifier: "NewNotificationCell")
        }
    }
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var txtkind: MDCOutlinedTextField!
    @IBOutlet weak var txttypeNotification: MDCOutlinedTextField!
    //@IBOutlet weak var txtmsg: MDCFilledTextArea!
    @IBOutlet weak var txtqualificatioon: MDCOutlinedTextField!
    var typenotiId = 0
    var notititle = ""
    var msg = ""
    var myDatePicker: SMDatePicker = SMDatePicker()
    var MainDrowpDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblnewinvitationtitle.text = "N U E V A  N O T I F I C A CI O N".localized
        self.lblaceptitle.text = "ENVIAR".localized
        self.getallUsersListApi()
        searchView.shadowAndRoundcorner(cornerRadius: Float(searchView.layer.frame.height) / 2, shadowColor: #colorLiteral(red: 0.8430451751, green: 0.843190372, blue: 0.843035996, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1)
        searchButtonView.roundCorners([.topRight,.bottomRight], radius: 25)
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        //sectimeInMili = Int(timeInMiliSec.timeIntervalSince1970 * 1000)
        self.navigationBarHidShow(isTrue: true)
       
        setMDCTxtFieldDesign(txtfiled: txtqualificatioon, Placeholder: "TÍTULO".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txttypeNotification, Placeholder: "TIPO DE NOTIFICACIÓN".localized, imageIcon: UIImage(named: "sort-down-solid")!)
        
        setMDCTxtFieldDesign(txtfiled: txtkind, Placeholder: "TIPO".localized, imageIcon: UIImage())
        setMDCTxtFieldDesign(txtfiled: txttime, Placeholder: "DE".localized, imageIcon: UIImage(named: "ic-calendar-2")!)
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "FECHA".localized, imageIcon: UIImage(named: "ic-calendar-1")!)
        setMDCTxtFieldDesign(txtfiled: txtscop, Placeholder: "ALCANCE".localized, imageIcon: UIImage(named: "sort-down-solid")!)
        
        
        let estimatedFrame = CGRect(x: 0, y: 0, width: self.msgView.frame.width, height: self.msgView.frame.height)
        let textArea = MDCOutlinedTextArea(frame: estimatedFrame)
        textArea.label.text = "MENSAJE".localized
        textArea.containerRadius = 10
        textArea.textView.delegate = self
        textArea.sizeToFit()
        self.msgView.addSubview(textArea)
        viewheight.constant = 80
        
        textArea.setOutlineColor( #colorLiteral(red: 0.4391649365, green: 0.4392448664, blue: 0.4391598701, alpha: 1), for: .editing)
        textArea.setOutlineColor( .lightGray , for: .disabled)
        textArea.setOutlineColor( #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1) , for: .normal)
        
        
        txttime.delegate = self
        txtdate.delegate = self
    }
    
    @IBAction func searchaction(_ sender: UIButton) {
        if txtsearch.text == "" {
            
            return
        }
        
    }
    
    @IBAction func backAcrion(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func crossFileAction(_ sender: UIButton) {
    }
    @IBAction func galleryAction(_ sender: UIButton) {
        // create the alert
                let alert = UIAlertController(title: "Alert", message: "Select Image", preferredStyle: UIAlertController.Style.alert)

                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { action in
                    self.openCamera()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { galerryAction in
                    self.openGallery()
                }))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        controller.allowsEditing = false
        present(controller, animated: true, completion: nil)
    }

    
    func openGallery() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        controller.allowsEditing = false
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func fileAction(_ sender: UIButton) {
    
        let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.data")], in: .import)
        if #available(iOS 11.0, *) {
                importMenu.allowsMultipleSelection = true
            }
           importMenu.delegate = self
           importMenu.modalPresentationStyle = .formSheet
           self.present(importMenu, animated: true, completion: nil)
    }
    
    
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        
        self.fileUrl = myURL
        self.fileName = myURL.lastPathComponent
        self.lblfilename.text = self.fileName
        print("import result : \(myURL)")
        self.fileView.isHidden = false
        img.image = nil
        if img.image == nil {
            img.image = nil
            img.isHidden = true
        }
    }
          

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    func getallUsersListApi(){
        userhandler.getAllusers(companyid: ShareData.shareInfo.contractData?.company?.id ?? "", Success: {response in
            if response?.success == true {
                self.userListdata = response?.data ?? []
            } else {
                
            }
        }, Failure: {error in
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    
    func checkData()->Bool {
        if txtqualificatioon.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter Title")
            return false
        }
        
//        else if txtdate.text == "" {
//            AppUtility.showErrorMessage(message: "Please Enter The Date")
//            return false
//        } else if txttime.text == ""{
//            AppUtility.showErrorMessage(message: "Please Enter The Time")
//            return false
//        }
        
        else if txttypeNotification.text == "" {
            AppUtility.showErrorMessage(message: "Please Enter The Notification Type")
            return false
        }
        
//        else if txtkind.text == "" {
//            AppUtility.showErrorMessage(message: "Please Enter The Type")
//            return false
//        }
        
        return true
    }
    
    func getallnotificationTypesApi(){
        userhandler.getAllNotificationTypes { response  in
            if response?.success == true {
                self.notificationsdata = response?.data
            } else {
                
            }
        } Failure: { error  in
            
        }

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tblHeight.constant = self.tblView.contentSize.height
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tblHeight.constant = self.tblView.contentSize.height
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
         if(keyPath == "contentSize"){
             if let newvalue = change?[.newKey]
             {
                 DispatchQueue.main.async {
                 let newsize  = newvalue as! CGSize
                    self.tblHeight.constant = newsize.height
                 }

             }
         }
     }
    
    
    
    
    
    @IBAction func stripAction(_ sender: UIButton) {
        if checkData(){
            createNotificationApi()
        }
    }
    
    
    
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.count {
//            viewheight.constant = CGFloat(textView.text.count)
//        }
//
////        if textView.text.count <= 125 {
////            viewheight.constant = CGFloat(textView.text.count)
////        }
//    }
    
    
    
    
    
    func createNotificationApi(){
        self.showLoader()
        var topic = ""
        var path = ""
        
        if fileUrl?.absoluteString.isEmpty == true {
            path = "notification_image"
        } else {
            path = "notification_file"
        }
        
        if ShareData.shareInfo.userRole == .contractor ||  ShareData.shareInfo.userRole == .contractoremplyee
        {
           topic = "CONTRACTOR"
        } else if  ShareData.shareInfo.userRole == .provider ||  ShareData.shareInfo.userRole == .provideremployee {
                     topic = "PROVIDER"
            
            } else if ShareData.shareInfo.userRole == .employees {
                 topic = "EMPLOYEE"
            }
        
        let userdic : [String:Any] = ["id":ShareData.shareInfo.obj?.id ?? ""]
        let companydic : [String:Any] = ["id":ShareData.shareInfo.conractWithCompany?.company?.id ?? ""]
        let notificationTypeDic: [String:Any] = ["id":typenotiId]
        let dic :[String:Any] = ["title":txtqualificatioon.text ?? "","message":msg,"dateMeeting":sectimeInMili,"user":userdic,"company":companydic,"notificationType":notificationTypeDic,"type":txtkind.text ?? "", "topic": topic]
        
        userhandler.createNotification(params: dic, Success: {response in
            self.hidLoader()
            
            if response?.success == true {
                ShareData.shareInfo.saveNotification(qualification: self.txtqualificatioon.text!, message:self.msg, notificationkind: self.txtkind.text!, Notificationtime:"\(self.sectimeInMili)", Notificationdate: "\(self.sectimeInMili)", notificationType: self.txttypeNotification.text!, username: ShareData.shareInfo.obj?.name ?? "", createdAt: "\(response?.data?.createdAt ?? 0)", type: "\(self.typenotiId)",dateMeeting:"\(response?.data?.dateMeeting ?? 0)",path:"\(response?.data?.path ?? "\(path)")",driveId:"\(response?.data?.driveId ?? "")",file:"\(response?.data?.file ?? "")",image:"\(response?.data?.image ?? "")",id:"\(response?.data?.id ?? "")")
                self.createNotifidata =  response?.data
                
                if self.img.image != nil {
                    self.uploadImage(notificationId: self.createNotifidata?.id ?? "")
                }
                
                if self.fileUrl?.absoluteString.isEmpty == false {
                    self.uploadFile(notificationId: self.createNotifidata?.id ?? "")
                }
                
                if self.img.image == nil && self.fileUrl?.absoluteString.isEmpty == true {
                    
                    if self.isEmployee == false {
                    self.navigationController?.popViewController(animated: true)
                    } else {
                        self.createNotificationWithUsersApi(notificationid: response?.data?.id ?? "")
                    }
                }
                //AppUtility.showErrorMessage(message: response?.message ?? "")
            } else {
                AppUtility.showErrorMessage(message: response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    /*{
     "notificationId": "90f684fa-d25a-4c26-bc60-170594a50ea2",
     "employeesIds": [
         "36932667-041e-43e6-bede-edac0d7935ab",
         "7cabe77a-d24d-4d3d-8ef6-48c7eeb445e2"
     ]
 }*/
    func createNotificationWithUsersApi(notificationid:String){
        self.selectedUsersList.removeAll()
        
        for item in self.userListdata {
            if item.isSelected == true {
                self.selectedUsersList.append(item.id ?? "")
            }
        }
        
        
        let dic : [String:Any] = ["notificationId":notificationid,"employeesIds":selectedUsersList]
        self.showLoader()
        userhandler.createNotificationWithUsers(params: dic, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.navigationController?.popViewController(animated: true)
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message: error.message)
        })
    }
    
    
    func uploadImage(notificationId:String){
        
        let dic:[String:Any] = ["id":notificationId,"option":"notification_image"]
        userhandler.uploadImage(param:dic,img:self.img.image,file:"file",Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.img.image = nil
                if self.isEmployee == false {
                self.navigationController?.popViewController(animated: true)
                } else {
                    self.createNotificationWithUsersApi(notificationid: self.createNotifidata?.id ?? "")
                }
            } else {
                
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message:error.message)
        })
    }
    
    func uploadFile(notificationId:String){
        let dic:[String:Any] = ["id":notificationId,"option":"notification_file"]
        userhandler.uploadUserFile(param:dic,fileurl: fileUrl!, Success: {response in
            self.hidLoader()
            if response?.success == true {
                self.fileUrl = URL(string: "")
                if self.isEmployee == false {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.createNotificationWithUsersApi(notificationid: self.createNotifidata?.id ?? "")
                }
            } else {
                AppUtility.showErrorMessage(message:response?.message ?? "")
            }
        }, Failure: {error in
            self.hidLoader()
            AppUtility.showErrorMessage(message:error.message)
        })
    }
    
    
    
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        self.msg = textView.text
        if textView.text.count < 80 {
            viewheight.constant = 80 //CGFloat(textView.text.count)
        } else {
            if textView.text.count <= 125 {
                     viewheight.constant = CGFloat(textView.text.count)
               }
            
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtdate {
            self.datePickerConfig(DatePickerMood:.date)
            myDatePicker.showPickerInView(view, animated: true)
        } else {
            self.datePickerConfig(DatePickerMood:.time)
            myDatePicker.showPickerInView(view, animated: true)
        }
    }
    
    
    //MARK:- datePicker general funtion
    func datePickerConfig(DatePickerMood:UIDatePicker.Mode) {
        myDatePicker.delegate = self
        myDatePicker.minimumDate = Date()
        myDatePicker.toolbarBackgroundColor = UIColor.white
        myDatePicker.pickerBackgroundColor = UIColor.white
        myDatePicker.pickerMode = DatePickerMood
        // Customize title
        myDatePicker.title = ""
        myDatePicker.titleFont = UIFont.systemFont(ofSize: 16)
        myDatePicker.titleColor = UIColor.white
        if #available(iOS 13.4, *) {
            myDatePicker.picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        myDatePicker.picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(canceleDatePicker))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(onClickDoneButton))
        myDatePicker.leftButtons = [ cancel]
        myDatePicker.rightButtons = [doneButton]
    }
    
    //MARK:- datepicker tools funtion
    @objc func canceleDatePicker() {
       /// myDatePicker.hidePicker(true)
        myDatePicker.pressedCancel(self)
    }

    //Toolbar done button function
    @objc func onClickDoneButton() {
        myDatePicker.hidePicker(true)
        
    }
    
    @objc func datePickerValueChanged(_ picker : UIDatePicker) {
        print(picker.date)
        if picker.datePickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.date)
            self.txtdate.text = stringDate
            
            sectimeInMili = StartDayMiliSeconds(newdate: picker.date.startOfDay()!) ?? 0//Int(picker.date.timeIntervalSince1970 * 1000)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.date)
            self.txttime.text = stringDate
            sectimeInMili = StartDayMiliSeconds(newdate: picker.date.startOfDay()!) ?? 0//Int(picker.date.timeIntervalSince1970 * 1000)
            
        }
    }
    
    
    @IBAction func notificationAction(_ sender: UIButton) {
        dropDownConfig(txtField: txttypeNotification, data: ["JUNTA","ANUNCIO","OTRO"])
    }
    @IBAction func scopAction(_ sender: UIButton) {
        dropDownConfig(txtField: txtscop, data: ["TODOS (EMPLEADOS, PROVEEDORES , CONTRATISTAS)","SOLO EMPLEADOS","SOLO CONTRATISTAS","SOLO PROVEEDORES","SELECCIONAR EMPLEADOS"])
    }
    //MARK:- General dropdown function
    func dropDownConfig(txtField : UITextField, data:[String]) {
        MainDrowpDown.anchorView = txtField
        MainDrowpDown.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        MainDrowpDown.selectionBackgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        MainDrowpDown.dataSource =  data
        DropDown.appearance().textColor = #colorLiteral(red: 0.5527616143, green: 0.5568413734, blue: 0.5609211326, alpha: 1)
        DropDown.appearance().selectedTextColor = UIColor.red
        //DropDown.appearance().textFont = UIFont(name: "JosefinSans-Regular", size: 18)!
        self.MainDrowpDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .left
            
        }
        
        MainDrowpDown.bottomOffset = CGPoint(x: 0, y: txtField.bounds.height)
        MainDrowpDown.selectionAction = { [self](index: Int, item: String) in
            print(item)
//            self.txtselcted.text = item
//            self.question?.selectedAns = index
//            self.question?.answerText = item
//            self.delegate?.myclaimdropdown(cell:self, ind: index, Section: self.mysection  )
            
            if self.txtscop ==  txtField {
                txtscop.text = item
                
                if item == "SELECCIONAR EMPLEADOS" {
                    self.tblView.isHidden = false
                    self.isEmployee = true
                } else {
                    self.tblView.isHidden = true
                    self.tblHeight.constant = 0
                    self.isEmployee = false
                }
            } else if txttypeNotification == txtField {
                txttypeNotification.text = item
                if item == "JUNTA"{
                    self.typenotiId = 2
                    txtkind.isHidden = true
                    txttime.isHidden = false
                    txtdate.isHidden = false
                    
                } else if item == "ANUNCIO"{
                    self.typenotiId = 3
                    txtkind.isHidden = true
                    txttime.isHidden = true
                    txtdate.isHidden = true
                } else if item == "OTRO"{
                    txtkind.isHidden = false
                    txttime.isHidden = true
                    txtdate.isHidden = true
                    self.typenotiId = 4
                }
            }
            
        }
        MainDrowpDown.show()
    }
    
    
    //MARK:- DatePicker Delegates
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        if picker.pickerMode == .date {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txtdate.text = stringDate
            
        } else {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txttime.text = stringDate
            
        }
    }
    
    func datePickerDidAppear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }

    private func  datePicker(picker: SMDatePicker, didPickDate date: NSDate) {
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    func  datePickerDidCancel(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }

    
    func  datePickerWillDisappear(_ picker: SMDatePicker) {
        print(picker.pickerDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    
    func  datePickerDidDisappear(_ picker: SMDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
        let stringDate = dateFormatter.string(from: picker.pickerDate)
        
    }
    
}


extension NewNotificationVC : UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userListdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NewNotificationCell") as? NewNotificationCell
        cell?.lblname.text =  self.userListdata[indexPath.row].name
        cell?.lblrole.text =  self.userListdata[indexPath.row].userType?.name
        cell?.lblphone.text =  self.userListdata[indexPath.row].phoneNumber
        self.view.setNeedsLayout()
        //checkbox-outline
        
        if self.userListdata[indexPath.row].isSelected == true {
            cell?.btncheckbox.setBackgroundImage(UIImage(named: "ic-check-2"), for: .normal)
        } else {
            cell?.btncheckbox.setBackgroundImage(UIImage(named: "checkbox-outline"), for: .normal)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.userListdata[indexPath.row].isSelected = !self.userListdata[indexPath.row].isSelected
        self.tblView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 90
//    }
}
extension NewNotificationVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if self.fileUrl?.absoluteString.isEmpty == false {
            self.fileUrl = URL(string: "")
            self.fileName = ""
            self.fileView.isHidden = true
        
        }
        self.img.isHidden = false
        
//        let photo = info[.phAsset] as? PHAsset
//           fileName = photo?.value(forKey: "filename") as? String ?? ""
//          print(fileName)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let imageData = image.jpegData(compressionQuality: 0.5) {
            self.img.image = UIImage(data: image.compress(to: 500))
        }
    }
}
