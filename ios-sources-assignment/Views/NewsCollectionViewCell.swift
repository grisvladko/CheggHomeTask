//
//  NewsTableViewCell.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 26/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    static let id = "News"
        
    var imageView: IdentifiedImageView = {
        var image = IdentifiedImageView(image: nil)
        image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleL: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let subtitleL: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 0
        return label
    }()
    
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }

    private func setup() {
        stackView = UIStackView(arrangedSubviews: [titleL, subtitleL])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        contentView.addSubview(imageView)

        setupConstraints()
    }
    
    public func update(_ model: NewsModel) {
        titleL.text = model.title
        subtitleL.text = model.subtitle
        imageView.id = model.image
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
