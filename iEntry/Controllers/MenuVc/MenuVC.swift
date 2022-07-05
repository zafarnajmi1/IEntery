//
//  MenuVC.swift
//  iEntry
//
//  Created by ZAFAR on 10/08/2021.
//

import UIKit

class MenuVC: BaseController {
    //MARK:- struct use to make the list
    struct MenuData {
        var Titl:String?
        var Img:UIImage?
        var id:Int?
    }
    
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblname: UILabel!
    var MenuList = [MenuData]()
    //MARK:- here are iboutlet
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     navigationBarHidShow(isTrue: true)
        self.tblView.register(UINib.init(nibName: "menuCell", bundle: nil), forCellReuseIdentifier: "menuCell")
        self.lblname.text = ShareData.shareInfo.obj?.name
        self.lblemail.text = ShareData.shareInfo.obj?.email
        
        menuConfig()
    }
    
    //MARK:-  this funtion use  to append the array
    func menuConfig()  {
        
        if ShareData.shareInfo.userRole == .contractor || ShareData.shareInfo.userRole == .contractoremplyee{
            
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")))
            MenuList.append(MenuData(Titl: "CONTRATOS".localized, Img: UIImage(named: "ic-contract")))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")))
            
            
        }
//        else  if ShareData.shareInfo.userRole == .contractoremplyee {
//
//            MeneList.append(MenuData(Titl: "NOTIFICACIONES", Img: UIImage(named: "ic-bell")))
//            MeneList.append(MenuData(Titl: "CONTRATOS", Img: UIImage(named: "ic-contract")))
//            MeneList.append(MenuData(Titl: "PERFIL", Img: UIImage(named: "user-circle-solid-1")))
//
//
//        }
        else  if ShareData.shareInfo.userRole == .provider || ShareData.shareInfo.userRole == .provideremployee {
            
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")))
            MenuList.append(MenuData(Titl: "ORDENES DE COMPRA".localized, Img: UIImage(named: "ic-contract-1")))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")))
            
        } else if ShareData.shareInfo.userRole == .employees {
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 21 })) != nil {
                MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")))
            }
            
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 1 })) != nil {
                MenuList.append(MenuData(Titl: "COMPAÑIA".localized, Img: UIImage(named: "ic-building-outline")))
            }
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 31 })) != nil {
                  
                   MenuList.append(MenuData(Titl: "EVENTOS".localized, Img: UIImage(named: "ic-event")))
            }
            
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 41 })) != nil {
                MenuList.append(MenuData(Titl: "INVITACIONES".localized, Img: UIImage(named: "ic-invitation")))
            }
            
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 11 })) != nil {
                MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")))
            }
            
            
            
//            MeneList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")))
//            MeneList.append(MenuData(Titl: "COMPAÑIA".localized, Img: UIImage(named: "ic-building-outline")))
//            MeneList.append(MenuData(Titl: "EVENTOS".localized, Img: UIImage(named: "ic-event")))
//            MeneList.append(MenuData(Titl: "INVITACIONES".localized, Img: UIImage(named: "ic-invitation")))
        ///
        //MeneList.append(MenuData(Titl: "CONTRATISTAS", Img: UIImage(named: "ic-contract")))
        //MeneList.append(MenuData(Titl: "NOMINA", Img: UIImage(named: "ic-report")))
           
            
            // MeneList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")))
        }
    }


}
//MARK:- here are the tableview datasource and delegate
extension MenuVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? menuCell
        cell?.lbltile.text = MenuList[indexPath.row].Titl
        cell?.img.image = MenuList[indexPath.row].Img
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = indexPath.row
        
        if ShareData.shareInfo.userRole == .contractor {
            
            
            switch indx {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1 :
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ContractVC") as? ContractVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
                break
            }
            
            
            
        } else
        if ShareData.shareInfo.userRole == .contractoremplyee {
            
            
            switch indx {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1 :
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"ContractVC") as? ContractVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
                break
            }
            
            
            
        }else if ShareData.shareInfo.userRole == .provider || ShareData.shareInfo.userRole == .provideremployee {
            switch indx {
            case 0:
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1 :
                let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"OrdersVC") as? OrdersVC
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                
                let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
                break
            }
            
            
        } else if ShareData.shareInfo.userRole == .employees {
            
            let indx = MenuList[indexPath.row].Titl
            switch indx {
            case "NOTIFICACIONES".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"NotificationVC") as? NotificationVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "COMPAÑIA".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"CompanyVC") as? CompanyVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "EVENTOS".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"HomeVC") as? HomeVC
            self.navigationController?.pushViewController(vc!, animated: true)
            case "INVITACIONES".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"InvitationVC") as? InvitationVC
            self.navigationController?.pushViewController(vc!, animated: true)
        
//        case 4:
//            let storyBoard = UIStoryboard.init(name: "Contract", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier:"ContractVC") as? ContractVC
//            self.navigationController?.pushViewController(vc!, animated: true)
//        case 5:
//            let storyBoard = UIStoryboard.init(name: StoryBoards.Contract.rawValue, bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier:"PayRollVC") as? PayRollVC
//            self.navigationController?.pushViewController(vc!, animated: true)
//        print("")
            
            case "PERFIL".localized:
            let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"UserProfileVC") as? UserProfileVC
            self.navigationController?.pushViewController(vc!, animated: true)
        default:
            break
        }
            
        }
    }
    
}

