//
//  CreateEventModels.swift
//  iEntry
//
//  Created by ZAFAR on 04/01/2022.
//

import Foundation
struct CommenAreasModels : Codable {
    let code : Int?
    let data : [CommenAreasModelsData]?
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
        data = try values.decodeIfPresent([CommenAreasModelsData].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

class CommenAreasModelsData : Codable {
    var zoneId : String?
    var name : String?
    var status : Status?
    var isSelected = false
    enum CodingKeys: String, CodingKey {

        case zoneId = "zoneId"
        case name = "name"
        case status = "status"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        zoneId = try values.decodeIfPresent(String.self, forKey: .zoneId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
    }

}
