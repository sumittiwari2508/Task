//
//  NewsModel.swift
//  PlayoTask
//
//  Created by Kripa Tripathi on 21/06/22.
//

import Foundation
import SwiftyJSON

struct NewsModel{

    var name :String?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let content: String?

    init(json:JSON){
        author = json["author"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        url = json["url"].stringValue
        urlToImage = json["urlToImage"].stringValue
        content = json["content"].stringValue
    }
}
