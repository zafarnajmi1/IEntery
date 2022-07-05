//
//  InvitationVC.swift
//  iEntry
//
//  Created by ZAFAR on 23/08/2021.
//

import UIKit
import HMSegmentedControl
class InvitationVC: UIViewController {
    //MARK:- here are iboutlet
    @IBOutlet weak var Bannerim: UIImageView!
    @IBOutlet weak var twoContainer: UIView!
    
    @IBOutlet weak var inerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var tabsView: UIView!
//    @IBOutlet weak var sigmentedController: UISegmentedControl!
    let segmentedControl = HMSegmentedControl(sectionTitles: [
        "MIS INVITACIONES".localized,
        "HISTORIAL".localized,
        
    ])
    
    
   
    
    @IBOutlet weak var oneContainer: UIView!
    @IBOutlet weak var topBannerView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 43 })) != nil  {
            
        } else {
            if let index = segmentedControl.sectionTitles?.firstIndex(of: "MIS INVITACIONES".localized) {
                segmentedControl.sectionTitles?.remove(at: index)
            }
            
        }
        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 44 })) != nil {
            
        } else {
            if let index = segmentedControl.sectionTitles?.firstIndex(of: "HISTORIAL".localized) {
                segmentedControl.sectionTitles?.remove(at: index)
            }
            
        }
        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 43 })) != nil {
            segmentedControl.selectedSegmentIndex = 0
            twoContainer.alpha = 1
            oneContainer.alpha = 0
            
        } else {
            oneContainer.alpha = 0
        }
        
        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 44 })) != nil {
            segmentedControl.selectedSegmentIndex = 1
            twoContainer.alpha = 0
            oneContainer.alpha = 1
            
        } else {
            twoContainer.alpha = 0
        }
        
        
        
        self.buttonView.roundViiew()
        self.inerView.roundViiew()
        topBannerView.shadowAndRoundcorner(cornerRadius: 8, shadowColor: #colorLiteral(red: 0.6744349003, green: 0.6745528579, blue: 0.6744274497, alpha: 1), shadowRadius: 3.0, shadowOpacity: 1.0)
        self.navigationBarHidShow(isTrue: true)
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.tabsView.frame.height)
        
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorHeight = 1.5
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name:"Montserrat-Bold", size: 13)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        self.tabsView.addSubview(segmentedControl)
        
        
        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 23 })) != nil {
            buttonView.isHidden = false 
        } else {
            buttonView.isHidden = true
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        sigmentedController.backgroundColor = .clear
//        sigmentedController.tintColor = .clear
    
        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 42 })) != nil {
            buttonView.isHidden = false
        } else {
            buttonView.isHidden = true
        }
        
        
//        segmentedControl.selectedSegmentIndex = 0
//        twoContainer.alpha = 1
//        oneContainer.alpha = 0
//        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 43 })) != nil {
//            segmentedControl.selectedSegmentIndex = 0
//            twoContainer.alpha = 1
//            oneContainer.alpha = 0
//
//        } else {
//            oneContainer.alpha = 0
//        }
//
//        if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 44 })) != nil {
//            segmentedControl.selectedSegmentIndex = 1
//            twoContainer.alpha = 0
//            oneContainer.alpha = 1
//
//        } else {
//            twoContainer.alpha = 0
//        }
        
        
//        oneView.backgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
//        twoView.backgroundColor = .clear
        
    }
    
    @IBAction func addnumberAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"InvitarVC") as? InvitarVC
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
       let manager = ZSideMenuManager(isRTL: false)
                    manager.openSideMenu(vc: self)

    }
    //MARK:- segmeneted funtion to appeare tabs
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
//            twoContainer.alpha = 1
//            oneContainer.alpha = 0
////            oneView.backgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
////            twoView.backgroundColor = .clear
//            segmentedControl.selectedSegmentIndex = 0
            
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 43 })) != nil {
                segmentedControl.selectedSegmentIndex = 0
                twoContainer.alpha = 1
                oneContainer.alpha = 0
                
            }
        case 1:
//            twoContainer.alpha = 0
//            oneContainer.alpha = 1
////            oneView.backgroundColor = .clear
////            twoView.backgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
//            segmentedControl.selectedSegmentIndex = 1
            
            if (ShareData.shareInfo.conractWithCompany?.role?.roleTasks?.first(where: { $0.task?.id == 44 })) != nil {
                segmentedControl.selectedSegmentIndex = 1
                twoContainer.alpha = 0
                oneContainer.alpha = 1
                
            }
        default:
            break
        
        }
        
        
        
    }
    
    
    @IBAction func Sigmnet(_ sender: UISegmentedControl) {
        //let indx = sigmentedController.selectedSegmentIndex
//        switch indx {
//        case 0:
//            twoContainer.alpha = 1
//            oneContainer.alpha = 0
//            oneView.backgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
//            twoView.backgroundColor = .clear
//            sigmentedController.selectedSegmentIndex = 0
//        case 1:
//            twoContainer.alpha = 0
//            oneContainer.alpha = 1
//            oneView.backgroundColor = .clear
//            twoView.backgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
//            sigmentedController.selectedSegmentIndex = 1
//        default:
//            break
//        }
    }
    
}
