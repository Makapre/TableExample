//
//  Data.swift
//  TableExample
//
//  Created by Marius Preikschat on 04.05.22.
//

struct CodableExample: Codable {
    var count: Int
    var entries: [Entry]
}

struct Entry: Codable {
    var API: String
    var Description: String
    var Auth: String
    var HTTPS: Bool
    var Cors: String
    var Link: String
    var Category: String
}
