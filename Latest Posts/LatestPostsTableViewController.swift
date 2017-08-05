//
//  LatestPostsTableViewController.swift
//  Latest Posts
//
//  Created by Wes Brown on 8/4/17.
//  Copyright © 2017 Wes Brown. All rights reserved.
//

import UIKit
import Alamofire

class LatestPostsTableViewController: UITableViewController {
    
    let latestPosts: String = "https://wesbrowndeveloper.com/wp-json/wp/v2/posts/"
    
    let parameters: [String:AnyObject] = [
        "filter[category_name]" : "Uncategorized" as AnyObject,
        "filter[posts_per_page]" : 5 as AnyObject
    ]
    
    var json: JSON = JSON.null
    
    var postData: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPosts(getposts: latestPosts)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(newNews), for: UIControlEvents.valueChanged)
        self.refreshControl = refreshControl
    }
    
    func newNews(){
        getPosts(getposts: latestPosts)
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func getPosts(getposts : String)
    {
        Alamofire.request(getposts, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            guard let data = response.result.value else{
                print("Request failed with error")
                return
            }
            
            self.json = JSON(data)
            self.tableView.reloadData()
        }
    }
    
    
    func populateFields(_ cell: LatestPostsTableViewCell, index: Int){
        guard let title = self.json[index]["title"]["rendered"].string else{
            cell.postTitle!.text = "Loading..."
            return
        }
        
        cell.postTitle!.text = title
        
        guard let content = self.json[index]["content"]["rendered"].string?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) else{
            cell.postContent!.text = "Unable to load content"
            return
        }
        
        cell.postContent!.text = content
        
        postData = content
        
        self.tableView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postData" {
            if let destination = segue.destination as? LatestPostsDetailViewController {
                let indexPath = tableView.indexPathForSelectedRow!
                let currentCell = tableView.cellForRow(at: indexPath) as! LatestPostsTableViewCell
                
                destination.currentPost = currentCell.postContent.text
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.json.type
        {
        case Type.array:
            return self.json.count
        default:
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LatestPostsTableViewCell
        
        populateFields(cell, index: indexPath.row)
        
        return cell
    }

}
