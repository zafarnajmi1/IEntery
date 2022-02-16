//
//  NotificationsSaveLocaly.swift
//  iEntry
//
//  Created by ZAFAR on 28/01/2022.
//

import Foundation
class CreatedNotification:NSObject, NSCoding {
    var qualification:String
    var message:String
    var notificationkind:String
    var Notificationtime:String
    var Notificationdate:String
    var notificationType:String
    var username :String
    var createdAt :String
    var type : String
    
    init(qualification:String,message:String,notificationkind:String,Notificationtime:String,Notificationdate:String,notificationType:String,username :String,createdAt:String,type:String) {
        self.qualification = qualification
        self.message = message
        self.notificationkind = notificationkind
        self.Notificationtime =  Notificationtime
        self.Notificationdate = Notificationdate
        self.notificationType = notificationType
        self.username = username
        self.createdAt = createdAt
        self.type = type
        
    }
    
    required init(coder decoder: NSCoder) {
            self.qualification = decoder.decodeObject(forKey: "qualification") as? String ?? ""
        self.message = decoder.decodeObject(forKey: "message") as? String ?? ""
            self.notificationkind = decoder.decodeObject(forKey: "notificationkind") as? String ?? ""
        self.Notificationtime = decoder.decodeObject(forKey: "Notificationtime") as? String ?? ""
        self.Notificationdate = decoder.decodeObject(forKey: "Notificationdate") as? String ?? ""
        self.notificationType = decoder.decodeObject(forKey: "notificationType") as? String ?? ""
        self.username = decoder.decodeObject(forKey: "username") as? String ?? ""
        self.createdAt = decoder.decodeObject(forKey: "createdAt") as? String ?? ""
        self.type = decoder.decodeObject(forKey: "type") as? String ?? ""
        }
    func encode(with coder: NSCoder) {
        coder.encode(qualification, forKey: "qualification")
        coder.encode(message, forKey: "message")
        coder.encode(notificationkind,forKey: "notificationkind")
        coder.encode(Notificationtime,forKey: "Notificationtime")
        
        coder.encode(Notificationdate,forKey: "Notificationdate")
        coder.encode(notificationType,forKey: "notificationType")
        coder.encode(username,forKey: "username")
        coder.encode(createdAt,forKey: "createdAt")
        coder.encode(type,forKey: "type")
        
        
    }
}
