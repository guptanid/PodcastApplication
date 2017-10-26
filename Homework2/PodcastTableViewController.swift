//
//  PodcastTableViewController.swift
//  Homework2
//
//  Created by Gupta, Nidhi on 10/22/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import AVKit

class PodcastTableViewController: UITableViewController, XMLParserDelegate {

    var podcastList : [PodcastItem] = []
    var playlistItems : [PodcastItem] = []

    @IBOutlet weak var btnViewPodcast_Clicked: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        let decoded  = UserDefaults.standard.object(forKey: "PodcastPlaylist") as! Data
        let decodedPodcast = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [PodcastItem]
        self.playlistItems = decodedPodcast
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let decoded  = UserDefaults.standard.object(forKey: "PodcastPlaylist") as! Data
        let decodedPodcast = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [PodcastItem]
        self.playlistItems = decodedPodcast
        GetPodcastData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return podcastList.count
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as! PodcastTableViewCell
        let podcast = podcastList[indexPath.item]
        cell.lblPodcastTitle.text = String("Title: \(podcast.title!)")
        cell.lblPodcastDate.text = String("Published On: \(podcast.pubDate!)")
        cell.lblPodcastSummary.text = podcast.summary
        cell.lblPodcastAuthor.text = String("Published By: \(podcast.author!)")
        cell.btnViewPodcast.tag = indexPath.item
        cell.btnAddToPlaylist.tag = indexPath.item + 100
    
       if(playlistItems.contains(where: {$0.title == podcast.title})){
         cell.btnAddToPlaylist.isEnabled = false
        }
        //print(podcast)
        return cell
    }
    
    @IBAction func btnViewPodCast_Clicked(_ sender: Any) {
      
    }

    @IBAction func btnAddToPlaylist_Clicked(_ sender: Any) {
        let index = (sender as! UIButton).tag - 100
        playlistItems.append(podcastList[index])
       
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: playlistItems)
        userDefaults.set(encodedData, forKey: "PodcastPlaylist")
        userDefaults.synchronize()
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewPodcast") {
            let tag = (sender as! UIButton!).tag
            let podcastURL = podcastList[tag].enclosure.mediaLink!
            let destination = segue.destination as! AVPlayerViewController
            destination.title = podcastList[tag].title
            let url = URL(string: podcastURL)
            if let movieURL = url {
                destination.player = AVPlayer(url: movieURL)
            }
        }
        else if (segue.identifier == "gotoPlaylist"){
            
            let decoded  = UserDefaults.standard.object(forKey: "PodcastPlaylist") as! Data
            let decodedPodcast = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [PodcastItem]
            
            let destination = segue.destination as! PlaylistTableViewController
            destination.title = "User Playlist"
            destination.playlistItems = decodedPodcast
        }
    }
    
    /*xml parsing code*/
    var parsingItems = false
   var podcast = PodcastItem()
    var tagName = ""
    func GetPodcastData(){
        let parser = XMLParser(contentsOf:(URL(string:"http://feed.thisamericanlife.org/talpodcast"))!)!
        parser.delegate = self
        parser.parse()
        self.tableView.reloadData()
     }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
      tagName = elementName
      if (tagName).isEqual("item")
        {
           parsingItems = true
           podcast = PodcastItem()
        }
        if (tagName).isEqual("enclosure") && parsingItems
        {
           podcast.enclosure.mediaLink?.append(attributeDict["url"]!)
           podcast.enclosure.mediaType?.append(attributeDict["type"]!)
        }
     }
    func parser(_ parser: XMLParser, foundCharacters nodeValue: String)
    {
        if tagName.isEqual("title") && parsingItems{
          podcast.title!.append(nodeValue)
        }
        else if tagName.isEqual("pubDate") && parsingItems{
            let truncatedPubDate = nodeValue.characters.dropLast(6)
            podcast.pubDate!.append(String(truncatedPubDate))
        }
        else if tagName.isEqual("itunes:author") && parsingItems{
             podcast.author!.append(nodeValue)
        }
        else if tagName.isEqual("itunes:summary") && parsingItems{
             podcast.summary!.append(nodeValue)
        }
        else if tagName.isEqual("itunes:duration") && parsingItems{
            podcast.enclosure.mediaDuration.append(nodeValue)
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual("item") {
            podcastList.append(podcast)
        }
    }
}
