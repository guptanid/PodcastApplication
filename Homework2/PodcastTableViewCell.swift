//
//  PodcastTableViewCell.swift
//  Homework2
//
//  Created by Gupta, Nidhi on 10/22/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPodcastTitle: UILabel!
    @IBOutlet weak var lblPodcastAuthor: UILabel!
    @IBOutlet weak var lblPodcastDate: UILabel!
    @IBOutlet weak var lblPodcastSummary: UILabel!
  
    @IBOutlet weak var btnAddToPlaylist: UIButton!
    @IBOutlet weak var btnViewPodcast: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
