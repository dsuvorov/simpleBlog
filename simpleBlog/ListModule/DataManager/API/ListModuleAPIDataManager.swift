//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let BASE_HOST = "https://infotech-test.herokuapp.com/"

class ListModuleAPIDataManager: ListModuleAPIDataManagerInputProtocol {
    
    // check for network availability
    private let manager = NetworkReachabilityManager(host: BASE_HOST)
    
    private func isNetworkReachable() -> Bool {
        return manager?.isReachable ?? false
    }
    
    init() {}
    
    func getPosts(result: @escaping ([ListModuleItem]?)->()) {
        if !isNetworkReachable() { // if network is unavailable
            result(nil)
        } else { // network available
            Alamofire.request(BASE_HOST).validate().responseJSON { response in
                switch response.result {
                case .success:
                    if response.result.value != nil {
                        let json = JSON(response.result.value!)
                        let allPosts = self.jsonToEntity(json: json)
                        result(allPosts)
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    func uploadPost(post: ListModuleItem, success: @escaping (Bool)->()) {
        if !isNetworkReachable() { // if network is unavailable
            success(false)
        } else {
            // remote data format:
            //        "name"         : "Username",
            //        "user_pic_url" : "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Orange_lambda.svg/2000px-Orange_lambda.svg.png",
            //        "date"         : "2016-07-10T01:11:22.139+04:00",
            //        "body"         : "post body"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            
            let dateStr = dateFormatter.string(from: post.date)
            var params: [String: String]
            
            var userPicUrl = ""
            var body = ""
            
            if post.userPicUrl != nil {
                userPicUrl = post.userPicUrl!
            } else {
                userPicUrl = ""
            }
            if post.body != nil {
                body = post.body!
            } else {
                body = ""
            }
            
            params = ["name": post.name, "user_pic_url": userPicUrl, "date": dateStr, "body": body]
            
            let sQueue = DispatchQueue(label: "ru.ip-suvorov.sync-queue", qos: .utility, target: nil)
            Alamofire.request(BASE_HOST+"post", method: .post, parameters: params, encoding: JSONEncoding.default)
                .response(
                    queue: sQueue,
                    responseSerializer: DataRequest.jsonResponseSerializer(),
                    completionHandler: { response in
                        switch response.result {
                        case .success:
                            success(true)
                        case .failure(_):
                            success(false)
                        }
                }
            )
        }
    }
    
    // parses server response and returns array of ListModuleItem
    func jsonToEntity(json: JSON)->([ListModuleItem]) {
        var entityArr = [ListModuleItem]()
        if let postsArray = json.array {
            for item in postsArray {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                dateFormatter.locale = Locale.init(identifier: "ru_RU")
                let dateObj = dateFormatter.date(from: item["date"].stringValue)
                let item = ListModuleItem(id: item["id"].intValue, date: dateObj!, name: item["name"].stringValue, body: item["body"].stringValue, userPicUrl: item["user_pic_url"].stringValue)
                entityArr.append(item)
            }
        }
        return entityArr
    }
    
}
