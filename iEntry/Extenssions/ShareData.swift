//
//  ShareData.swift
//  Tanzeem
//
//  Created by Zafar Najmi on 03/08/2020.
//  Copyright © 2020 Zafar Najmi. All rights reserved.
//

import Foundation
import KRProgressHUD
class ShareData {
    static let shareInfo = ShareData()
       private init (){}
       
    
    //let obj = UserDefaults.standard.retrieve(object: LoginDataModel.self, fromKey: "user")
    //let conractWithCompany = UserDefaults.standard.retrieve(object:GetContractByUserModelData.self, fromKey:"UserContractWithCompany")
    
    
    
    var companyRistriction :CompanyRistrictionData?
    
    func savecompanyRistriction(company:CompanyRistrictionData?){
        companyRistriction = company
        setcompanyStriction(user: companyRistriction!)
    }
    
    
    func setcompanyStriction(user:CompanyRistrictionData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "companyStriction")
           
        }

    }

    var companyRistrictiondata: CompanyRistrictionData? {
        get {
            return UserDefaults.standard.retrieve(object: CompanyRistrictionData.self, fromKey: "companyStriction")
        }
        set {
            
            UserDefaults.standard.save(customObject: companyRistriction, inKey: "companyStriction")
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var providerEmployeeGetByUserid : ProviderUserByIdModelData?
    
    func saveproviderEmployeeGetByUserid(provideremployee:ProviderUserByIdModelData?){
        providerEmployeeGetByUserid = provideremployee
        setproviderEmployeeGetByUserid(user: providerEmployeeGetByUserid!)
    }
    
    
    func setproviderEmployeeGetByUserid(user:ProviderUserByIdModelData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "providerEmployeeData")
           
        }

    }

    var providerEmployeedataValueGetByUserid: ProviderUserByIdModelData? {
        get {
            return UserDefaults.standard.retrieve(object: ProviderUserByIdModelData.self, fromKey: "providerEmployeeData")
        }
        set {
            
            UserDefaults.standard.save(customObject: providerEmployeeGetByUserid, inKey: "providerEmployeeData")
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    var contractorEmployeeGetByUserid : GetContractorEmployeeByUserIDModelData?
    
    func saveContractorEmployeeGetByUserid(contractoremployee:GetContractorEmployeeByUserIDModelData?){
        contractorEmployeeGetByUserid = contractoremployee
        setContractorEmployeeGetByUserid(user: contractorEmployeeGetByUserid!)
    }
    
    
    func setContractorEmployeeGetByUserid(user:GetContractorEmployeeByUserIDModelData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "contractorEmployeeData")
           
        }

    }

    var contractorEmployeedataValueGetByUserid: GetContractorEmployeeByUserIDModelData? {
        get {
            return UserDefaults.standard.retrieve(object: GetContractorEmployeeByUserIDModelData.self, fromKey: "contractorEmployeeData")
        }
        set {
            
            UserDefaults.standard.save(customObject: contractorEmployeeGetByUserid, inKey: "contractorEmployeeData")
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    var contractorListDataGetByUserid : GetContractorByUserIdModelData?
    
    func saveContractorListGetByUserid(contractor:GetContractorByUserIdModelData){
        contractorListDataGetByUserid = contractor
        setContractorListvalueGetByUserid(user: contractorListDataGetByUserid!)
    }
    
    
    func setContractorListvalueGetByUserid(user:GetContractorByUserIdModelData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "contractorData")
           
        }

    }

    var contractorListdataValueGetByUserid: GetContractorByUserIdModelData {
        get {
            return UserDefaults.standard.retrieve(object: GetContractorByUserIdModelData.self, fromKey: "contractorData")!
        }
        set {
            
            UserDefaults.standard.save(customObject: contractorListDataGetByUserid, inKey: "contractorData")
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    var contractListData = [IncomingContractListModelData]()
    
    func saveContractList(contract:[IncomingContractListModelData]){
        contractListData = contract
        setContractListvalue(user: contractListData)
    }
    
    
    func setContractListvalue(user:[IncomingContractListModelData]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "contractList")
           
        }

    }

    var contractListdataValue: [IncomingContractListModelData] {
        get {
            return UserDefaults.standard.retrieve(object: [IncomingContractListModelData].self, fromKey: "contractList") ?? []
        }
        set {
            
            UserDefaults.standard.save(customObject: contractListData, inKey: "contractList")
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var notificationlist = [CreatedNotification]()
    
    func saveNotification(qualification:String, message:String, notificationkind: String, Notificationtime:String, Notificationdate:String, notificationType:String, username:String,createdAt:String,type:String){
        do {
            
            // retrieving a value for a key
            if let data = UserDefaults.standard.data(forKey: "notification"),
                let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [CreatedNotification] {
                myPeopleList.forEach({print($0.type, $0.username)})  // Joe 10
                notificationlist = myPeopleList
            }
            
                    // setting a value for a key
            let newPerson = CreatedNotification(qualification: qualification, message: message, notificationkind: notificationkind, Notificationtime: Notificationtime, Notificationdate: Notificationdate, notificationType: notificationType, username: username, createdAt: createdAt, type: type)
                    
            notificationlist.append(newPerson)
                    let encodedData = try NSKeyedArchiver.archivedData(withRootObject: notificationlist, requiringSecureCoding: false)
                    UserDefaults.standard.set(encodedData, forKey: "notification")
                   
                } catch {
                    print("There is Error:",error)
                }
    }
    
    func getBacNotificationsSaved() -> [CreatedNotification]{
        do {
            if let data = UserDefaults.standard.data(forKey: "notification"),
                let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [CreatedNotification] {
                notificationlist = myPeopleList
                myPeopleList.forEach({print($0.type, $0.username)})  // Joe 10
            }
                    
            
                } catch {
                    print(error)
                }
        return notificationlist
    }
    
    
    
    
    
    
    
    
    
    
    
    
    var contractData:GetContractByUserModelData?
    
    func saveContract(contract:GetContractByUserModelData?){
        contractData = contract
        setContractvalue(user: contractData)
    }
    
    
    func setContractvalue(user:GetContractByUserModelData?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.resetStandardUserDefaults()
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "UserContractWithCompany")
           
        }

    }

    var conractWithCompany: GetContractByUserModelData? {
        get {
            return UserDefaults.standard.retrieve(object: GetContractByUserModelData.self, fromKey: "UserContractWithCompany")
        }
        set {
            
            UserDefaults.standard.save(customObject: userData, inKey: "UserContractWithCompany")
            
        }
    }
    
    
    
    
    
    
    
    var userData:LoginDataModel?
    
    func saveUser(user:LoginDataModel?){
        userData = user
        setvalue(user:user)
    }
    
    
    func setvalue(user:LoginDataModel?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "user")
            defaults.set(encoded, forKey: "login")
        }

    }

    var obj: LoginDataModel? {
        get {
            return UserDefaults.standard.retrieve(object: LoginDataModel.self, fromKey: "user")
        }
        set {
            
            UserDefaults.standard.save(customObject: userData, inKey: "user")
            
        }
    }
    
    
    
    let existuser:getUserIsExistModelData? = nil
    func saveExistUser(existuser:getUserIsExistModelData) {
        setValueOrExistUser(existuser:existuser)
    }
    
    func setValueOrExistUser(existuser:getUserIsExistModelData){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(existuser) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "checkuserExist")
        }
    }
    
    var checkUserExist = UserDefaults.standard.retrieve(object:getUserIsExistModelData.self, fromKey:"checkuserExist")
    
    
    
    
    var userRole : UserRole = .employees
       var Loging : LoginModel?

       func LoginData(data: LoginModel){
         Loging = data
       }
    var companyData:CompanyRegisterModel?
    
    func compData(data: CompanyRegisterModel){
        companyData = data
    }
