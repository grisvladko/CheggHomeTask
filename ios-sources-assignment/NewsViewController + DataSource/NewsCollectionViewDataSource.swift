//
//  NewsCollectionViewDataSource.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 28/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import UIKit

class NewsCollectionViewDataSource<Cell : UICollectionViewCell, T> : NSObject, UICollectionViewDataSource {
    
    private var cellIdentifier: String?
    private var items: [T]?
    var configureCell : (Cell, T) -> Void = {_,_ in }
    
    init(cellIdentifier: String,
         items: [T],
         configureCell : @escaping(Cell, T) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier ?? "", for: indexPath) as! Cell
        
        let item = items![indexPath.row]
        configureCell(cell, item)
        
        return cell
    }
}
