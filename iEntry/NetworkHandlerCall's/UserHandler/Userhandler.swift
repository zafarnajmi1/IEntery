//
//  Userhandler.swift
//  CarInsurance
//
//  Created by Apple on 7/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

import Alamofire


class userhandler {
   class func getGender(id:Int,Success: @escaping (GetGenderModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
    let url = Constant.MainUrl + Constant.URLs.getGender + "\(id)"
       
        Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

            do {
                print(successResponse)
                let responseModel = try JSONDecoder().decode(GetGenderModel.self, from: successResponse.data!)
                Success(responseModel)
            }
            catch {
                print("Response Error")
            }


        } , Falioure: {(Error) in
            Failure(Error)
        })
    }
    
    
    class func getAllGender(Success: @escaping (GetAllGenderModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllgender
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetAllGenderModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }

    
    
    
    class func createUserEmployeeContract(params:[String:Any],Success: @escaping (CreateUserContractModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createUserCompanyContract
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateUserContractModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    class func updateUserEmployeeContract(params:[String:Any],Success: @escaping (CreateUserContractModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateUserCompanyContract
        
         Networkhandler.PutRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateUserContractModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    class func getZoneByID(Success: @escaping (GetZoneModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getZonebyId
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetZoneModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }

    
    class func createZone(params:[String:Any],Success: @escaping (CreateZoneModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createZone
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateZoneModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Get All Zones
    
    class func getAllZone(params:[String:Any],Success: @escaping (GetAllZonesModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllZone
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetAllZonesModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    class func createExtradatauser(params:[String:Any],Success: @escaping (CreateExtraUserDataModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.CreateExtraDataUser
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateExtraUserDataModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    class func updateExtradatauser(params:[String:Any],Success: @escaping (CreateExtraUserDataModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateExtraDataUser
        print("url",url)
         Networkhandler.PutRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateExtraUserDataModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
   
    
    class func sendFCMToken(fcmtoken:String,Success: @escaping (FCMTokenModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + "authentication-service/set-firebase-id/\(fcmtoken)/user-id/"
        //"/user-id/\(ShareData.shareInfo.obj?.id ?? "")"
        print("firabse url ", url)
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(FCMTokenModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    class func getSixDigitCode(Success: @escaping (SixDigitCodeModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl + Constant.URLs.getSixDigitCode + "\(ShareData.shareInfo.obj?.id! ?? "")"
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(SixDigitCodeModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
///check-verification-code/{code}/by-username/{username}
    
    class func verifySixDigitCode(Success: @escaping (VerifySixDigitCodeModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        let url = Constant.MainUrl +  "authentication-service/check-verification-code/\(ShareData.shareInfo.obj?.id! ?? "")/by-username/\(ShareData.shareInfo.obj?.email! ?? "")"
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(VerifySixDigitCodeModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Get Contract By USer ID
    
    class func getContractByUserID(id:String,Success: @escaping (GetContractByUserModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.userContractcompanyservice + id
        print("url company", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetContractByUserModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Get getCompany Ristrictions
    
    class func getCompanyristrictionByID(id:String,Success: @escaping (CompanyRistriction?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getcompanyRistriction + id
        print("url company", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CompanyRistriction.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    //MARK:- Get Update Company Ristrictions
    
    class func updateCompanyristrictionByID(param:[String:Any],Success: @escaping (CompanyRistriction?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateCompanyRidtriction
        print("url company", url)
         Networkhandler.PutRequest(url: url, parameters: param,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CompanyRistriction.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Get All Invitations By USer ID
    
    class func getInvitationsByUserID(id:String,Success: @escaping (GetallInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllInvitationByUserID + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetallInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Pre Registrarion
    
    class func preRegisteration(params:[String:Any],Success: @escaping (getUserIsExistModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.preRegister
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(getUserIsExistModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- check user Existience
    
    class func checkUserExist(phone:String,Success: @escaping (getUserIsExistModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.searchUserbyPhone + phone
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(getUserIsExistModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- Create Invitation
    
    class func createInvitation(params:[String:Any],Success: @escaping (CreateInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createInvitation
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- getEvent by user id after Date
    
    class func getEventsAfterDate(afterdate:Int,Success: @escaping (EventModule?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getEventafterDate + "/\(afterdate)"
        print("EventsUrl:",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventModule.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- getEvent by user id Before Date
    
    class func getEventsBeforeDate(beforedate:Int,Success: @escaping (EventModule?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getBeforeDateEvent + "/\(beforedate)"
        print("belfore Date Url :", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventModule.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- getCommen Areas
    
    class func getallCommenAreas(params:[String:Any],Success: @escaping (CommenAreasModels?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getcommenAreas
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CommenAreasModels.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK:- getInvitations by user id after Date
    
    //EventInvitationsModels
    class func getEventsinvitatinsAftereDate(miliseconds:Int,Success: @escaping (EventModule?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getEventInvitationAfterDate + "/\(miliseconds)/to-validate"
        print("UrleventInvitation", url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventModule.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- Create Event
    
    class func createEvent(params:[String:Any],Success: @escaping (CreateEventModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createEvent
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateEventModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- getEvent Detail
    
    class func getEventDetail(id:String,Success: @escaping (EventDetailModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getEventDetailById + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventDetailModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- getAll invitations Against Event
    
    class func getInvitationsAgainstEvent(id:String,Success: @escaping (getAllInvitationsAgainstEventModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllInvitationAgainstEvent + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(getAllInvitationsAgainstEventModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- send Invitation
    
    class func sendInvitation(params:[String:Any],Success: @escaping (EventUpdateInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.sendInvitation
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(EventUpdateInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Cancel Invitation
    
    class func CancelInvitation(id:String,Success: @escaping (CancelEventModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.cancelEvent + "\(id)"
        
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CancelEventModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- get Notification After Date
    
    class func getNotificationAfterDate(afterdate:Int,Success: @escaping (NotificationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.notification + "/\(afterdate)"
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(NotificationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Create Notification
    
    class func createNotification(params:[String:Any],Success: @escaping (CreateNotificationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createNotification
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateNotificationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK: Get Extra Data
    class func getExtraData(id:String,Success: @escaping (ExtradataModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getExtraData + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(ExtradataModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    //MARK:- Update Extra Data
    class func updateExtraData(id:String,Success: @escaping (ExtradataModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateExtraData
        
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(ExtradataModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- Update event
    class func updateEvent(param:[String:Any],Success: @escaping (CreateEventModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateEvent
        
         Networkhandler.PutRequest(url: url, parameters: param,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateEventModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK: Get User
    class func getUser(id:String,Success: @escaping (LoginModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getUserbyID + id
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(LoginModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    //MARK:- Update user
    class func updateuser(companyid:String,param:[String:Any],Success: @escaping (LoginModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateUser //+ companyid
        
         Networkhandler.PutRequest(url: url, parameters: param,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(LoginModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //GetAllNotificationTypesModel
    
    //MARK: Get Notifications Type
    class func getAllNotificationTypes(Success: @escaping (GetAllNotificationTypesModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getNotificationTypes
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetAllNotificationTypesModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK: Get all users
    class func getAllusers(companyid:String,Success: @escaping (GetAllUsersListModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getAllUsersList + companyid
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetAllUsersListModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK:- Create Notification With Users List
    
    class func createNotificationWithUsers(params:[String:Any],Success: @escaping (CreateNotificationWithUsersListModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.createNotificationWithUsers
        
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(CreateNotificationWithUsersListModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK:- Delete Invitation User
    
    class func deleteInvitation(invitationid:String,Success: @escaping (InvitationUserDeleteModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.deleteInvitation + invitationid
        
        Networkhandler.DeleteRequest(url: url, parameters: nil,success: {(successResponse)   in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(InvitationUserDeleteModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK:- get All ContractLists
    
    class func getAllIncomingContractList(params:[String:Any],newurl:String,Success: @escaping (IncomingContractListModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
        var url = ""
        
            url = newurl //Constant.MainUrl + Constant.URLs.incomingContractList
       
         //url = Constant.MainUrl + Constant.URLs.contractHirotyList
        
        print("page url :", url)
         Networkhandler.PostRequest(url: url, parameters: params,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(IncomingContractListModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    
    //MARK: Get Contractor By user ID
    class func getContractorByUserIDs(userid:String,Success: @escaping (GetContractorByUserIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getContractorByUserId + userid
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetContractorByUserIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    
    //MARK: Get Contractor Employee By user ID
    class func getContractorEmployeeByUserIDs(userid:String,Success: @escaping (GetContractorEmployeeByUserIDModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getContractorEmployeeByUserID + userid
        
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetContractorEmployeeByUserIDModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK: Get Provider By user ID
    class func getProviderByUserIDs(userid:String,Success: @escaping (GetContractorByUserIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getproviderbyuserid + userid
        print("page url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(GetContractorByUserIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK: Get Provider employee By user ID
    class func getProviderEmployeeByUserIDs(userid:String,Success: @escaping (ProviderUserByIdModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.getprovideremployeebyuserid + userid
        print("page url",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(ProviderUserByIdModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK: Get Provider order record By user ID
    class func getBeforeDateProviderOrdersByUserIDs(userid:String,datevalue:String,isproviderEmployee:Bool,Success: @escaping (ProviderModels?) -> Void, Failure: @escaping(NetworkError) -> Void){
     var url = ""
        if isproviderEmployee == false {
        url = Constant.MainUrl + Constant.URLs.getorderrecordbyuserid + userid + "/by-before-date/\(datevalue)"
        } else {
            url = Constant.MainUrl + Constant.URLs.providerEmployeeOrder + userid + "/by-before-date/\(datevalue)"
        }
        print("page url : ",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in
             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(ProviderModels.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //MARK: Get Provider After Date order record By user ID
    class func getAfterDateProviderOrdersByUserIDs(userid:String,datevalue:String,isproviderEmployee:Bool,Success: @escaping (ProviderModels?) -> Void, Failure: @escaping(NetworkError) -> Void){
     var url = ""
        if isproviderEmployee == false {
        url = Constant.MainUrl + Constant.URLs.getorderrecordbyuserid + userid + "/by-after-date/\(datevalue)"
        } else {
            url = Constant.MainUrl + Constant.URLs.providerEmployeeOrder + userid + "/by-after-date/\(datevalue)"
        }
        print("page url : ",url)
         Networkhandler.GetRequiest(url: url, parameters: nil,success: {(successResponse)  in
             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(ProviderModels.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                Success(nil)
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    //Update invitation
    class func updateInvitation(id:String,option:Int,Success: @escaping (UpdateInvitationModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.updateInvitation + "\(id)/option/\(option)"
        
         Networkhandler.PutRequest(url: url, parameters: nil,success: {(successResponse)  in

             do {
                 print(successResponse)
                 let responseModel = try JSONDecoder().decode(UpdateInvitationModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
    //MARK:- token
    class func getToken(parms:[String:Any],Success: @escaping (tokenModel?) -> Void, Failure: @escaping(NetworkError) -> Void){
     let url = Constant.MainUrl + Constant.URLs.token
        print("token",url,parms)
         Networkhandler.PostRequest2(url: url, parameters: parms,success: {(successResponse)  in

             do {
                 print("token response ",successResponse)
                 let responseModel = try JSONDecoder().decode(tokenModel.self, from: successResponse.data!)
                 Success(responseModel)
             }
             catch {
                 print("Response Error")
             }


         } , Falioure: {(Error) in
             Failure(Error)
         })
     }
    
    
    
}






