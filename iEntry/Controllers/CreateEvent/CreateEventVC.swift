//
//  CreateEventVC.swift
//  iEntry
//
//  Created by ZAFAR on 12/08/2021.
//

import UIKit
import FSCalendar
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import SMDatePicker
class CreateEventVC: BaseController, FSCalendarDelegate, FSCalendarDataSource,UITextFieldDelegate, SMDatePickerDelegate {
    @IBOutlet weak var lblcompany: UILabel!
    @IBOutlet weak var lblreservationtitle: UILabel!
    
    @IBOutlet weak var lblagreetitle: UILabel!
    @IBOutlet weak var lblreservationbottomtitle: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    
    @IBOutlet weak var lblcreateEventtitle: UILabel!
    @IBOutlet weak var lblreservationlisttitle: UILabel!
    
    var  commenAreasdata : [CommenAreasModelsData]? = nil
    
    var starttimeInMiliSecDate = 0
    var endtimeInMiliSecDate = 0
    var reservationName = ""
    var reservationId = ""
    var startdate = Date()
    var endDate = Date()
    //MARK:- here are the iboutlet
    @IBOutlet weak var lblschedualtitle: UILabel!
    @IBOutlet weak var btncross: UIButton!
    
    @IBOutlet weak var btnprevius: UIButton!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var topBannerimg: UIImageView!
    @IBOutlet weak var fcCalaender: FSCalendar!
    @IBOutlet weak var txtEnterEvent: MDCOutlinedTextField!
    @IBOutlet weak var txtdate: MDCOutlinedTextField!
    @IBOutlet weak var txttime: MDCOutlinedTextField!
    
    @IBOutlet weak var stripView: UIView!
    var myDatePicker: SMDatePicker = SMDatePicker()
    @IBOutlet weak var tblheight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    
    
    @IBOutlet weak var topBannerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblcompany.text = ShareData.shareInfo.conractWithCompany?.company?.name
        self.lbladdress.text = ShareData.shareInfo.conractWithCompany?.company?.address
        self.tblView.isScrollEnabled = false
        
            let timeInMiliSecDate = Date()
            let timeInMiliSecEndDate = Date()
        
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate1 = dateFormatter1.string(from: timeInMiliSecDate)
            self.txtdate.text = stringDate1
           
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "HH:mm:ss"
            let stringDate2 = dateFormatter2.string(from: timeInMiliSecEndDate)
            self.txttime.text = stringDate2
            
         starttimeInMiliSecDate = Int (Date().timeIntervalSince1970 * 1000)
         endtimeInMiliSecDate = Int (Date().timeIntervalSince1970 * 1000)
        
