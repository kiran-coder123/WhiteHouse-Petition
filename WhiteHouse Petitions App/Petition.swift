//
//  Petition.swift
//  WhiteHouse Petitions App
//
//  Created by Satinder Panesar on 5/12/21.
//

import Foundation
struct Petition: Codable {
    var title: String
    var body : String
    var signatureCount: Int
}
