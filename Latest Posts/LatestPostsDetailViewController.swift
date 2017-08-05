//
//  LatestPostsDetailViewController.swift
//  Latest Posts
//
//  Created by Wes Brown on 8/4/17.
//  Copyright © 2017 Wes Brown. All rights reserved.
//

import UIKit

class LatestPostsDetailViewController: UIViewController {
    
    @IBOutlet weak var sentPostData: UITextView!
    
    var currentPost: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentPost.isEmpty {
            sentPostData.text = "Feed Not Loaded"
        } else {
            sentPostData.text = currentPost
        }

    }
    
    @IBAction func done() {
        dismiss(animated: true, completion: nil)
    }

}