        getallCommenAreasApi(startdate: timeInMiliSecDate, endDate: timeInMiliSecEndDate)
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "NearChoosCell", bundle: nil), forCellReuseIdentifier: "NearChoosCell")
        self.configUi()
        self.fcCalaender.bringSubviewToFront(btnnext)
        self.fcCalaender.bringSubviewToFront(btnprevius)
        
        
        self.lblcreateEventtitle.text = "C R E A R E V E N T O".localized
        
        self.lblschedualtitle.text = "ELÍGE UN HORARIO".localized
        self.lblreservationtitle.text = "ELÍGE LA AREA COMÚN A RESERVAR:".localized
        self.lblreservationbottomtitle.text = "RESERVACIONES".localized
        self.lblagreetitle.text = "AGREGAR EVENTO".localized
    }
    //MARK:- this funtion use to set the UI
    func configUi() {
      
        
        topBannerView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.6744349003, green: 0.6745528579, blue: 0.6744274497, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1.0)
        
        
        fcCalaender.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.6744349003, green: 0.6745528579, blue: 0.6744274497, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1.0)
        fcCalaender.delegate = self
        fcCalaender.dataSource = self
        fcCalaender.scrollDirection = .horizontal
        fcCalaender.pagingEnabled = true
        fcCalaender.scrollEnabled = true
        fcCalaender.scope = .month
        fcCalaender.appearance.headerMinimumDissolvedAlpha = 0
        setMDCTxtFieldDesign(txtfiled: txtEnterEvent, Placeholder: "NOMBRE DE TU EVENTO", imageIcon: trailingImage)
        setMDCTxtFieldDesign(txtfiled: txttime, Placeholder: "HORA", imageIcon: UIImage(named: "ic-calendar-2")!)
        setMDCTxtFieldDesign(txtfiled: txtdate, Placeholder: "FECHA", imageIcon: UIImage(named: "ic-calendar-1")!)
        stripView.roundViiew()
    
        txttime.delegate = self
        txtdate.delegate = self
    }
    
    var trailingImage: UIImage = {
      return UIImage.init(named: "ic-piñata",
                          in: Bundle(for: CreateEventVC.self),
                          compatibleWith: nil) ?? UIImage()
    }()
    
    //MARK:- Calender Delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
  

    @IBAction func addEventAction(_ sender: UIButton) {
        
        if self.commenAreasdata?.count == 0 {
            self.alert(message: "There is no commen areas you are unable to create event!")
            return
        }
        
        if reservationId == "" {
            self.alert(message: "please select the commen area")
            return
        }
        
        if txtEnterEvent.text == "" {
            self.alert(message: "please enter the event name")
            return
        }
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ConfirmEventVC") as? ConfirmEventVC
        vc?.name = self.txtEnterEvent.text!
        vc?.startDate = "\(starttimeInMiliSecDate)"
        vc?.endDate = "\(endtimeInMiliSecDate)"
        vc?.resevationid = reservationId
        vc?.reservationName = reservationName
        vc?.isfromupdate = false 
        
        vc?.modalPresentationStyle = .overFullScreen
        vc?.callBack = { Ok , eventid in
            if Ok == true {
                self.dismiss(animated: true, completion: nil)
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"EventInvitation") as? EventInvitation
                vc?.eventid = eventid
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        self.present(vc!, animated: false, completion: nil)
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
         if(keyPath == "contentSize"){
             if let newvalue = change?[.newKey]
             {
                 DispatchQueue.main.async {
                 let newsize  = newvalue as! CGSize
                 self.tblheight.constant = newsize.height
                 }

             }
         }
     }
    func getallCommenAreasApi(startdate:Date,endDate:Date){
        self.showLoader()
        
        let timeInMiliSecDate = startdate//Date()
        let timeInMiliSec = Int (timeInMiliSecDate.timeIntervalSince1970 * 1000)
        
        let timeInMiliSecEndDate = endDate//Date()
        let secEndDatetimeInMili = Int (timeInMiliSecEndDate.timeIntervalSince1970 * 1000)
        
        //30 * 24 * 60 * 60 * 1000
        let dic : [String:Any] = ["startDate":timeInMiliSec,"endDate": secEndDatetimeInMili,"userId":ShareData.shareInfo.obj?.id ?? ""]
        userhandler.getallCommenAreas(params: dic) { response in
            self.hidLoader()
            if response?.success == true {
                self.commenAreasdata =  response?.data
                
                self.tblView.reloadData()
                self.tblheight.constant =  self.tblView.contentSize.height

                self.view.layoutIfNeeded()
               
            } else {
                self.alert(message: response?.message ?? "")
            }
        } Failure: { error in
            self.hidLoader()
            self.alert(message: error.message)
        }

    }
    
    
    /**{
     "eventId": "8908efcf-5c47-410d-98a2-2465a8ff8707",
     "usersIds": [
         "36932667-041e-43e6-bede-edac0d7935ab",
         "7cabe77a-d24d-4d3d-8ef6-48c7eeb445e2"
     ],
     "guestNumber": 1
 }*/
    
    //MARK: - Next Button Action -
    @IBAction func btnNextMonthClicked(sender: UIButton) {

        let currentDate = self.fcCalaender.currentPage
        let date = self.dateByAddingMonths(dMonths: 1, currentDate: currentDate as NSDate)
        self.fcCalaender.setCurrentPage(date as Date, animated: true)
    }

    // For getting Next month
    func dateByAddingMonths(dMonths: Int, currentDate: NSDate) -> NSDate{

        let dateComponent = NSDateComponents()
        dateComponent.month = dMonths
        let newDate = NSCalendar.current.date(byAdding: dateComponent as DateComponents, to: currentDate as Date) //dateByAddingComponents(dateComponent, toDate: currentDate, options: NSCalendarOptions.WrapComponents)
        return newDate! as NSDate
    }

    //MARK: - Previous Button Action -
    @IBAction func btnPreviousMonthClicked(sender: AnyObject) {

        let currentDate = self.fcCalaender.currentPage
        let date = self.dateBySubtractingMonths(dMonths: 1, currentDate: currentDate as NSDate)
        self.fcCalaender.setCurrentPage(date as Date, animated: true)
    }

    // For Previous Month
    func dateBySubtractingMonths(dMonths: Int, currentDate: NSDate) -> NSDate{

        return self.dateByAddingMonths(dMonths: -dMonths, currentDate: currentDate)
    }
    
    
    
    
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func crossAction(_ sender: UIButton) {
        for item in 0..<self.commenAreasdata!.count{
            self.commenAreasdata?[item].isSelected = false
        }
        self.tblView.reloadData()
        self.lblreservationtitle.text = ""
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
            self.starttimeInMiliSecDate =  Int (picker.date.timeIntervalSince1970 * 1000)
            startdate = picker.date
            getallCommenAreasApi(startdate:startdate,endDate:endDate)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.date)
            self.txttime.text = stringDate
            self.endtimeInMiliSecDate =  Int (picker.date.timeIntervalSince1970 * 1000)
            endDate = picker.date
            getallCommenAreasApi(startdate:startdate,endDate:endDate)
        }
    }
    func  datePickerWillAppear(_ picker: SMDatePicker){
        print(picker.pickerDate)
        if picker.pickerMode == .date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy" //HH:mm
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txtdate.text = stringDate
            
            self.startdate = picker.pickerDate
            self.starttimeInMiliSecDate =  Int (picker.pickerDate.timeIntervalSince1970 * 1000)
            getallCommenAreasApi(startdate:startdate,endDate:endDate)
            print(starttimeInMiliSecDate)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let stringDate = dateFormatter.string(from: picker.pickerDate)
            self.txttime.text = stringDate
            
            //let timeInMiliSecDate = picker.pickerDate
//             endtimeInMiliSecDate = Int (timeInMiliSecDate.timeIntervalSince1970 * 1 * 24 * 60 * 60 * 1000)
            self.endtimeInMiliSecDate =  Int (picker.pickerDate.timeIntervalSince1970 * 1000)
            self.endDate = picker.pickerDate
            getallCommenAreasApi(startdate:startdate,endDate:endDate)
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

extension CreateEventVC :  UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commenAreasdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "NearChoosCell") as? NearChoosCell

        cell?.lblname.text = self.commenAreasdata?[indexPath.row].name
        cell?.lblvenu.text = self.commenAreasdata?[indexPath.row].name
        cell?.lblactive.text = self.commenAreasdata?[indexPath.row].status?.name
        
        
        if self.commenAreasdata?[indexPath.row].isSelected == true {
            cell?.mainView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            cell?.mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for item in 0..<self.commenAreasdata!.count{
            self.commenAreasdata?[item].isSelected = false
        }
        self.commenAreasdata?[indexPath.row].isSelected = true
        self.reservationName =  self.commenAreasdata?[indexPath.row].name ?? ""
        self.reservationId = self.commenAreasdata?[indexPath.row].zoneId ?? ""
        self.lblreservationtitle.text = self.commenAreasdata?[indexPath.row].name ?? ""
        self.tblView.reloadData()
    }

}
