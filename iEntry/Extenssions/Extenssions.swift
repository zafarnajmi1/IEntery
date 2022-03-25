//
//  Extenssions.swift
//  iEntry
//
//  Created by ZAFAR on 05/08/2021.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields
extension UIView {
    
    
    
    func roundViiew() {
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
    
    func VerificationcodeViews() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.4391649365, green: 0.4392448664, blue: 0.4391598701, alpha: 1)
    }
    func roundViewWithCustomRadius(radius:Int) {
        self.layer.cornerRadius = CGFloat(radius)
        
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
            if #available(iOS 11.0, *) {
                clipsToBounds = true
                layer.cornerRadius = radius
                layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
            } else {
                let path = UIBezierPath(
                    roundedRect: bounds,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius)
                )
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                layer.mask = mask
            }
        }
    
    
    func shadowAndRoundcorner(cornerRadius:Float,shadowColor:CGColor,shadowRadius:Float,shadowOpacity:Float) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = shadowColor
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.masksToBounds = false
    }
    
}


extension UIButton {
    func roundButton() {
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
    
    func roundButtonWithCustomRadius(radius:Int) {
        self.layer.cornerRadius = CGFloat(radius)
        
    }
}


extension UIImageView {
    func roundImageWithCustomRadius(radius:Int) {
        self.layer.cornerRadius = CGFloat(radius)
        
    }
}


extension UIViewController {
    
    func navigationBarHidShow(isTrue:Bool) {
        self.navigationController?.navigationBar.isHidden = isTrue
    }
    
    
}


extension UITextField{

    func setPlaceHolderColor(color:UIColor){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
}


extension String {
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    var isValidEmail: Bool {
            NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
        }
}

extension StringProtocol  {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}



@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

class MyMultilineTextField: MDCMultilineTextField {

    private var controller: MDCTextInputControllerOutlinedTextArea?
    private var placeholderText: String

    init(placeholder: String) {
        self.placeholderText = placeholder

        super.init(frame: .zero)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        clearButtonMode = .whileEditing

        controller = MDCTextInputControllerOutlinedTextArea(textInput: self)
        controller?.placeholderText = placeholderText
    }
    
    
    
    

}

extension UserDefaults {

   func save<T:Encodable>(customObject object: T, inKey key: String) {
       let encoder = JSONEncoder()
       if let encoded = try? encoder.encode(object) {
           self.set(encoded, forKey: key)
       }
   }

   func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
       if let data = self.data(forKey: key) {
           let decoder = JSONDecoder()
           if let object = try? decoder.decode(type, from: data) {
               return object
           }else {
               print("Couldnt decode object")
               return nil
           }
       }else {
           print("Couldnt find key")
           return nil
       }
   }

}


//extension String {
//     func getFormattedDate(string: String , formatter:String) -> String{
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = formatter//"MMM/dd//yyyy h:mm a"
//
//        let date: Date? = dateFormatterGet.date(from: string)
//        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
//        return dateFormatterPrint.string(from: date!);
//    }
//}

//extension Date {
//   func getFormattedDate(format: String) -> String {
//        let dateformat = DateFormatter()
//        dateformat.dateFormat = format
//        return dateformat.string(from: self)
//    }
//}
extension String {
    
    var localized: String {

        let path = Bundle.main.path(forResource: ShareData.shareInfo.lang, ofType: "lproj")
        let bundle = Bundle(path: path!)

        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
