//
//  CreateInvitationModel.swift
//  iEntry
//
//  Created by ZAFAR on 25/12/2021.
//

import Foundation
struct CreateInvitationModel : Codable {
    let code : Int?
    let data : CreateInvitationModelData?
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
        data = try values.decodeIfPresent(CreateInvitationModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct CreateInvitationModelData : Codable {
    let id : String?
    let manager : Manager?
    let guest : Guest?
    let event : String?
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
        event = try values.decodeIfPresent(String.self, forKey: .event)
        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        guestNumber = try values.decodeIfPresent(Int.self, forKey: .guestNumber)
        attend = try values.decodeIfPresent(String.self, forKey: .attend)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }

}
