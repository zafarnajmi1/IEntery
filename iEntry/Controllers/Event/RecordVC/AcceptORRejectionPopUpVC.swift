//
//  AcceptORRejectionPopUpVC.swift
//  iEntry
//
//  Created by ZAFAR on 18/08/2021.
//

import UIKit


class AcceptORRejectionPopUpVC: UIViewController {
    
    ////MARK:- here are iboutlet
    @IBOutlet weak var btnaccept: UIButton!
    
    @IBOutlet weak var lblcanceleventtitle: UILabel!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var mainView: UIView!
    var callBack:(()->Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.roundViewWithCustomRadius(radius: 8)
        self.navigationBarHidShow(isTrue: true)
        btnaccept.roundButtonWithCustomRadius(radius: 5)
        self.lblcanceleventtitle.text = "CANCELAR EVENTO".localized
        btncancel.setTitle("CANCELAR".localized, for: .normal)
        self.btnaccept.setTitle("ACEPTAR".localized, for: .normal)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.callBack?()
    }
    
}
extension UIWindow {
    //MARK:- this Extension make this controller as rootview
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
        }
        return nil
    }

    static func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        if let navigationController = vc as? UINavigationController,
            let visibleController = navigationController.visibleViewController  {
            return UIWindow.getVisibleViewControllerFrom( vc: visibleController )
        } else if let tabBarController = vc as? UITabBarController,
            let selectedTabController = tabBarController.selectedViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: selectedTabController )
        } else {
            if let presentedViewController = vc.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: presentedViewController)
            } else {
                return vc
            }
        }
    }
}
