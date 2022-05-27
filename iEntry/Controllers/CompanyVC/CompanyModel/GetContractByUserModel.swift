//
//  GetContractByUserModel.swift
//  iEntry
//
//  Created by ZAFAR on 22/12/2021.
//

import Foundation
struct GetContractByUserModel : Codable {
    
    
    let code : Int?
    let data : GetContractByUserModelData?
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
        data = try values.decodeIfPresent(GetContractByUserModelData.self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

    
//    let code : Int?
//    let data : GetContractByUserModelData?
//    let success : Bool?
//    let message : String?
//    let timestamp : String?
//    let status : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case code = "code"
//        case data = "data"
//        case success = "success"
//        case message = "message"
//         
//        case status = "status"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        code = try values.decodeIfPresent(Int.self, forKey: .code)
//        data = try values.decodeIfPresent(GetContractByUserModelData.self, forKey: .data)
//        success = try values.decodeIfPresent(Bool.self, forKey: .success)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
//        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//    }

}

struct GetContractByUserModelData : Codable {
    
    
    
    let id : String?
    let user : User?
    let status : Status?
    let company : Company?
    let role : Role?
    let employeeId : String?
    let zone : Zone?
    let startDate : Int?
    let endDate : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
         case user = "user"
        case status = "status"
        case company = "company"
        case role = "role"
        case employeeId = "employeeId"
        case zone = "zone"
        case startDate = "startDate"
        case endDate = "endDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        role = try values.decodeIfPresent(Role.self, forKey: .role)
        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
    }

//    let id : String?
//    let user : User?
//    let status : Status?
//    let company : Company?
//    let role : Role?
//    let employeeId : String?
//    let zone : Zone?
//    let startDate : Int?
//    let endDate : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case user = "user"
//        case status = "status"
//        case company = "company"
//        case role = "role"
//        case employeeId = "employeeId"
//        case zone = "zone"
//        case startDate = "startDate"
//        case endDate = "endDate"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        user = try values.decodeIfPresent(User.self, forKey: .user)
//        status = try values.decodeIfPresent(Status.self, forKey: .status)
//        company = try values.decodeIfPresent(Company.self, forKey: .company)
//        role = try values.decodeIfPresent(Role.self, forKey: .role)
//        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
//        zone = try values.decodeIfPresent(Zone.self, forKey: .zone)
//        startDate = try values.decodeIfPresent(Int.self, forKey: .startDate)
//        endDate = try values.decodeIfPresent(Int.self, forKey: .endDate)
//    }
}


class checkUserExistModel:NSObject, NSCoding{
    var isregister : Bool
    var name : String
    var phoneemail : String
    var guestid : String
    var registertype : Int
    init(name:String,phone:String,isregister:Bool,guestid:String,registertype:Int) {
        self.name = name
        self.phoneemail = phone
        self.isregister = isregister
        self.guestid = guestid
        self.registertype = registertype
    }
    
    required init(coder decoder: NSCoder) {
            self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.phoneemail = decoder.decodeObject(forKey: "phoneemail") as? String ?? ""
            self.isregister = decoder.decodeObject(forKey: "isregister") as? Bool ?? false
        self.guestid = decoder.decodeObject(forKey: "guestid") as? String ?? ""
        self.registertype = decoder.decodeObject(forKey: "registertype") as? Int ?? 0
        }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(phoneemail, forKey: "phoneemail")
        coder.encode(isregister,forKey: "isregister")
        coder.encode(guestid,forKey: "guestid")
        coder.encode(registertype,forKey: "registertype")
    }
}
