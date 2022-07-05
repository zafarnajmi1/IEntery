//
//  ProviderModels.swift
//  iEntry
//
//  Created by ZAFAR on 08/03/2022.
//

import Foundation
struct ProviderModels : Codable {
    let code : Int?
    let data : [ProviderModelsData]?
    let success : Bool?
    let message : String?
     
    let status : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case data = "data"
        case success = "success"
        case message = "message"
         
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent([ProviderModelsData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ProviderModelsData : Codable {
    let id : String?
    let provider : Provider?
    let providerEmployee : ProviderEmployee?
    let providerVehicle : ProviderVehicle?
    let company : Company?
    let status : Status?
   //let userReceived : UserReceived?
    let deliveryDate : Int?
    let isDelivery : Bool?
    let eta : String?
    let item : String?
    let description : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case provider = "provider"
        case providerEmployee = "providerEmployee"
        case providerVehicle = "providerVehicle"
        case company = "company"
        case status = "status"
        //case userReceived = "userReceived"
        case deliveryDate = "deliveryDate"
        case isDelivery = "isDelivery"
        case eta = "eta"
        case item = "item"
        case description = "description"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        provider = try values.decodeIfPresent(Provider.self, forKey: .provider)
        providerEmployee = try values.decodeIfPresent(ProviderEmployee.self, forKey: .providerEmployee)
        providerVehicle = try values.decodeIfPresent(ProviderVehicle.self, forKey: .providerVehicle)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        //userReceived = try values.decodeIfPresent(UserReceived.self, forKey: .userReceived)
        deliveryDate = try values.decodeIfPresent(Int.self, forKey: .deliveryDate)
        isDelivery = try values.decodeIfPresent(Bool.self, forKey: .isDelivery)
        eta = try values.decodeIfPresent(String.self, forKey: .eta)
        item = try values.decodeIfPresent(String.self, forKey: .item)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }


}

struct ProviderVehicle : Codable {
    let id : String?
    let provider : Provider?
    let vehicle : Vehicle?
    let deleted : Bool?
    let deletedAt : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case provider = "provider"
        case vehicle = "vehicle"
        case deleted = "deleted"
        case deletedAt = "deletedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        provider = try values.decodeIfPresent(Provider.self, forKey: .provider)
        vehicle = try values.decodeIfPresent(Vehicle.self, forKey: .vehicle)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
    }

}



struct Provider : Codable {
    let id : String?
    let user : User?
    let status : Status?
    let acronym : String?
    let contractorCompanyName : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
        case status = "status"
        case acronym = "acronym"
        case contractorCompanyName = "contractorCompanyName"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
        contractorCompanyName = try values.decodeIfPresent(String.self, forKey: .contractorCompanyName)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}



struct UserReceived : Codable {
    let id : String?
    let status : Status?
    let userType : UserType?
    let gender : String?
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
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
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




struct ProviderEmployee : Codable {
    let id : String?
    let provider : Provider?
    let user : User?
    let status : Status?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case provider = "provider"
        case user = "user"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        provider = try values.decodeIfPresent(Provider.self, forKey: .provider)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
    }

}