//     var invitationlist : [InvitationsHistoryModel]?
//     func invitationlistData(data: [InvitationsHistoryModel]){
//        invitationlist = data
//     }
    
    
    var invitationlist = [InvitationsHistoryModel]()
    
    func invitatiosdataSaved(name: String, phone:String, date:String,guestid:String){
        do {
            
            // retrieving a value for a key
            if let data = UserDefaults.standard.data(forKey: "invitation"),
                let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [InvitationsHistoryModel] {
                myPeopleList.forEach({print($0.name, $0.name)})  // Joe 10
                invitationlist = myPeopleList
            }
            
                    // setting a value for a key
            let newPerson = InvitationsHistoryModel(name:name, phone:phone, date:date, guestid: guestid)
                    
            invitationlist.append(newPerson)
                    let encodedData = try NSKeyedArchiver.archivedData(withRootObject: invitationlist, requiringSecureCoding: false)
                    UserDefaults.standard.set(encodedData, forKey: "invitation")
                    // retrieving a value for a key
//                    if let data = UserDefaults.standard.data(forKey: "invitation"),
//                        let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [InvitationsHistoryModel] {
//                        myPeopleList.forEach({print($0.name, $0.name)})  // Joe 10
//                    }
                } catch {
                    print("There is Error:",error)
                }
    }
    
    func getBackinvitatiosdataSaved() -> [InvitationsHistoryModel]{
        do {
            if let data = UserDefaults.standard.data(forKey: "invitation"),
                let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [InvitationsHistoryModel] {
                invitationlist = myPeopleList
                myPeopleList.forEach({print($0.name, $0.name)})  // Joe 10
            }
                    
            
                } catch {
                    print(error)
                }
        return invitationlist
    }
    
    var checkRegisterUser = [checkUserExistModel]()
    func contactListSaved(isregister: Bool, name: String, phoneemail: String, guestid: String,registertype:Int){
        do {
                    // setting a value for a key
            let newPerson = checkUserExistModel(name: name, phone: phoneemail, isregister: isregister, guestid: guestid, registertype: registertype)
                    
            checkRegisterUser.append(newPerson)
                    let encodedData = try NSKeyedArchiver.archivedData(withRootObject: checkRegisterUser, requiringSecureCoding: false)
                    UserDefaults.standard.set(encodedData, forKey: "contactList")
                    
                } catch {
                    print("There is Error:",error)
                }
    }
    
    
    func getBackcontactListSaved() -> [checkUserExistModel]{
        do {
           
            if let data = UserDefaults.standard.data(forKey: "contactList"),
                let myPeopleList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [checkUserExistModel] {
                
                checkRegisterUser = myPeopleList
                myPeopleList.forEach({print($0.name, $0.name)})  // Joe 10
            }
                  
                } catch {
                    print(error)
                }
        return checkRegisterUser
    }
    
    
    
    
    var userID: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "userID")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "userID")
            
        }
    }
    
    var password: String? {
        get {
            return UserDefaults.standard.string(forKey: "password")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "password")
            
        }
    }
    
    
    var fcmToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "fcmToken")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "fcmToken")
            
        }
    }
    
    var RoleId: String? {
        get {
            return UserDefaults.standard.string(forKey: "RoleId")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "RoleId")
            
        }
    }
    
     var LoginCode: String? {
          get {
              return UserDefaults.standard.string(forKey: "LoginCode")
          }
          set {
              
                  UserDefaults.standard.set(newValue, forKey: "LoginCode")
              
          }
      }
    
    var vericode: String? {
        get {
            return UserDefaults.standard.string(forKey: "vericode")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "vericode")
            
        }
    }
    
    var FName: String? {
           get {
               return UserDefaults.standard.string(forKey: "FName")
           }
           set {
               
                   UserDefaults.standard.set(newValue, forKey: "FName")
               
           }
       }
    
    
    var LName: String? {
        get {
            return UserDefaults.standard.string(forKey: "LName")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "LName")
            
        }
    }
    
    
    
    var Phone: String? {
        get {
            return UserDefaults.standard.string(forKey: "Phone")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "Phone")
            
        }
    }
    
    var Email: String? {
        get {
            return UserDefaults.standard.string(forKey: "Email")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "Email")
            
        }
    }
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "token")
            
        }
    }
    
    
    var lat: String? {
        get {
            return UserDefaults.standard.string(forKey: "lat")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "lat")
            
        }
    }
    
    var long: String? {
        get {
            return UserDefaults.standard.string(forKey: "long")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "long")
            
        }
    }
    
    var isStartShift : Bool? {
            get {
                return UserDefaults.standard.bool(forKey: "isStartShift")
            }
        set{
            UserDefaults.standard.set(newValue, forKey: "isStartShift")        }
    }
    
    
    
    var isBiomatric : Bool? {
            get {
                return UserDefaults.standard.bool(forKey: "isBiomatric")
            }
        set{
            UserDefaults.standard.set(newValue, forKey: "isBiomatric")        }
    }
    
    
    
    var isBeakStart : Bool? {
            get {
                return UserDefaults.standard.bool(forKey: "isBeakStart")
            }
        set{
            UserDefaults.standard.set(newValue, forKey: "isBeakStart")        }
    }
    
    var BreakTime: String? {
        get {
            return UserDefaults.standard.string(forKey: "BreakTime")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "BreakTime")
            
        }
    }
    /*let id : Int?
    let first_name : String?
    let last_name : String?
    let image : String?
    let phone : String?
    let email : String?
    let is_verified : Bool?
    let is_active : Int?
    let role_id : String?
    let gender : String?
    let date_of_birth : String?
    let verification_code : String*/
    
    
    
    var DOB: String? {
        get {
            return UserDefaults.standard.string(forKey: "DOB")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "DOB")
            
        }
    }
    
    
    var Gender: String? {
        get {
            return UserDefaults.standard.string(forKey: "Gender")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "Gender")
            
        }
    }
    
    
    var image: String? {
        get {
            return UserDefaults.standard.string(forKey: "image")
        }
        set {
            
                UserDefaults.standard.set(newValue, forKey: "image")
            
        }
    }
    
    
    var  isLoginType : String? {
        get{
            return UserDefaults.standard.string(forKey: "isLoginType")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoginType")
        }
    }
    
    var  companyid : String? {
        get{
            return UserDefaults.standard.string(forKey: "companyid")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "companyid")
        }
    }
    
    var saveLanguage:String?{
        set{
            UserDefaults.standard.set(newValue , forKey: "saveLanguage")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey:  "saveLanguage")
        }
    }
    
    
       class func showProgress() {
          
           
           KRProgressHUD.show()
       }
       
       class func hideProgress() {
           DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
              KRProgressHUD.dismiss()
           }
       }
    
}
