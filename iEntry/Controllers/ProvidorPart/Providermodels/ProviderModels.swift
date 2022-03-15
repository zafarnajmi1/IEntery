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
        data = try values.decodeIfPresent([ProviderModelsData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ProviderModelsData : Codable {
    let id : String?
    let provider : Provider?
    let providerEmployee : ProviderEmployee?
    let providerVehicle : String?
    let company : Company?
    let status : Status?
    let userReceived : String?
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
        case userReceived = "userReceived"
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
        providerVehicle = try values.decodeIfPresent(String.self, forKey: .providerVehicle)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        userReceived = try values.decodeIfPresent(String.self, forKey: .userReceived)
        deliveryDate = try values.decodeIfPresent(Int.self, forKey: .deliveryDate)
        isDelivery = try values.decodeIfPresent(Bool.self, forKey: .isDelivery)
        eta = try values.decodeIfPresent(String.self, forKey: .eta)
        item = try values.decodeIfPresent(String.self, forKey: .item)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
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
