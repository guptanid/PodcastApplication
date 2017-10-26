//
//  PlaylistTableViewController.swift
//  Homework2
//
//  Created by Gupta, Nidhi on 10/22/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import AVKit
class PlaylistTableViewController: UITableViewController {

    var playlistItems = [PodcastItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(playlistItems.count)
        let navBtn = UIBarButtonItem(title: "Play All", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItems?.append(navBtn)
        self.navigationController?.navigationBar.items?.append(self.navigationItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playlistItems.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath) as! PlaylistTableViewCell
        cell.lblPlaylistTitle.text = playlistItems[indexPath.item].title
        cell.lblMediaDuration.text = String("Podcast Duration: \(playlistItems[indexPath.item].enclosure.mediaDuration)")
        cell.lblMediaType.text = String("Media Type: \(playlistItems[indexPath.item].enclosure.mediaType!)")
        cell.btnPlayMedia.tag = indexPath.item
        cell.btnDeleteFromPlaylist.tag = indexPath.item + 100
        return cell
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewPlaylist") {
            let tag = (sender as! UIButton!).tag
            let podcastURL = playlistItems[tag].enclosure.mediaLink!
            let destination = segue.destination as! AVPlayerViewController
            destination.title = playlistItems[tag].title
            let url = URL(string: podcastURL)
            if let movieURL = url {
                destination.player = AVPlayer(url: movieURL)
            }
        }
    }
    
    @IBAction func btnPlayPodcast(_ sender: Any) {
    }
    
    @IBAction func btnDeleteFromPlaylist(_ sender: Any) {
        let index = (sender as! UIButton).tag - 100
        playlistItems.remove(at: index)
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: playlistItems)
        userDefaults.set(encodedData, forKey: "PodcastPlaylist")
        userDefaults.synchronize()
        tableView.reloadData()
    }
}
