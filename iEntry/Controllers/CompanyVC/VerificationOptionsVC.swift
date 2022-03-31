//
//  VerificationOptionsVC.swift
//  iEntry
//
//  Created by ZAFAR on 14/09/2021.
//

import UIKit
import HMSegmentedControl
class VerificationOptionsVC: UIViewController {
    //MARK:- here are iboutlet
    @IBOutlet weak var lbloptionsTitle: UILabel!
    @IBOutlet weak var oneContainer: UIView!
    @IBOutlet weak var twoContainer: UIView!
    
    @IBOutlet weak var tabsView: UIView!
//    @IBOutlet weak var sigmentedController: UISegmentedControl!
    let segmentedControl = HMSegmentedControl(sectionTitles: [
        "CÓDIGO QR".localized,
        "TOKEN".localized,
        
    ])
    
    //MARK:- here are tabs intializing
    
    lazy var tokenViewcontroller : CompanyVerificationCodeVC  = {
        let storyboard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier:"CompanyVerificationCodeVC") as? CompanyVerificationCodeVC
        self.addchilfViewController(childvc: vc!)
        return vc!
    }()
    
    lazy var compnyqrcodeVC : QRCodeVC  = {
        let storyboard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier:"QRCodeVC") as? QRCodeVC
        self.addchilfViewController(childvc: vc!)
        return vc!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbloptionsTitle.text = "O P C I O N E S".localized
        self.navigationBarHidShow(isTrue: true)
        
        
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.tabsView.frame.height)
        
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorHeight = 1.5
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name:"Montserrat-Bold", size: 13)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        self.tabsView.addSubview(segmentedControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        sigmentedController.backgroundColor = .clear
//        sigmentedController.tintColor = .clear
    
        
//        segmentedControl.selectedSegmentIndex = 0
//        twoContainer.alpha = 1
//        oneContainer.alpha = 0
//        oneView.backgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
//        twoView.backgroundColor = .clear
       
    }
    
    
    //MARK:- this funtion use to change the tabs
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            twoContainer.alpha = 1
            oneContainer.alpha = 0
//            oneView.backgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
//            twoView.backgroundColor = .clear
            segmentedControl.selectedSegmentIndex = 0
            
          
        case 1:
            twoContainer.alpha = 0
            oneContainer.alpha = 1
//            oneView.backgroundColor = .clear
//            twoView.backgroundColor = #colorLiteral(red: 0.07949455827, green: 0.4369635582, blue: 0.3846057653, alpha: 1)
            segmentedControl.selectedSegmentIndex = 1
            
        default:
            break
        
        }}
    
    func addchilfViewController(childvc:UIViewController){
        addChild(childvc)
        view.addSubview(childvc.view)
        childvc.view.frame = view.bounds
        childvc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childvc.didMove(toParent: self)
        
    }
    
    func removeController(childVC:UIViewController) {
        
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    

}
