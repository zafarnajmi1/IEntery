//
//  NotificationsCell.swift
//  iEntry
//
//  Created by ZAFAR on 14/08/2021.
//

import UIKit
import SDWebImage
class NotificationsCell: UITableViewCell {
    //MARK:- here are the IBOutlet
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblmeetingDate: UILabel!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        mainView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.7293313146, green: 0.7294581532, blue: 0.7293233275, alpha: 1), shadowRadius: 4, shadowOpacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configdate(obj:CreatedNotification){
        self.lbltitle.text = obj.notificationType
        self.lbldetail.text = obj.message
        self.lbldate.text =  getFormattedMilisecondstoDate(seconds:"\(obj.createdAt)", formatter: "")
        
        if obj.Notificationdate == "0" {
            self.lblmeetingDate.isHidden = true
        } else {
            self.lblmeetingDate.isHidden = false
        self.lblmeetingDate.text = "Date Meeting :" + getFormattedMilisecondstoDate(seconds:"\(obj.Notificationdate)", formatter: "")
        }
        self.lblusername.text = obj.username
        if obj.type == "2" {
            img.image = UIImage(named: "ic-meeting")
        } else if obj.type == "3" {
            img.image = UIImage(named: "renew")
        } else if obj.type == "4" {
            img.image = UIImage(named: "ic-coin")
            self.lbltitle.text = obj.notificationkind
        }
        
        mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        if obj.notificationType == "" {
//            img.image = UIImage(named: "ic-coin")
//            mainView.backgroundColor = #colorLiteral(red: 0.9994603992, green: 0.8503835797, blue: 0.8489696383, alpha: 1)
//        } else {
//
//        }
    }
    
    
    func getFormattedMilisecondstoDate(seconds: String , formatter:String) -> String{
//    let milisecond = seconds
//        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond)!/1000)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
//        let newdate = dateFormatter.string(from: dateVar)
//        print(dateFormatter.string(from: dateVar))
//        return newdate
        let epocTime = TimeInterval(Int(seconds) ?? 0)

        let myDate = Date(timeIntervalSince1970: epocTime / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateFormatter.string(from: myDate)
        return dateString
    }
}
