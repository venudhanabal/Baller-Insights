//
//  StatViewController.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 12/4/23.
//

import UIKit

class StatViewController: UIViewController {
    
    
    @IBOutlet weak var StatTableView: UITableView!
    
    var playerName: String?
    var teamName: String?
    var primaryColor: UIColor?
    var secondaryColor: UIColor?

    var statistics: [Double?]?

    override func viewDidLoad() {
        super.viewDidLoad()

        print("player: \(playerName ?? "no player")")
        print("team: \(teamName ?? "no team")")
        print("primaryColor: \(primaryColor ?? .gray)")
        print("secondaryCoor: \(secondaryColor ?? .white)")
        
        
        print("fieldGoalPercentage: \(statistics?[0] ?? 0.0)")
        print("freeThrowPercentage: \(statistics?[1] ?? 0.0)")
        print("threePointPercentage: \(statistics?[2] ?? 0.0)")
        
        StatTableView.dataSource = self
        StatTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    

    

}

extension StatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.statistics.statisticsName.count // how many cells the view should have
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StatTableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! StatTableViewCell
        cell.statName.text = K.statistics.statisticsName[indexPath.row]
        cell.stat.text = "\(statistics?[indexPath.row] ?? 0.0)%"
        
        return cell
    }
    
    
}
