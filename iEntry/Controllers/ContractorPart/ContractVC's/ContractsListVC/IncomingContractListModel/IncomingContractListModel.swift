//
//  IncomingContractListModel.swift
//  iEntry
//
//  Created by ZAFAR on 17/02/2022.
//

import Foundation
struct IncomingContractListModel : Codable {
    let code : Int?
    let data : [IncomingContractListModelData]?
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
        data = try values.decodeIfPresent([IncomingContractListModelData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct IncomingContractListModelData : Codable {
    let id : String?
    let contractor : Contractor?
    let company : Company?
    let status : Status?
    let starDate : Int?
    let endDate : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case contractor = "contractor"
        case company = "company"
        case status = "status"
        case starDate = "starDate"
        case endDate = "endDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        contractor = try values.decodeIfPresent(Contractor.self, forKey: .contractor)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        starDate = try values.decodeIfPresent(Int.self, forKey: .starDate)
        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
    }

}

struct Contractor : Codable {
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

//struct Company : Codable {
//    let id : String?
//    let companyRestriction : String?
//    let status : Status?
//    let acronym : String?
//    let name : String?
//    let address : String?
//    let latitud : Double?
//    let longitud : Double?
//    let ip : String?
//    let createdAt : Int?
//    let updatedAt : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case companyRestriction = "companyRestriction"
//        case status = "status"
//        case acronym = "acronym"
//        case name = "name"
//        case address = "address"
//        case latitud = "latitud"
//        case longitud = "longitud"
//        case ip = "ip"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        companyRestriction = try values.decodeIfPresent(String.self, forKey: .companyRestriction)
//        status = try values.decodeIfPresent(Status.self, forKey: .status)
//        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        address = try values.decodeIfPresent(String.self, forKey: .address)
//        latitud = try values.decodeIfPresent(Double.self, forKey: .latitud)
//        longitud = try values.decodeIfPresent(Double.self, forKey: .longitud)
//        ip = try values.decodeIfPresent(String.self, forKey: .ip)
//        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
//    }
//
//}
//struct Status : Codable {
//    let id : Int?
//    let name : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//
//}
