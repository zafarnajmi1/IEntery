//
//  LoginModel.swift
//  iEntry
//
//  Created by ZAFAR on 17/09/2021.
//

import Foundation
struct LoginModel : Codable {
    
    let code : Int?
    let data : LoginDataModel?
    let success : Bool?
    let message : String?
    let timestamp : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case data = "data"
        case success = "success"
        case message = "message"
        case timestamp = "timestamp"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(LoginDataModel.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct LoginDataModel : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
    let gender : Gender?
    let extraData : ExtraData?
    let userImages : [String]?
    let name : String?
    let phoneNumber : String?
    let dob : String?
    let email : String?
    let password : String?
    let deviceId : String?
    let firebaseId : String?
    let secret : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case status = "status"
        case userType = "userType"
        case gender = "gender"
        case extraData = "extraData"
        case userImages = "userImages"
        case name = "name"
        case phoneNumber = "phoneNumber"
        case dob = "dob"
        case email = "email"
        case password = "password"
        case deviceId = "deviceId"
        case firebaseId = "firebaseId"
        case secret = "secret"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        userType = try values.decodeIfPresent(UserType.self, forKey: .userType)
        gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
        extraData = try values.decodeIfPresent(ExtraData.self, forKey: .extraData)
        userImages = try values.decodeIfPresent([String].self, forKey: .userImages)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}

struct ExtraData : Codable {
    let id : String?
    let town : String?
    let country : String?
    let postalCode : String?
    let homePhone : String?
    let arabicName : String?
    let bloodType : String?
    let contractorName : String?
    let note : String?
    let wasVaccinated :Bool?
    let address1 : String?
    let address2 : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case town = "town"
        case country = "country"
        case postalCode = "postalCode"
        case homePhone = "homePhone"
        case arabicName = "arabicName"
        case bloodType = "bloodType"
        case contractorName = "contractorName"
        case note = "note"
        case wasVaccinated = "wasVaccinated"
        case address1 = "address1"
        case address2 = "address2"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        town = try values.decodeIfPresent(String.self, forKey: .town)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
        homePhone = try values.decodeIfPresent(String.self, forKey: .homePhone)
        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
        bloodType = try values.decodeIfPresent(String.self, forKey: .bloodType)
        contractorName = try values.decodeIfPresent(String.self, forKey: .contractorName)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        wasVaccinated = try values.decodeIfPresent(Bool.self, forKey: .wasVaccinated)
        address1 = try values.decodeIfPresent(String.self, forKey: .address1)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
    }

}



//MARK:- CheckUser
struct CheckUserModel : Codable {
    let code : Int?
    let data : Bool?
    let success : Bool?
    let message : String?
    let timestamp : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case data = "data"
        case success = "success"
        case message = "message"
        case timestamp = "timestamp"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(Bool.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}


struct Father : Codable {
    let id : String?
    let name : String?
    let company : Company?
    let status : Status?
    let father : String?
    let createdAt : String?
    let updatedAt : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case company = "company"
        case status = "status"
        case father = "father"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        father = try values.decodeIfPresent(String.self, forKey: .father)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}




struct Company : Codable {
    let id : String?
    let status : Status?
    let acronym : String?
    let name : String?
    let address : String?
    let latitud : Double?
    let longitud : Double?
    let ip : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case status = "status"
        case acronym = "acronym"
        case name = "name"
        case address = "address"
        case latitud = "latitud"
        case longitud = "longitud"
        case ip = "ip"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        latitud = try values.decodeIfPresent(Double.self, forKey: .latitud)
        longitud = try values.decodeIfPresent(Double.self, forKey: .longitud)
        ip = try values.decodeIfPresent(String.self, forKey: .ip)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}

struct Task : Codable {
    let id : Int?
    let name : String?
    let isMobileApp : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case isMobileApp = "isMobileApp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        isMobileApp = try values.decodeIfPresent(Bool.self, forKey: .isMobileApp)
    }

}

struct Status : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}


struct RoleTasks : Codable {
    let id : String?
    let task : Task?
    let privilege : Int?
    let createdAt : Double?
    let updatedAt : Double?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case task = "task"
        case privilege = "privilege"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        task = try values.decodeIfPresent(Task.self, forKey: .task)
        privilege = try values.decodeIfPresent(Int.self, forKey: .privilege)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
    }

}


struct Role : Codable {
    let id : String?
    let name : String?
    let roleTasks : [RoleTasks]?
    let company : Company?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case roleTasks = "roleTasks"
        case company = "company"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        roleTasks = try values.decodeIfPresent([RoleTasks].self, forKey: .roleTasks)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}

struct Zone : Codable {
    let id : String?
    let zonecommonArea :commonArea?
    let name : String?
    let company : Company?
    let status : Status?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case zonecommonArea = "commonArea"
        case name = "name"
        case company = "company"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        zonecommonArea = try values.decodeIfPresent(commonArea.self, forKey:.zonecommonArea)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }
    
    
    
}


struct commonArea:Codable {
                      
    var createdAt:Int?
    var fromTime : Int?
    var id : String?
    var toTime : Int?
    var updatedAt :Int?
    
    enum CodingKeys: String, CodingKey {

        case createdAt = "createdAt"
        case fromTime = "fromTime"
        case id = "id"
        case toTime = "toTime"
        case updatedAt = "updatedAt"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        fromTime = try values.decodeIfPresent(Int.self, forKey: .fromTime)
        toTime = try values.decodeIfPresent(Int.self, forKey: .toTime)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }
}
struct UserType : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

struct User : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
    let gender : Gender?
    let extraData : ExtraData?
    let name : String?
    let phoneNumber : String?
    let dob : String?
    let email : String?
    let deviceId : String?
    let firebaseId : String?
    let secret : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case status = "status"
        case userType = "userType"
        case gender = "gender"
        case extraData = "extraData"
        case name = "name"
        case phoneNumber = "phoneNumber"
        case dob = "dob"
        case email = "email"
        case deviceId = "deviceId"
        case firebaseId = "firebaseId"
        case secret = "secret"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        userType = try values.decodeIfPresent(UserType.self, forKey: .userType)
        gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
        extraData = try values.decodeIfPresent(ExtraData.self, forKey: .extraData)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        firebaseId = try values.decodeIfPresent(String.self, forKey: .firebaseId)
        secret = try values.decodeIfPresent(String.self, forKey: .secret)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}


struct SendEmailModel: Codable {
    let code : Int?
    let data : Bool?
    let success : Bool?
    let message : String?
    let timestamp : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case data = "data"
        case success = "success"
        case message = "message"
        case timestamp = "timestamp"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(Bool.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
