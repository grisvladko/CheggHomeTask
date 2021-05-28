
//  Copyright © 2018 Chegg. All rights reserved.

import Foundation

public struct Constants {
    static let baseUrl = "http://chegg-mobile-promotions.cheggcdn.com/ios/home-assignments/"
    
    public enum Datasource : String, CaseIterable {
        case sourceA = "source_a.json"
        case sourceB = "source_b.json"
        case sourceC = "source_c.json"
        
        public func sourceUrl() -> URL? {
            return URL(string: "\(Constants.baseUrl)\(self.rawValue)")
        }
        
        public func sourceUrl() -> String {
            return "\(Constants.baseUrl)\(self.rawValue)"
        }
        
        func getElementPath() -> JSONAccessPath {
            return JSONAccessPath(source: self)
        }
        
        // specify how much time each object stays in cache in seconds.
        public func getLifespan() -> Int {
            switch self {
                case .sourceA: return 5 * 60
                case .sourceB: return 30 * 60
                case .sourceC: return 60 * 60
            }
        }
        
        
        
    }
}
