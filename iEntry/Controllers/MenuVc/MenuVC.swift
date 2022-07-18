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
        
        
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = #colorLiteral(red: 0.5144373178, green: 0.7346428037, blue: 0.7027089, alpha: 1)
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = #colorLiteral(red: 0.5144373178, green: 0.7346428037, blue: 0.7027089, alpha: 1)//UIColor.red
        }
    }
    
    
    
    
    
    //MARK:-  this funtion use  to append the array
    func menuConfig()  {
        
        if ShareData.shareInfo.userRole == .contractor || ShareData.shareInfo.userRole == .contractoremplyee{
            
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "CONTRATOS".localized, Img: UIImage(named: "ic-contract")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")?.withRenderingMode(.alwaysTemplate)))
            
            
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
            
            MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "ORDENES DE COMPRA".localized, Img: UIImage(named: "ic-contract-1")?.withRenderingMode(.alwaysTemplate)))
            MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")?.withRenderingMode(.alwaysTemplate)))
            
        } else if ShareData.shareInfo.userRole == .employees {
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 21 })) != nil {
                MenuList.append(MenuData(Titl: "NOTIFICACIONES".localized, Img: UIImage(named: "ic-bell")?.withRenderingMode(.alwaysTemplate)))
            }
            
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 1 })) != nil {
                MenuList.append(MenuData(Titl: "COMPAÑIA".localized, Img: UIImage(named: "ic-building-outline")?.withRenderingMode(.alwaysTemplate)))
            }
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 31 })) != nil {
                  
                   MenuList.append(MenuData(Titl: "EVENTOS".localized, Img: UIImage(named: "ic-event")?.withRenderingMode(.alwaysTemplate)))
            }
            
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 41 })) != nil {
                MenuList.append(MenuData(Titl: "INVITACIONES".localized, Img: UIImage(named: "ic-invitation")?.withRenderingMode(.alwaysTemplate)))
            }
            
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 11 })) != nil {
                MenuList.append(MenuData(Titl: "PERFIL".localized, Img: UIImage(named: "user-circle-solid-1")?.withRenderingMode(.alwaysTemplate)))
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
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.green
        cell?.selectedBackgroundView = bgColorView
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indx = indexPath.row
//        let selectedCell = tableView.cellForRow(at: indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor.blue
        
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

