//
//  constant.swift
//  CarInsurance
//
//  Created by Apple on 7/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static var MainUrl : String { return "http://182.176.161.38:8080/corporate-user-pre-prod-v1/" //"http://182.180.148.189:8080/corporate-user-pre-prod-v1/"
    }
    
    //http://182.176.161.38:8080/corporate-user-pre-prod-v1
    
    //http://182.180.148.189:8080/corporate-user-pre-prod-v1
    struct activitySize {
        static let size =  CGSize(width: 40, height: 40)
    }
    
    enum loaderMessages : String {
        case loadingMessage = "Loading..."
    }
    
    //AuthPArt
    struct URLs {
       static let preRegister = "authentication-service/pre-register-user"
       static let Login = "authentication-service/log-in-mobile-app"
        static let checkuser = "authentication/checknewuser/"
        static let sendEmail = "authentication-service/send-email/reset-password/"
        static let updatepassword = "authentication-service/update-password-user-id/"
        
        static let generateToken = "otp/generate/"
        static let RegisterCompany = "company-service/create"
        static let Getcompany = "companies/company/get-by-id/"
        
        
        static let getuserbyemail = "user-service/get-by-email/"
        
        static let getcompanybyid = "company-service/get-by-id/"
        static let getallCompanies = "company-service/get-all"
        static let getGender = "gender-service/get-by-id/"
        static let getAllgender = "gender-service/get-all"
        static let createUserCompanyContract = "user-company-service/create-contract-employee"
        static let updateUserCompanyContract = "user-company-service/update-contract-employee"
        
        static let getcompanyRistriction = "company-service/company-restriction/get-by-company-id/"
        
        static let updateCompanyRidtriction = "company-service/company-restriction/update"
        
       static let getZonebyId = "zone-service/get-by-id/"
       static let createZone  = "zone-service/create"
       static let getAllZone = "zone-service/get-all/allowed-zones"
        
        
        
        
       static let CreateExtraDataUser = "extra-data-service/create"
       static let updateExtraDataUser = "extra-data-service/update"
       static let getSixDigitCode = "authentication-service/get-verification-code/by-user-id" ///"authentication-service/get-verification-code/by-user-id/"
        
      
       static let userContractcompanyservice = "user-company-service/get-by-user-id/"
       static  let getAllInvitationByUserID = "invitation-service/get-all/by-guest-id/"
        static let createInvitation = "invitation-service/create"
        
        static let searchUserByEmail = "user-service/get-by-email/"
        static let searchUserbyPhone = "user-service/get-by-phone-number/"
        //"user-service/user/get-by-phone-number/"
        
        static let getEventafterDate = "event-service/get-all/by-host-id/after-date" //"event-service/get-all/by-user-id/after-date"
        
         static let getBeforeDateEvent = "event-service/get-all/by-host-id/before-date" //"event-service/get-all/by-user-id/before-date"
        
        
        static let getcommenAreas = "event-service/reservation/get-all-free-common-areas-by-dates"
        
        static let getEventInvitationAfterDate = "event-service/get-all/after-date"//"event-service/get-all/by-host-id/before-date" //"event-service/get-all-invitations/by-user-id/after-date"
        
        
        static let createEvent = "event-service/create"
        static let getEventDetailById = "event-service/get-by-id/"
        static let getAllInvitationAgainstEvent = "event-service/get-all-user-invitations/by-event-id/"
        //get-all-user-invitations/by-event-id
        static let sendInvitation = "event-service/create-user-invitations"
        //create-invitations"
        
        static let cancelEvent = "event-service/cancel-event/"
        static let notification = "notification-service/get-all/by-user-id/by-company-id/after-date-created" //"notification-service/get-all/by-user-id/by-company-id/after-date-created"
        static let createNotification = "notification-service/create"
       static let getExtraData = "extra-data-service/get-by-user-id/"
       static let updateExtraData = "extra-data-service/update"
       
      static let updateEvent = "event-service/update"
        static let getUserbyID = "user-service/get-by-id/"
        static let updateUser = "user-service/update"
        ///by-company-id/"
        
        static let getNotificationTypes = "notification-service/notification-type/get-all"
        static let getAllUsersList = "user-company-service/get-all-only-user-data/by-company-id/"
        static let createNotificationWithUsers = "notification-service/user-notification/create/by-employees-ids"
        static let deleteInvitation = "event-service/delete-invitation-by-invitation-id/"
        
        static let updateInvitation = "invitation-service/validate-invitation/"
        
        
        //MARK:- Contractor Endpoints
        
        static let incomingContractList = "contract-service/contractor/get-all/incoming-active/" //"contract-service/contractor/get-all/incoming-active"
        static let contractHirotyList = "contract-service/contractor/get-all/records/"
        
        static let getContractorByUserId = "contractor-service/get-by-user-id/"
        static let getallIncomingContractorEmployee = "contract-service/contractor-employee/get-all/incoming-active"
        
        static let getallRecordContractorEmployee = "contract-service/contractor-employee/get-all/records"
        
        static let getContractorEmployeeByUserID = "contractor-employee-service/get-by-user-id/"
        
        ///contractor/get-all/incoming-active/
        //MARK:- Provider Endpoint
        
        static let getproviderbyuserid = "provider-service/get-by-user-id/"
        static let getorderrecordbyuserid = "order-service/provider/get-all/by-provider-id/"
        static let getorderbyuserid = "order-service/get-by-id/"
       static let providerEmployeeOrder = "order-service/provider-employee/get-all/by-provider-employee-id/"
        static let getprovideremployeebyuserid = "provider-employee-service/get-by-user-id/"
         static let token = "token"
        
    }
    
    
    struct NetworkErrorType {
        static let timeOutInterval: TimeInterval = 20
        
        static let error = "Error"
        static let internetNotAvailable = "Internet Not Available. Please Try Again"
        static let pleaseTryAgain = "Please Try Again"
        
        static let generic = 4000
        static let genericError = "Please Try Again."
        
        static let serverErrorCode = 5000
        static let serverNotAvailable = "Server Not Available"
        static let serverError = "Server Not Availabe, Please Try Later."
        
        static let timout = 4001
        static let timoutError = "Network Time Out, Please Try Again."
        
        static let login = 4003
        static let loginMessage = "Unable To Login"
        static let loginError = "Please Try Again."
        
        static let internet = 4004
        static let internetError = "Internet Not Available. Please Try Again"
    }
    
    struct NetworkSuccess {
        static let statusOK = 200
    }
    
}

let NOTIFICATIONS_UPDATED = "NOTIFICATIONS_UPDATED"
