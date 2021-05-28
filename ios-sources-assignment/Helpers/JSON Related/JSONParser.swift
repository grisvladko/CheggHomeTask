//
//  JSONParser.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 26/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import Foundation
import SwiftyJSON

struct JSONParser {
    
    func parse(data: Data, for source: Constants.Datasource) -> [NewsModel] {
        var json = JSON(data)
        
        let path = source.getElementPath()
        var root = path.root
        
        while root != nil {
            if let key = root!.key as? String {
                json = json[key]
            }
            else if let key = root!.key as? Int {
                json = json[key]
            }
            root = root!.next
        }
        
        var news : [NewsModel] = []
        json.forEach { str, obj in
            news.append(makeNews(with: obj, type: source))
        }
        
        return news
    }
    
    func makeNews(with json: JSON, type: Constants.Datasource) -> NewsModel {
        switch type {
            case .sourceA: return makeForA(json)
            case .sourceB: return makeForB(json)
            case .sourceC: return makeForC(json)
        }
    }
    
    private func makeForA(_ json: JSON) -> NewsModel {
        return NewsModel(title: json["title"].stringValue,
                         subtitle: json["subtitle"].stringValue,
                         image: json["imageUrl"].stringValue
                         , source: .sourceA)
    }
    
    private func makeForB(_ json: JSON) -> NewsModel {
        return NewsModel(title: json["articlewrapper"]["header"].stringValue,                   subtitle:           json["articlewrapper"]["description"].stringValue,
                         image: json["picture"].stringValue,
                         source: .sourceB)
    }
    
    private func makeForC(_ json: JSON) -> NewsModel {
        return NewsModel(title: json["topLine"].stringValue,
                         subtitle: "\(json["subLine1"].stringValue)\(json["subLine2"].stringValue)",
                         image: json["image"].stringValue,
                         source: .sourceC)
    }
}


