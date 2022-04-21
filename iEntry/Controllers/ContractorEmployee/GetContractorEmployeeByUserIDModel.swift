//
//  GetContractorEmployeeByUserIDModel.swift
//  iEntry
//
//  Created by ZAFAR on 04/03/2022.
//

import Foundation
struct GetContractorEmployeeByUserIDModel : Codable {
    let code : Int?
    let data : GetContractorEmployeeByUserIDModelData?
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
        data = try values.decodeIfPresent(GetContractorEmployeeByUserIDModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct GetContractorEmployeeByUserIDModelData : Codable {
    let id : String?
    let contractor : Contractor?
    let user : User?
    let status : Status?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case contractor = "contractor"
        case user = "user"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        contractor = try values.decodeIfPresent(Contractor.self, forKey: .contractor)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
    }

}
//struct Contractor : Codable {
//    let id : String?
//    let status : Status?
//    let acronym : String?
//    let contractorCompanyName : String?
//    let createdAt : Int?
//    let updatedAt : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case status = "status"
//        case acronym = "acronym"
//        case contractorCompanyName = "contractorCompanyName"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        status = try values.decodeIfPresent(Status.self, forKey: .status)
//        acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
//        contractorCompanyName = try values.decodeIfPresent(String.self, forKey: .contractorCompanyName)
//        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
//    }
//
//}
