//
//  Result.swift
//  BucketList
//
//  Created by Subhrajyoti Chakraborty on 02/09/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}
