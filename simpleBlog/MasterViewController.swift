//
//  MasterViewController.swift
//  simpleBlog
//
//  Created by Dmitry Suvorov on 24/05/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    let network = MyNetwork.sharedInstance // network
    let db = MyDB.sharedInstance // db
    let sync = SyncManager.sharedInstance // sync manager


    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "cellRecord")
        
        self.loadPosts()
        
        // seting up refreshcontrol
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector(loadPosts), for: UIControlEvents.valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableRefreshFromDB()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadPosts() {
        self.refreshControl?.beginRefreshing()
        self.sync.startSync() // starts uploading not uploaded posts (it stops when done or on error)
        self.network.getPosts(completion: { (jsonResponse) in
            if jsonResponse == nil { // network is not avaiable
                self.refreshControl?.endRefreshing()
                self.tableRefreshFromDB()
            } else { // network avaiable
                if let postsArray = jsonResponse!.array {
                    if postsArray.count > 0 {
                        self.db.removeAllPosts() // deletes all the posts except those which were put in uploading queue
                    }
                    for item in postsArray {
                        // date parsing. example: 2016-08-04T13:58:56.330+04:00
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                        dateFormatter.locale = Locale.init(identifier: "ru_RU")
                        
                        let dateObj = dateFormatter.date(from: item["date"].stringValue)
                        
                        let pr = postSctruct(id: item["id"].intValue, date: dateObj!, name: item["name"].stringValue, body: item["body"].stringValue, userPicUrl: item["user_pic_url"].stringValue)
                        self.db.addPostToDB(post: pr)
                        
                        if postsArray.last == item {
                            self.refreshControl?.endRefreshing()
                            self.tableRefreshFromDB()
                        }
                    }
                }
            }
        })
    }
    
    func tableRefreshFromDB() {
        let fromDB = self.db.getAllPosts()
        if fromDB.count > 0 {
            self.objects = []
        }
        for item in fromDB {
            self.objects.append(item)
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBtnPressed(_: Any?) {
        self.performSegue(withIdentifier: "addPost", sender: self)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPost" {
            let controller = segue.destination as! DetailViewController
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellRecord", for: indexPath) as! MyTableViewCell
        let rec = objects[indexPath.row] as! postSctruct
        
        cell.nameLabel.text = rec.name
        
        if rec.userPicUrl != nil && rec.userPicUrl != "" {
            cell.avatatImageView.sd_setShowActivityIndicatorView(true)
            cell.avatatImageView.sd_setIndicatorStyle(.gray)
            let imgUrl = URL(string: rec.userPicUrl!)
            cell.avatatImageView.sd_setImage(with: imgUrl)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.locale = Locale.init(identifier: "ru_RU")
        cell.dateLabel.text = dateFormatter.string(from: rec.date)
        
        if rec.body != nil {
            cell.bodyTextLabel.text = rec.body!
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}
