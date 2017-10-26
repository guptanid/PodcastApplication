//
//  PlaylistTableViewCell.swift
//  Homework2
//
//  Created by Gupta, Nidhi on 10/22/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btnDeleteFromPlaylist: UIButton!
    @IBOutlet weak var btnPlayMedia: UIButton!
    @IBOutlet weak var lblPlaylistTitle: UILabel!
    @IBOutlet weak var lblMediaDuration: UILabel!
    @IBOutlet weak var lblMediaType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
