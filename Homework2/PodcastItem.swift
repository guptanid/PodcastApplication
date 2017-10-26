//
//  PodcastItem.swift
//  Homework2
//
//  Created by Gupta, Nidhi on 10/22/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation
class PodcastItem : NSObject, NSCoding{
    var title : String?
    var link : String?
    var pubDate : String?
    var enclosure = Enclosure()
    var summary : String?
    var author : String?
   // var addedToPlaylist : Bool
    /*init(title : String?,
         link : String?,
         pubDate : String?,
         mediaLink : String?,
         mediaType : String,
         mediaDuration : String,
         summary : String?,
         author : String?)
    {
     self.title = title
     self.link = link
     self.pubDate = pubDate
     self.enclosure.mediaLink = mediaLink
     self.enclosure.mediaType = mediaType
     self.enclosure.mediaDuration = mediaDuration
     self.summary = summary
     self.author = author
    }*/
    override init()
    {
        self.title = ""
        self.link = ""
        self.pubDate = ""
        self.enclosure.mediaLink = ""
        self.enclosure.mediaType = ""
        self.enclosure.mediaDuration = ""
        self.summary = ""
        self.author = ""
        //self.addedToPlaylist = false
    }
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.pubDate = decoder.decodeObject(forKey: "pubDate") as? String ?? ""
        self.enclosure.mediaLink = decoder.decodeObject(forKey: "mediaLink") as? String ?? ""
        self.enclosure.mediaType = decoder.decodeObject(forKey: "mediaType") as? String ?? ""
        self.enclosure.mediaDuration = decoder.decodeObject(forKey: "mediaDuration") as? String ?? ""
        self.summary = decoder.decodeObject(forKey: "summary") as? String ?? ""
        self.author = decoder.decodeObject(forKey: "author") as? String ?? ""
        //self.addedToPlaylist = decoder.decodeObject(forKey: "addedToPlaylist") as? Bool ?? false
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(pubDate, forKey: "pubDate")
        coder.encode(enclosure.mediaLink, forKey: "mediaLink")
        coder.encode(enclosure.mediaDuration, forKey: "mediaDuration")
        coder.encode(enclosure.mediaType, forKey: "mediaType")
        coder.encode(summary, forKey: "summary")
        coder.encode(author, forKey: "author")
       // coder.encode(addedToPlaylist, forKey: "addedToPlaylist")
    }
}
class Enclosure{
    var mediaLink : String?
    var mediaType : String?
    var mediaDuration : String
    init(){
        mediaLink = ""
        mediaType = ""
        mediaDuration = ""
    }
}
