//
//  NewsViewModel.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 28/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import Foundation
import UIKit.UIImage

class NewsViewModel: NSObject {
    
    private var service = APIService()
    private var parser = JSONParser()
    private(set) var news: [NewsModel] = [] {
        didSet {
            self.bindWithController()
        }
    }
    
    var bindWithController: (() -> Void) = {}
    
    override init() {
        super.init()
        getNewsForAllSources()
    }
    
    func getNewsForAllSources() {
        let group = DispatchGroup()
        var result : [NewsModel] = []
    
        for src in Constants.Datasource.allCases {
            group.enter()
            
            getNewsForSource(src) { (newOne) in
                guard let newOne = newOne else { return group.leave() }
                result.append(contentsOf: newOne)
                group.leave()
            }
        }
        
        group.notify(queue: .global()) { [weak self] in
            self?.news = result
        }
    }

    func getNewsForSource(_ src: Constants.Datasource,
                          _ completion: @escaping ([NewsModel]?) -> Void ) {
        
        var newOne : [NewsModel] = []
        
        service.fetch(src.sourceUrl()) { (data, error) in
            guard error == nil, data != nil else { return completion(nil) }
            
            self.saveNews(newOne, for: src)
            
            newOne.append(contentsOf: self.parser.parse(data: data!, for: src))
            completion(newOne)
        }
    }
    
    func saveNews(_ newOne: [NewsModel], for source: Constants.Datasource) {
        for one in newOne {
            Cache.shared.save(one as AnyObject, for: source.rawValue as AnyObject, lifetime: source.getLifespan())
        }
    }
    
    func loadImage(for model: NewsModel,
                   _ completion: @escaping (UIImage?) -> Void) {
        
        if let image = Cache.shared.get(model.image as AnyObject) as? UIImage {
            return completion(image)
        }
        
        service.fetch(model.image) { (data, error) in
            guard error == nil, data != nil else { return completion(nil) }
            let image = UIImage(data: data!)
            
            Cache.shared.save(image as AnyObject, for: model.image as AnyObject, lifetime: model.source.getLifespan())
            
            return completion(image)
        }
    }
}
