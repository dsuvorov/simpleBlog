////
////  SyncManager.swift - Singleton for managing posts uploading - upload all the non synchronized posts every 5 seconds
////  simpleBlog
////
////  Created by Dmitry Suvorov on 24/05/17.
////  Copyright © 2017 ip-suvorov. All rights reserved.
////
//
//import Foundation
//import Alamofire
//import SwiftyJSON
//
//// MARK: - Singleton
//final class SyncManager {
//    private init() { }
//    static let sharedInstance = SyncManager()
//    
//    let network = MyNetwork.sharedInstance // network
//    let db = MyDB.sharedInstance // db
//    var netTimer = Timer() // timer
//    
//    func startSync() {
//        // get all non synched posts and upload them
//        if !self.netTimer.isValid {
//            self.netTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(SyncManager.syncAll), userInfo: nil, repeats: true)
//        }
//    }
//    
//    func stopSync() {
//        // stops synching
//        self.netTimer.invalidate()
//    }
//    
//    @objc func syncAll() {
//        let sQueue = DispatchQueue(label: "ru.ip-suvorov.sync-queue",
//                                      qos: .utility,
//                                      target: nil)
//        sQueue.async {
//            let forSync = self.db.getAllQueue()
//            if forSync.count == 0 { // stops uploading if the upload queue is empty
//                self.stopSync()
//            }
//            
//            for pr in forSync {
//                self.network.uploadPostToServer(pr: pr, success: { (isSucceed) in
//                        if isSucceed { // successfully uploaded to server
//                            if pr.objectId != nil {
//                                self.db.removePostFromQueue(objectId: pr.objectId!)
//                            }
//                        } else { // error occured - stops the timer
//                            self.stopSync()
//                        }
//                    }
//                )
//                if !self.netTimer.isValid {
//                    break
//                }
//            }
//        }
//    }
//}
//
