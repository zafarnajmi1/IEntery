//
//  EventInvitationsModels.swift
//  iEntry
//
//  Created by ZAFAR on 04/01/2022.
//

import Foundation
struct EventInvitationsModels : Codable {
    let code : Int?
    let data : [EventInvitationsModelsData]?
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
        data = try values.decodeIfPresent([EventInvitationsModelsData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct EventInvitationsModelsData : Codable {
    let id : String?
   let manager : Manager?
    let guest : Guest?
    let event : Event?
  let zone : Zone?
    let startDate : Int?
    let guestNumber : Int?
    let attend : String?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case manager = "manager"
        case guest = "guest"
       case event = "event"
       case zone = "zone"
        case startDate = "startDate"
        case guestNumber = "guestNumber"
        case attend = "attend"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        manager = try values.decodeIfPresent(Manager.self, forKey: .manager)
       guest = try values.decodeIfPresent(Guest.self, forKey: .guest)
       event = try values.decodeIfPresent(Event.self, forKey: .event)
       zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        guestNumber = try values.decodeIfPresent(Int.self, forKey: .guestNumber)
        attend = try values.decodeIfPresent(String.self, forKey: .attend)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}

struct Event : Codable {
    let id : String?
    let status : Status?
    let name : String?
    let comment : String?
    let wasApprove : String?
    let startDate : Int?
    let endDate : Int?
    let createdAt : Int?
    let updatedAt : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case status = "status"
        case name = "name"
        case comment = "comment"
        case wasApprove = "wasApprove"
        case startDate = "startDate"
        case endDate = "endDate"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        wasApprove = try values.decodeIfPresent(String.self, forKey: .wasApprove)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}
