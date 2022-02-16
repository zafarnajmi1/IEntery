//
//  EventModels.swift
//  iEntry
//
//  Created by ZAFAR on 04/01/2022.
//

import Foundation
struct EventModule : Codable {
    let code : Int?
    let data : [EventModuleData]?
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
        data = try values.decodeIfPresent([EventModuleData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct EventModuleData : Codable {
    let id : String?
    let user : User?
    let reservation : Reservation?
    let status : Status?
    let name : String?
    let comment : String?
    let wasApprove : Bool?
    let startDate : Int?
    let endDate : Int?
    let invitationNo : Int?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user = "user"
        case reservation = "reservation"
        case status = "status"
        case name = "name"
        case comment = "comment"
        case wasApprove = "wasApprove"
        case startDate = "startDate"
        case endDate = "endDate"
        case invitationNo = "invitationNo"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        reservation = try values.decodeIfPresent(Reservation.self, forKey: .reservation)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        wasApprove = try values.decodeIfPresent(Bool.self, forKey: .wasApprove)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
        invitationNo = try values.decodeIfPresent(Int.self, forKey: .invitationNo)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}

struct Reservation : Codable {
    let id : String?
    let zone : Zone?
    let fromDate : Int?
    let toDate : Int?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case zone = "zone"
        case fromDate = "fromDate"
        case toDate = "toDate"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
        fromDate = try values.decodeIfPresent(Int.self, forKey: .fromDate)
        toDate = try values.decodeIfPresent(Int.self, forKey: .toDate)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}
