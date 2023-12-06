//
//  StatData.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 11/26/23.
//

import Foundation


struct StatData: Decodable {
    let statistics: Statistics
}

struct Statistics: Decodable {
    let fieldGoalsPercentage: Double
    let freeThrowsPercentage: Double
    let threePointsPercentage: Double
}
