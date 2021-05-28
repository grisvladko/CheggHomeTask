//
//  NewsModel.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 26/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import Foundation

struct NewsModel : Hashable {
    let title: String
    let subtitle: String
    let image: String
    let source: Constants.Datasource // used to determine caching lifespan
}
