//
//  StatManagerDelegate.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 11/26/23.
//

import Foundation

protocol StatManagerDelegate {
    func didUpdateStat(_ BasketManager: BasketManager, statFact: StatModel)
}
