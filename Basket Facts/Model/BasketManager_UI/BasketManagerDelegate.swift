//
//  BasketManagerDelegate.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 11/20/23.
//

import Foundation

protocol BasketManagerDelagate {
    func didFailWithError(error: Error)
    
    func didUpdateFact(_ BasketManager: BasketManager, basketFact: BasketModel)
}
