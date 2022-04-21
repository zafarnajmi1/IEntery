//
//  Networkhandler.swift
//  CarInsurance
//
//  Created by Apple on 7/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

import Alamofire

class Networkhandler{
    
    func dictoJson(dic:[String: String]) ->String {
        var json = ""
        let encoder = JSONEncoder()
                if let jsonData = try? encoder.encode(dic) {
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        json = jsonString
                        print("Nice Json", jsonString)
                    }
                }
        return json
    }
class func PostRequest(url: String, parameters: Parameters?, success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
    {
//        let cookieStore = HTTPCookieStorage.shared
//        for cookie in cookieStore.cookies ?? [] {
//            cookieStore.deleteCookie(cookie)
//        }
//        let Manger = Alamofire.Session.default
//       var Headers : HTTPHeaders
//
//
//        if let userToken = ShareData.shareInfo.token {
//            Headers = [
//                "Accept": "application/json",
//                "Token"  : userToken ,
//                "Content-Type" : "application/json"//"Authorization"
//            ]
//        } else {
//            Headers = [
//                "Accept": "application/json",
//                "Content-Type" : "application/json"
//
//                //"application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type"
//            ]
//
//    }
    
    
    let data = try! JSONSerialization.data(withJSONObject: parameters ?? [:], options: JSONSerialization.WritingOptions.prettyPrinted)

        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            print(json)
        }

        let jsonData = json!.data(using: String.Encoding.utf8.rawValue);
          print(jsonData)
           let newurl = URL(string: url)!
            var request = URLRequest(url: newurl)
           request.httpMethod = HTTPMethod.post.rawValue
           request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let bearer = "Bearer "
        let newtoken = ShareData.shareInfo.token ?? ""
        let  token = bearer + newtoken
        request.setValue("\( token )",forHTTPHeaderField: "Authorization")
           request.httpBody = jsonData
          
//               var request = URLRequest(url:  URL(string: url)!)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        //request.setValue("bearer e2ff3aa3-63a3-41d1-bc5a3e8c88adeaaa",forHTTPHeaderField: "Authorization")
//        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//                request.httpBody = jsonData

    AF.request(request).responseJSON { (response) in

         switch(response.result){
                case .success:
                    let ModelRespons = response.result
                    print("api response",ModelRespons)
                    success(response)
    
    
                    break
                case .failure (let error):
    
                    var networkError = NetworkError()
    
                    if error._code == NSURLErrorTimedOut {
                        networkError.status = Constant.NetworkErrorType.timout
                        networkError.message = Constant.NetworkErrorType.timoutError
    
                        Falioure(networkError)
                    } else if error._code == NSURLErrorNetworkConnectionLost{
                        networkError.status = Constant.NetworkErrorType.internet
                        networkError.message = Constant.NetworkErrorType.internetError
    
                        Falioure(networkError)
                    }else if error._code == NSURLErrorNotConnectedToInternet{
                        networkError.status = Constant.NetworkErrorType.internet
                        networkError.message = Constant.NetworkErrorType.internetError
    
                        Falioure(networkError)
                    }else if error._code == NSURLErrorCannotConnectToHost {
                        networkError.status = Constant.NetworkErrorType.serverErrorCode
                        networkError.message = Constant.NetworkErrorType.serverError
    
                        Falioure(networkError)
                    }else if error._code == NSURLErrorSecureConnectionFailed{
                        networkError.status = Constant.NetworkErrorType.serverErrorCode
                        networkError.message = Constant.NetworkErrorType.serverError
    
                        Falioure(networkError)
    
                    }else{
    
                        networkError.status = Constant.NetworkErrorType.generic
                        networkError.message = Constant.NetworkErrorType.genericError
    
                        Falioure(networkError)
                    }
                    break
                }


                    }
                    
    
    
    
    
    
//
//        Manger.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Headers).validate(statusCode: 200..<600).responseJSON{ (response)-> Void in
//
//            switch(response.result)
//            {
//            case .success:
//                let ModelRespons = response.result
//                print("api response",ModelRespons)
//                success(response)
//
//
//                break
//            case .failure (let error):
//
//                var networkError = NetworkError()
//
//                if error._code == NSURLErrorTimedOut {
//                    networkError.status = Constant.NetworkErrorType.timout
//                    networkError.message = Constant.NetworkErrorType.timoutError
//
//                    Falioure(networkError)
//                } else if error._code == NSURLErrorNetworkConnectionLost{
//                    networkError.status = Constant.NetworkErrorType.internet
//                    networkError.message = Constant.NetworkErrorType.internetError
//
//                    Falioure(networkError)
//                }else if error._code == NSURLErrorNotConnectedToInternet{
//                    networkError.status = Constant.NetworkErrorType.internet
//                    networkError.message = Constant.NetworkErrorType.internetError
//
//                    Falioure(networkError)
//                }else if error._code == NSURLErrorCannotConnectToHost {
//                    networkError.status = Constant.NetworkErrorType.serverErrorCode
//                    networkError.message = Constant.NetworkErrorType.serverError
//
//                    Falioure(networkError)
//                }else if error._code == NSURLErrorSecureConnectionFailed{
//                    networkError.status = Constant.NetworkErrorType.serverErrorCode
//                    networkError.message = Constant.NetworkErrorType.serverError
//
//                    Falioure(networkError)
//
//                }else{
//
//                    networkError.status = Constant.NetworkErrorType.generic
//                    networkError.message = Constant.NetworkErrorType.genericError
//
//                    Falioure(networkError)
//                }
//                break
//            }
            
            
        }
        
        
    class func PostRequest2(url: String, parameters: Parameters?, success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
        {
            let cookieStore = HTTPCookieStorage.shared
            for cookie in cookieStore.cookies ?? [] {
                cookieStore.deleteCookie(cookie)
            }
            let Manger = Alamofire.Session.default
           var Headers : HTTPHeaders
           
            
            if let userToken = ShareData.shareInfo.token {
                Headers = [
                    "Accept": "application/json",
                    "Authorization" : "Bearer " +  userToken,
                    "Content-Type" : "application/json",//"Authorization"
                    "Accept": "application/json",
                    "Content-type": "multipart/form-data",
                    "Content-Type" :"application/x-www-form-urlencoded"
                ]
            } else {
                Headers = [
                    "Accept": "application/json",
                    "Content-Type" : "application/json",
                    "Content-Type": "application/json",
                       "Accept": "application/json",
                       "Content-type": "multipart/form-data",
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "Content-type": "multipart/form-data",
                    "Content-Type" :"application/x-www-form-urlencoded"
                    //"application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type"
                ]

        }
        
            Manger.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Headers).validate(statusCode: 200..<600).responseJSON{ (response)-> Void in
    
                switch(response.result)
                {
                case .success:
                    let ModelRespons = response.result
                    print("api response",ModelRespons)
                    success(response)
    
    
                    break
                case .failure (let error):
    
                    var networkError = NetworkError()
    
                    if error._code == NSURLErrorTimedOut {
                        networkError.status = Constant.NetworkErrorType.timout
                        networkError.message = Constant.NetworkErrorType.timoutError
    
                        Falioure(networkError)
                    } else if error._code == NSURLErrorNetworkConnectionLost{
                        networkError.status = Constant.NetworkErrorType.internet
                        networkError.message = Constant.NetworkErrorType.internetError
    
                        Falioure(networkError)
                    }else if error._code == NSURLErrorNotConnectedToInternet{
                        networkError.status = Constant.NetworkErrorType.internet
                        networkError.message = Constant.NetworkErrorType.internetError
    
                        Falioure(networkError)
                    }else if error._code == NSURLErrorCannotConnectToHost {
                        networkError.status = Constant.NetworkErrorType.serverErrorCode
                        networkError.message = Constant.NetworkErrorType.serverError
    
                        Falioure(networkError)
                    }else if error._code == NSURLErrorSecureConnectionFailed{
                        networkError.status = Constant.NetworkErrorType.serverErrorCode
                        networkError.message = Constant.NetworkErrorType.serverError
    
                        Falioure(networkError)
    
                    }else{
    
                        networkError.status = Constant.NetworkErrorType.generic
                        networkError.message = Constant.NetworkErrorType.genericError
    
                        Falioure(networkError)
                    }
                    break
                }
                
                
            }
    }
    
    
    
    class func PutRequest(url: String, parameters: Parameters?, success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
        {

        let data = try! JSONSerialization.data(withJSONObject: parameters ?? [:], options: JSONSerialization.WritingOptions.prettyPrinted)

            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                print(json)
            }

            let jsonData = json!.data(using: String.Encoding.utf8.rawValue);
              print(jsonData)
               let newurl = URL(string: url)!
                var request = URLRequest(url: newurl)
               request.httpMethod = HTTPMethod.put.rawValue
               request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            let bearer = "Bearer "
            let newtoken = ShareData.shareInfo.token ?? ""
            let  token = bearer + newtoken
               request.setValue("\(token)",forHTTPHeaderField: "Authorization")
               request.httpBody = jsonData
        
        
        AF.request(request).responseJSON { (response) in

             switch(response.result){
                    case .success:
                        let ModelRespons = response.result
                        print("api response",ModelRespons)
                        success(response)
        
        
                        break
                    case .failure (let error):
        
                        var networkError = NetworkError()
        
                        if error._code == NSURLErrorTimedOut {
                            networkError.status = Constant.NetworkErrorType.timout
                            networkError.message = Constant.NetworkErrorType.timoutError
        
                            Falioure(networkError)
                        } else if error._code == NSURLErrorNetworkConnectionLost{
                            networkError.status = Constant.NetworkErrorType.internet
                            networkError.message = Constant.NetworkErrorType.internetError
        
                            Falioure(networkError)
                        }else if error._code == NSURLErrorNotConnectedToInternet{
                            networkError.status = Constant.NetworkErrorType.internet
                            networkError.message = Constant.NetworkErrorType.internetError
        
                            Falioure(networkError)
                        }else if error._code == NSURLErrorCannotConnectToHost {
                            networkError.status = Constant.NetworkErrorType.serverErrorCode
                            networkError.message = Constant.NetworkErrorType.serverError
        
                            Falioure(networkError)
                        }else if error._code == NSURLErrorSecureConnectionFailed{
                            networkError.status = Constant.NetworkErrorType.serverErrorCode
                            networkError.message = Constant.NetworkErrorType.serverError
        
                            Falioure(networkError)
        
                        }else{
        
                            networkError.status = Constant.NetworkErrorType.generic
                            networkError.message = Constant.NetworkErrorType.genericError
        
                            Falioure(networkError)
                        }
                        break
                    }


                        }
    }
    
    
    
    
    class func GetRequiest(url: String, parameters: Parameters?, success: @escaping (AFDataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)   {
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        let Manger = Alamofire.Session.default
        //UserDefaults.standard.value(forKey: "userAuthToken") as? String
        let  Headers : HTTPHeaders
        if let userToken = ShareData.shareInfo.token  {
            Headers = [
                "Accept": "application/json",
                "Authorization" : "Bearer " +  userToken,
            ]
        } else {
            Headers = [
                "Accept": "application/json",
                "Content-Type": "application/json",
               "Accept": "application/json",
               "Content-type": "multipart/form-data"
            ]
        }
        print(Headers)
        
        Manger.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Headers).validate(statusCode: 200..<600).responseJSON(completionHandler:{(response) -> Void in
            
            switch(response.result)
            {
                
            case .success:
                let RespomseModel = response.result
                print(RespomseModel)
                success(response)
            case .failure (let error):
                
                
                var networkError = NetworkError()
                
                if error._code == NSURLErrorTimedOut {
                    networkError.status = Constant.NetworkErrorType.timout
                    networkError.message = Constant.NetworkErrorType.timoutError
                    
                    Falioure(networkError)
                } else if error._code == NSURLErrorNetworkConnectionLost {
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorNotConnectedToInternet{
                    networkError.status = Constant.NetworkErrorType.internet
                    networkError.message = Constant.NetworkErrorType.internetError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorCannotConnectToHost {
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                }else if error._code == NSURLErrorSecureConnectionFailed{
                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                    networkError.message = Constant.NetworkErrorType.serverError
                    
                    Falioure(networkError)
                    
                }else{
                    
                    networkError.status = Constant.NetworkErrorType.generic
                    networkError.message = Constant.NetworkErrorType.genericError
                    
                    Falioure(networkError)
                }
                break
            }
            
        } )
        
    }
    

    class func DeleteRequest(url: String, parameters: Parameters?, success:@escaping (AFDataResponse<Any>)->Void ,Falioure: @escaping (NetworkError) -> Void )
        {
            let cookieStore = HTTPCookieStorage.shared
            for cookie in cookieStore.cookies ?? [] {
                cookieStore.deleteCookie(cookie)
            }
            let Manger = Alamofire.Session.default
            var Headers : HTTPHeaders
           
            
            if let userToken = ShareData.shareInfo.token {
                Headers = [
                    "Accept": "application/json",
                    "Authorization"  : "Bearer " + userToken   //"Authorization"
                ]
            } else {
                Headers = [
                    "Accept": "application/json"
                ]
            
        }
            
            Manger.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: Headers).validate(statusCode: 200..<600).responseJSON{ (response)-> Void in
                
                switch(response.result)
                {
                case .success:
                    let ModelRespons = response.result
                    print("api response",ModelRespons)
                    success(response)
                    
                    print(response.response?.statusCode)
                    break
                case .failure (let error):
                    
                    var networkError = NetworkError()
                    
                    if error._code == NSURLErrorTimedOut {
                        networkError.status = Constant.NetworkErrorType.timout
                        networkError.message = Constant.NetworkErrorType.timoutError
                        
                        Falioure(networkError)
                    } else if error._code == NSURLErrorNetworkConnectionLost{
                        networkError.status = Constant.NetworkErrorType.internet
                        networkError.message = Constant.NetworkErrorType.internetError
                        
                        Falioure(networkError)
                    }else if error._code == NSURLErrorNotConnectedToInternet{
                        networkError.status = Constant.NetworkErrorType.internet
                        networkError.message = Constant.NetworkErrorType.internetError
                        
                        Falioure(networkError)
                    }else if error._code == NSURLErrorCannotConnectToHost {
                        networkError.status = Constant.NetworkErrorType.serverErrorCode
                        networkError.message = Constant.NetworkErrorType.serverError
                        
                        Falioure(networkError)
                    }else if error._code == NSURLErrorSecureConnectionFailed{
                        networkError.status = Constant.NetworkErrorType.serverErrorCode
                        networkError.message = Constant.NetworkErrorType.serverError
                        
                        Falioure(networkError)
                        
                    }else{
                        
                        networkError.status = Constant.NetworkErrorType.generic
                        networkError.message = Constant.NetworkErrorType.genericError
                        
                        Falioure(networkError)
                    }
                    break
                }
                
                
            }
            
            
        }
    
    
    
    

        
            class func Multipart(url: String,filename:String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (AFDataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)
                    {
                        let cookieStore = HTTPCookieStorage.shared
                        for cookie in cookieStore.cookies ?? [] {
                            cookieStore.deleteCookie(cookie)
                        }
                        print(url)
                        print(filename)
                        print(userimg)
                        
                        var Headers : HTTPHeaders
                        let Manger = Alamofire.Session.default
                        if let userToken = ShareData.shareInfo.token {
                            Headers = [
                                "Accept": "application/json",
                                "Authorization" : "Bearer " +  userToken,
                                "Content-type": "multipart/form-data"
                            ]
                        }else
                        {
                            Headers = ["Accept": "application/json"]
                        }

                       
                        let fileName = filename//"image"
                        Manger.upload(multipartFormData: {(multipart) in

                            if let data = userimg.jpegData(compressionQuality: 0.1)
                            {
                                print(data)
                                multipart.append(data, withName: fileName, fileName: filename, mimeType: "any")
                            }
        //                    for(key, values ) in parameters!
        //                    {
        //                        multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
        //                        print(values)
        //                        print(values)
        //                    }
                        }, to: url, method: .post, headers: Headers) .responseJSON(completionHandler: { result in

                            switch(result.result)
                            {

                                    case .success:
                                        let resultValue = result.result
                                        print(resultValue)
                                        
                                        Success(result)
                                        break

                                    case .failure (let error):


                                        var networkError = NetworkError()

                                        if error._code == NSURLErrorTimedOut {
                                            networkError.status = Constant.NetworkErrorType.timout
                                            networkError.message = Constant.NetworkErrorType.timoutError

                                            Falioure(networkError)
                                        } else if error._code == NSURLErrorNetworkConnectionLost {
                                            networkError.status = Constant.NetworkErrorType.internet
                                            networkError.message = Constant.NetworkErrorType.internetError

                                            Falioure(networkError)
                                        }else if error._code == NSURLErrorNotConnectedToInternet{
                                            networkError.status = Constant.NetworkErrorType.internet
                                            networkError.message = Constant.NetworkErrorType.internetError

                                            Falioure(networkError)
                                        }else if error._code == NSURLErrorCannotConnectToHost {
                                            networkError.status = Constant.NetworkErrorType.serverErrorCode
                                            networkError.message = Constant.NetworkErrorType.serverError

                                            Falioure(networkError)
                                        }else if error._code == NSURLErrorSecureConnectionFailed{
                                            networkError.status = Constant.NetworkErrorType.serverErrorCode
                                            networkError.message = Constant.NetworkErrorType.serverError

                                            Falioure(networkError)

                                        }else{

                                            networkError.status = Constant.NetworkErrorType.generic
                                            networkError.message = Constant.NetworkErrorType.genericError

                                            Falioure(networkError)
                                        }
                                        break

                                    }

                                })

                           

                        }
            
            

                    class func MultipartGet(url: String,filename:String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (AFDataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)
                            {
                                let cookieStore = HTTPCookieStorage.shared
                                for cookie in cookieStore.cookies ?? [] {
                                    cookieStore.deleteCookie(cookie)
                                }
                                print(url)
                                print(filename)
                                print(userimg)
                                
                                var Headers : HTTPHeaders
                                let Manger = Alamofire.Session.default
                                if let userToken = ShareData.shareInfo.token {
                                    Headers = [
                                        "Accept": "application/json",
                                        "Authorization" : "Bearer " +  userToken,
                                        "Content-type": "multipart/form-data"
                                    ]
                                }else
                                {
                                    Headers = ["Accept": "application/json"]
                                }

                               
                                let fileName = filename//"image"
                                Manger.upload(multipartFormData: {(multipart) in

                                    if let data = userimg.jpegData(compressionQuality: 0.1)
                                    {
                                        print(data)
                                        multipart.append(data, withName: fileName, fileName: filename, mimeType: "any")
                                    }
                //                    for(key, values ) in parameters!
                //                    {
                //                        multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
                //                        print(values)
                //                        print(values)
                //                    }
                                }, to: url, method: .get, headers: Headers) .responseJSON(completionHandler: { result in

                                    switch(result.result)
                                    {

                                            case .success:
                                                let resultValue = result.result
                                                print(resultValue)
                                                
                                                Success(result)
                                                break

                                            case .failure (let error):


                                                var networkError = NetworkError()

                                                if error._code == NSURLErrorTimedOut {
                                                    networkError.status = Constant.NetworkErrorType.timout
                                                    networkError.message = Constant.NetworkErrorType.timoutError

                                                    Falioure(networkError)
                                                } else if error._code == NSURLErrorNetworkConnectionLost {
                                                    networkError.status = Constant.NetworkErrorType.internet
                                                    networkError.message = Constant.NetworkErrorType.internetError

                                                    Falioure(networkError)
                                                }else if error._code == NSURLErrorNotConnectedToInternet{
                                                    networkError.status = Constant.NetworkErrorType.internet
                                                    networkError.message = Constant.NetworkErrorType.internetError

                                                    Falioure(networkError)
                                                }else if error._code == NSURLErrorCannotConnectToHost {
                                                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                                                    networkError.message = Constant.NetworkErrorType.serverError

                                                    Falioure(networkError)
                                                }else if error._code == NSURLErrorSecureConnectionFailed{
                                                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                                                    networkError.message = Constant.NetworkErrorType.serverError

                                                    Falioure(networkError)

                                                }else{

                                                    networkError.status = Constant.NetworkErrorType.generic
                                                    networkError.message = Constant.NetworkErrorType.genericError

                                                    Falioure(networkError)
                                                }
                                                break

                                            }

                                        })

                                   

                                }
    
    class func UploadProfile(url: String,filename:String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (AFDataResponse<Any>, Int)->Void, Falioure: @escaping (NetworkError) -> Void)
            {
                let cookieStore = HTTPCookieStorage.shared
                for cookie in cookieStore.cookies ?? [] {
                    cookieStore.deleteCookie(cookie)
                }
                print(url)
                print(filename)
                print(userimg)
                
                var Headers : HTTPHeaders
                let Manger = Alamofire.Session.default
                if let userToken = ShareData.shareInfo.token {
                    Headers = [
                        "Accept": "application/json",
                        "Authorization" : "Bearer " +  userToken,
                        "Content-type": "multipart/form-data"
                    ]
                }else
                {
                    Headers = ["Accept": "application/json"]
                }

               
                let fileName = filename//"image"
                Manger.upload(multipartFormData: {(multipart) in

                    if let data = userimg.jpegData(compressionQuality: 0.1)
                    {
                        print(data)
                        multipart.append(data, withName: fileName, fileName: filename, mimeType: "any")
                    }
//                    for(key, values ) in parameters!
//                    {
//                        multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
//                        print(values)
//                        print(values)
//                    }
                }, to: url, method: .post, headers: Headers) .responseJSON(completionHandler: { result in

                    switch(result.result)
                    {

                            case .success:
                                let resultValue = result.result
                                print(resultValue)
                                
                                Success(result,result.response!.statusCode )
                                break

                            case .failure (let error):


                                var networkError = NetworkError()

                                if error._code == NSURLErrorTimedOut {
                                    networkError.status = Constant.NetworkErrorType.timout
                                    networkError.message = Constant.NetworkErrorType.timoutError

                                    Falioure(networkError)
                                } else if error._code == NSURLErrorNetworkConnectionLost {
                                    networkError.status = Constant.NetworkErrorType.internet
                                    networkError.message = Constant.NetworkErrorType.internetError

                                    Falioure(networkError)
                                }else if error._code == NSURLErrorNotConnectedToInternet{
                                    networkError.status = Constant.NetworkErrorType.internet
                                    networkError.message = Constant.NetworkErrorType.internetError

                                    Falioure(networkError)
                                }else if error._code == NSURLErrorCannotConnectToHost {
                                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                                    networkError.message = Constant.NetworkErrorType.serverError

                                    Falioure(networkError)
                                }else if error._code == NSURLErrorSecureConnectionFailed{
                                    networkError.status = Constant.NetworkErrorType.serverErrorCode
                                    networkError.message = Constant.NetworkErrorType.serverError

                                    Falioure(networkError)

                                }else{

                                    networkError.status = Constant.NetworkErrorType.generic
                                    networkError.message = Constant.NetworkErrorType.genericError

                                    Falioure(networkError)
                                }
                                break

                            }

                        })

                   

                }
    
    
    
    
    
    
    
//    class func UploadData(url: String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (AFDataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)
//    {
//        var Headers : HTTPHeaders
//        let Manger = Alamofire.Session.default
////        if let userToken = ShareData.shareInfo.userInfo?.collection?.authorization {
////            Headers = [
////                "Accept": "application/json",
////                "Authorization" : userToken,
////                "Content-type": "multipart/form-data"
////            ]
////        }else
////        {
//            Headers = ["Accept": "application/json"]
//        //}
//
//        let type = "any"
//        let fileName = "image"
//
//        Manger.upload(multipartFormData: {(multipart) in
//
//            if let data = userimg.jpegData(compressionQuality: 0.1)
//            {
//                print(data)
//                multipart.append(data, withName: "image", fileName: fileName, mimeType: type)
//            }
//            for(key, values ) in parameters!
//            {
//                multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
//                print(values)
//                print(values)
//            }
//
//        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: Headers, encodingCompletion:{(result) in
//            switch(result)
//            {
//            case .success(let request,_,_):
//                request.uploadProgress(closure: { (prgrs) in
//
//                    let progress = Int(prgrs.fractionCompleted * 100)
//                    print(progress)
//                    Progress(progress)
//                })
//                request.responseJSON(completionHandler: {(successresponse)in
//
//                    switch(successresponse.result)
//                    {
//                    case .success:
//                        let resultValue = successresponse.result.value
//                        print(resultValue!)
//                        Success(successresponse)
//                        break
//
//                    case .failure (let error):
//
//
//                        var networkError = NetworkError()
//
//                        if error._code == NSURLErrorTimedOut {
//                            networkError.status = Constant.NetworkErrorType.timout
//                            networkError.message = Constant.NetworkErrorType.timoutError
//
//                            Falioure(networkError)
//                        } else if error._code == NSURLErrorNetworkConnectionLost {
//                            networkError.status = Constant.NetworkErrorType.internet
//                            networkError.message = Constant.NetworkErrorType.internetError
//
//                            Falioure(networkError)
//                        }else if error._code == NSURLErrorNotConnectedToInternet{
//                            networkError.status = Constant.NetworkErrorType.internet
//                            networkError.message = Constant.NetworkErrorType.internetError
//
//                            Falioure(networkError)
//                        }else if error._code == NSURLErrorCannotConnectToHost {
//                            networkError.status = Constant.NetworkErrorType.serverErrorCode
//                            networkError.message = Constant.NetworkErrorType.serverError
//
//                            Falioure(networkError)
//                        }else if error._code == NSURLErrorSecureConnectionFailed{
//                            networkError.status = Constant.NetworkErrorType.serverErrorCode
//                            networkError.message = Constant.NetworkErrorType.serverError
//
//                            Falioure(networkError)
//
//                        }else{
//
//                            networkError.status = Constant.NetworkErrorType.generic
//                            networkError.message = Constant.NetworkErrorType.genericError
//
//                            Falioure(networkError)
//                        }
//                        break
//
//                    }
//
//                })
//            case .failure(let error):
//                Falioure(error as! NetworkError)
//            }
//
//        })
//
//
//    }
    
   
    
    
    
    
//    class func UploadImage(url: String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (DataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)
//    {
//        var Headers : HTTPHeaders
//        let Manger = Alamofire.SessionManager.default
//        //print(UserDefaults.standard.value(forKey: "userAuthToken")!)
//        if let userToken = ShareData.shareInfo.userInfo?.collection?.authorization {
//            Headers = [
//                "Accept": "application/json",
//                "authorization" : userToken
//                //"Content-type": "multipart/form-data"
//            ]
//        }else
//        {
//            Headers = ["Accept": "application/json"]
//        }
//
//        let type = "any"
//        let fileName = "image"
//
//        Manger.upload(multipartFormData: {(multipart) in
//
//            if let data = userimg.jpegData(compressionQuality: 0.6)
//            {
//                print(data)
//                multipart.append(data, withName: fileName, fileName: fileName, mimeType: type)
//            }
//            //            for(key, values ) in parameters!
//            //            {
//            //                multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
//            //                print(values)
//            //                print(values)
//            //            }
//
//        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: nil, encodingCompletion:{(result) in
//            switch(result)
//            {
//            case .success(let request,_,_):
//                request.uploadProgress(closure: { (prgrs) in
//
//                    let progress = Int(prgrs.fractionCompleted * 100)
//                    print(progress)
//                    Progress(progress)
//                })
//                request.responseJSON(completionHandler: {(successresponse)in
//
//                    switch(successresponse.result)
//                    {
//                    case .success:
//                        let resultValue = successresponse.result.value
//                        print(resultValue!)
//                        Success(successresponse)
//                        break
//
//                    case .failure (let error):
//
//
//                        var networkError = NetworkError()
//
//                        if error._code == NSURLErrorTimedOut {
//                            networkError.status = Constant.NetworkErrorType.timout
//                            networkError.message = Constant.NetworkErrorType.timoutError
//
//                            Falioure(networkError)
//                        } else if error._code == NSURLErrorNetworkConnectionLost {
//                            networkError.status = Constant.NetworkErrorType.internet
//                            networkError.message = Constant.NetworkErrorType.internetError
//
//                            Falioure(networkError)
//                        }else if error._code == NSURLErrorNotConnectedToInternet{
//                            networkError.status = Constant.NetworkErrorType.internet
//                            networkError.message = Constant.NetworkErrorType.internetError
//
//                            Falioure(networkError)
//                        }else if error._code == NSURLErrorCannotConnectToHost {
//                            networkError.status = Constant.NetworkErrorType.serverErrorCode
//                            networkError.message = Constant.NetworkErrorType.serverError
//
//                            Falioure(networkError)
//                        }else if error._code == NSURLErrorSecureConnectionFailed{
//                            networkError.status = Constant.NetworkErrorType.serverErrorCode
//                            networkError.message = Constant.NetworkErrorType.serverError
//
//                            Falioure(networkError)
//
//                        }else{
//
//                            networkError.status = Constant.NetworkErrorType.generic
//                            networkError.message = Constant.NetworkErrorType.genericError
//
//                            Falioure(networkError)
//                        }
//                        break
//
//                    }
//
//                })
//            case .failure(let error):
//                Falioure(error as! NetworkError)
//            }
//
//        })
//    }
    
    
//    func uploadImagenew(userImage : UIImage?,withCompletionHandler:@escaping (Uploadimage) -> Void){
//        let url = Constant.MainUrl + Constant.URLs.upploadimg
//        Alamofire.upload(
//            multipartFormData: { MultipartFormData in
//                if((userImage) != nil){
//                    MultipartFormData.append(userImage!.jpegData(compressionQuality: 0.025)!, withName: "image", fileName: "imageNew.jpeg", mimeType: "image/jpeg")
//                }
//
//        }, to: url) { (result) in
//
//            switch result {
//            case .success(let upload, _, _):
//
//                upload.responseJSON { response in
//                    print(response.data!)
//                }
//
//            case .failure(let encodingError): break
//            print(encodingError.localizedDescription)
//            }
//
//
//        }
//    }
    
    
    
    
    
    
//    class func uploadmycard(url: String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (DataResponse<Any>)->Void, Falioure: @escaping (NetworkError) -> Void)
//    {
//        var Headers : HTTPHeaders
//        let Manger = Alamofire.SessionManager.default
//        //print(UserDefaults.standard.value(forKey: "userAuthToken")!)
////        if let userToken = ShareData.shareInfo.userInfo?.collection?.authorization {
////            Headers = [
////                "Accept": "application/json",
////                "authorization" : userToken
////                //"Content-type": "multipart/form-data"
////            ]
////        }else
////        {
//            Headers = ["Accept": "application/json"]
//        //}
//
//        let type = "any"
//        let fileName = "image"
//         let data = userimg.jpegData(compressionQuality: 0.7)
//
//
//    Alamofire.upload(multipartFormData: { (multipartFormData) in
//
//
//            multipartFormData.append(data!, withName: "image", fileName: "swift_file.png", mimeType: "image/png")
////            for (key, value) in param {
////                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
////            }
//        }, to: url)
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//
//                upload.uploadProgress(closure: { (progress) in
//                    //Print progress
//                    print("uploading \(progress)")
//
//                })
//
//                upload.responseJSON { response in
//                    //print response.result
//                    print(response)
//                    Success(response)
//
//                }
//            case .failure( let error):
//                Falioure(error as! NetworkError)
//                //print encodingError.description
//            }
//        }
//    }
    
    
    
    
}
struct NetworkError {
    var status: Int = Constant.NetworkErrorType.generic
    var message: String = Constant.NetworkErrorType.genericError
}

struct NetworkSuccess {
    var status: Int = Constant.NetworkErrorType.generic
    var message: String = Constant.NetworkErrorType.genericError
}
