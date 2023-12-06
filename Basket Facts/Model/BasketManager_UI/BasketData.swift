//
//  BasketModel.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 11/20/23.
//

import Foundation

struct BasketData: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let entity: Entity
}

struct Entity: Decodable {
    let name: String
    let team: Team?
    let id: Int64
}

struct Team: Decodable {
    let name: String?
    let teamColors: TeamColors
    let id: Int
}

struct TeamColors: Decodable {
    let primary: String
    let secondary: String
}
