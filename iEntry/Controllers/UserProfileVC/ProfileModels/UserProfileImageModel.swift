////
////  UserProfileImageModel.swift
////  iEntry
////
////  Created by ZAFAR on 21/06/2022.
////
//
//import Foundation
//struct UserProfileImageModel : Codable {
//    let accessMethod : AccessMethod?
//    let createdAt : Int?
//    let deleted : Bool?
//    let description : String?
//    let driveId : String?
//    let id : String?
//    let image : String?
//    let path : String?
//    let user : User?
//
//    enum CodingKeys: String, CodingKey {
//
//        case accessMethod = "accessMethod"
//        case createdAt = "createdAt"
//        case deleted = "deleted"
//        case description = "description"
//        case driveId = "driveId"
//        case id = "id"
//        case image = "image"
//        case path = "path"
//        case user = "user"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        accessMethod = try values.decodeIfPresent(AccessMethod.self, forKey: .accessMethod)
//        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
//        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        driveId = try values.decodeIfPresent(String.self, forKey: .driveId)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        path = try values.decodeIfPresent(String.self, forKey: .path)
//        user = try values.decodeIfPresent(User.self, forKey: .user)
//    }
//
//}
