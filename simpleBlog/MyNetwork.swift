//
//  MyNetwork.swift - Singleton for network requests
//  simpleBlog
//
//  Created by Dmitry Suvorov on 24/05/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// let BASE_HOST = "https://infotech-test.herokuapp.com/"

// MARK: - Singleton
final class MyNetwork {
    
    private init() { }
    static let sharedInstance = MyNetwork()
    
    // check for network availability
//    private let manager = NetworkReachabilityManager(host: BASE_HOST)
//    
//    private func isNetworkReachable() -> Bool {
//        return manager?.isReachable ?? false
//    }
//    
//    public func getPosts(completion: @escaping(JSON?)->() ) {
//        if !isNetworkReachable() { // if network is unavailable
//            completion(nil)
//        } else { // network available
//            Alamofire.request(BASE_HOST).validate().responseJSON { response in
//                switch response.result {
//                case .success:
//                    if response.result.value != nil {
//                        let json = JSON(response.result.value!)
//                        completion(json)
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//    }
    
//    func uploadPostToServer(pr: postSctruct, success: @escaping(Bool)->()) {
//        if !isNetworkReachable() { // if network is unavailable
//            success(false)
//        } else {
//            let sQueue = DispatchQueue(label: "ru.ip-suvorov.sync-queue", qos: .utility, target: nil)
//    //        "name"         : "Username",
//    //        "user_pic_url" : "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Orange_lambda.svg/2000px-Orange_lambda.svg.png",
//    //        "date"         : "2016-07-10T01:11:22.139+04:00",
//    //        "body"         : "post body"
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//            
//            let dateStr = dateFormatter.string(from: pr.date)
//            var params: [String: String]
//        
//            var userPicUrl = ""
//            var body = ""
//            
//            if pr.userPicUrl != nil {
//                userPicUrl = pr.userPicUrl!
//            } else {
//                userPicUrl = ""
//            }
//            if pr.body != nil {
//                body = pr.body!
//            } else {
//                body = ""
//            }
//            
//            params = ["name": pr.name, "user_pic_url": userPicUrl, "date": dateStr, "body": body]
//            
//            Alamofire.request(BASE_HOST+"post", method: .post, parameters: params, encoding: JSONEncoding.default)
//                .response(
//                    queue: sQueue,
//                    responseSerializer: DataRequest.jsonResponseSerializer(),
//                    completionHandler: { response in
//                        switch response.result {
//                        case .success:
//                            success(true)
//                        case .failure(_):
//                            success(false)
//                        }
//                }
//            )
//        }
//    }
}

