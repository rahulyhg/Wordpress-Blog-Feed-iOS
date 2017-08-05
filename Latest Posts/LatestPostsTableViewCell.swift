//
//  LatestPostsTableViewCell.swift
//  Latest Posts
//
//  Created by Wes Brown on 8/4/17.
//  Copyright © 2017 Wes Brown. All rights reserved.
//

import UIKit

class LatestPostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postContent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
