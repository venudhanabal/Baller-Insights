//
//  BasketManager.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 11/28/23.
//


import UIKit

struct BasketManager {
    

    let headers = [
        "X-RapidAPI-Key": "c06a16d8a5mshb8a1e1d44015cdfp1dcf57jsncb335657327b",
        "X-RapidAPI-Host": "basketapi1.p.rapidapi.com"
    ]

    let basketUrl = "https://basketapi1.p.rapidapi.com/api/basketball/search/"
    
    
    
    let statUrl1 = "https://basketapi1.p.rapidapi.com/api/basketball/player/"
    let statUrl2 = "/tournament/132/season/"
    let statUrl3 = "/statistics/regularseason"
    
    
    var delegate: BasketManagerDelagate?
    var statDelegate: StatManagerDelegate?
    
//MARK: - General Player Info (and UI Colors)

    func fetchBasket(enteredSearch: String) {
        let urlString = "\(basketUrl)\(enteredSearch)"
        performRequest(with: urlString)

    }
    
    

    func performRequest(with urlString: String) {
        let url = NSMutableURLRequest(url: NSURL(string: urlString)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        url.httpMethod = "GET"
        url.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url as URLRequest) {data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
            }

            
            if let safeData = data {
                if let basketData = parseJSON(safeData) {
                    delegate?.didUpdateFact(self, basketFact: basketData)
                }
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    func parseJSON(_ basketData: Data) -> BasketModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(BasketData.self, from: basketData)
            var teamName = ""
            let fullName = decodedData.results[0].entity.name
            let primaryColor = decodedData.results[0].entity.team?.teamColors.primary
            let secondaryColor = decodedData.results[0].entity.team?.teamColors.secondary
            let id = decodedData.results[0].entity.id
            let teamId = decodedData.results[0].entity.team?.id
            
            if let teamID = decodedData.results[0].entity.team {
                teamName = teamID.name!
            } else {
                teamName = "No team"
            }
            
            let info = [fullName, teamName, primaryColor ?? K.colors.gray, secondaryColor ?? K.colors.white]
            
            let basketFact = BasketModel(info: info, id: id, teamId: teamId ?? 0)
            
            return basketFact

        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    //MARK: - Player Statistics!
    
    func fetchStats(withId id: Int64, withTeamId teamId: Int) {
        let urlString = "\(statUrl1)\(id)\(statUrl2)54105\(statUrl3)"
        print(urlString)
        performStatRequest(with: urlString)
        }
    
    
    
    func performStatRequest(with urlString: String) {
        let url = NSMutableURLRequest(url: NSURL(string: urlString)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        url.httpMethod = "GET"
        url.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url as URLRequest) {data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
            }
            
            if let safeData = data {
                if let statData = statParseJSON(safeData) {
                    statDelegate?.didUpdateStat(self, statFact: statData)
                }
            }
        }
        
        task.resume()
    }
    
    func statParseJSON(_ statData: Data) -> StatModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(StatData.self, from: statData)
            
            let fieldGoalPercentage = decodedData.statistics.fieldGoalsPercentage
            let freeThrowPercentage = decodedData.statistics.freeThrowsPercentage
            let threePointPercentage = decodedData.statistics.threePointsPercentage
            
            let statFacts = StatModel(statistics: [fieldGoalPercentage, freeThrowPercentage, threePointPercentage])
            
            return statFacts
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}



