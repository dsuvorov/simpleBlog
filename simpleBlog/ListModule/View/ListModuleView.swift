//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import UIKit

class ListModuleView: UIViewController, ListModuleViewProtocol, UITableViewDelegate, UITableViewDataSource {
    var presenter: ListModulePresenterProtocol?
    var objects = [TableViewItem]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewHasBeenLoaded()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "cellRecord")
        
        // adding button Adding a record
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPressed(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func showObjects(objects: [TableViewItem]) {
        self.objects = objects
        self.tableView.reloadData()
    }
    
    // Add post button pressed
    func addBtnPressed(_: Any?) {
        self.presenter?.addBtnPressed()
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellRecord", for: indexPath) as! MyTableViewCell
        let rec = objects[indexPath.row]
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}
