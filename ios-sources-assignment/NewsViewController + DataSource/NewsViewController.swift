//
//  NewsViewController.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 28/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    private var collectionView : UICollectionView!
    private var layout = PaggedFlowLayout()
    private var news : [NewsModel] = []
    
    private var dataSource :
        NewsCollectionViewDataSource<NewsCollectionViewCell, NewsModel>!
    private var newsViewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsViewModel = NewsViewModel()
        
        setupCollectionView()
        
        newsViewModel.bindWithController = { [weak self] in
            self?.updateDataSource()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        Cache.shared.clear()
    }
    
    func updateDataSource() {
        
        dataSource =
            NewsCollectionViewDataSource(cellIdentifier:NewsCollectionViewCell.id,
            items: newsViewModel.news, configureCell: { (cell, item) in
                
                cell.update(item)
            
                self.newsViewModel.loadImage(for: item) { (image) in
                    DispatchQueue.main.async {
                        if cell.imageView.id == item.image {
                            cell.imageView.setImage(image)
                        }
                    }
                }
        })
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.dataSource = self?.dataSource
            self?.collectionView.reloadData()
        }
    }

    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.id)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
