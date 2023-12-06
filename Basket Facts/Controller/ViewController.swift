//
//  ViewController.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 11/20/23.
//

import UIKit
import CLTypingLabel


//MARK: - Turn String into a UIColor

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//MARK: - ViewController


class ViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    var basketManager = BasketManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: closure variables
    
    var playerName: String?
    var teamName: String?
    var primaryColor: UIColor?
    var secondaryColor: UIColor?
    var id: Int64?
    var teamId: Int?
    var previousPlayers: [String]?
    
    //MARK: Stat Variables
//    var fieldGoalPercentage: Double?
//    var freeThrowPercentage: Double?
//    var threePointPercentage: Double?
    var statistics: [Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Baller Insights"
        searchTextField.delegate = self
        basketManager.delegate = self
        basketManager.statDelegate = self
    }
    
    
}


//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UITextField) {
        searchTextField.endEditing(true)
        let entered = searchTextField.text!
        basketManager.fetchBasket(enteredSearch: entered)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
}


//MARK: - BasketManagerDelegate

extension ViewController: BasketManagerDelagate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateFact(_ BasketManager: BasketManager, basketFact: BasketModel) {
        
        DispatchQueue.main.async {
            self.playerName = (basketFact.info[0] )
            self.teamName = (basketFact.info[1] )
            self.primaryColor = hexStringToUIColor(hex: basketFact.info[2] )
            self.secondaryColor = hexStringToUIColor(hex: basketFact.info[3] )
            
            self.id = basketFact.id
            self.teamId = basketFact.teamId
            
            if self.previousPlayers?.count ?? 0 < 3 {
                self.previousPlayers?.append(self.playerName!)
            } else {
                self.previousPlayers?.removeLast()
                self.previousPlayers?.append(self.playerName!)
            }
            
            print(self.previousPlayers)
            
            
            
            self.basketManager.fetchStats(withId: self.id!, withTeamId: self.teamId!)
            
            
            
            //self.performSegue(withIdentifier: "WelcomeToResult", sender: self)
            
        }
        
    }
    
}

//MARK: - StatManagerDelegate

extension ViewController: StatManagerDelegate {
    func didUpdateStat(_ BasketManager: BasketManager, statFact: StatModel) {
        DispatchQueue.main.async {
//            self.fieldGoalPercentage = statFact.statistics[0]
//            self.freeThrowPercentage = statFact.freeThrowPercentage
//            self.threePointPercentage = statFact.threePointPercentage
            self.statistics = [statFact.statistics[0], statFact.statistics[1], statFact.statistics[2]]
            
            
            self.performSegue(withIdentifier: K.toResult, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toResult {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.playerName = playerName
            destinationVC.teamName = teamName
            destinationVC.primaryColor = primaryColor
            destinationVC.secondaryColor = secondaryColor
//            destinationVC.fieldGoalPercentage = fieldGoalPercentage
//            destinationVC.freeThrowPercentage = freeThrowPercentage
//            destinationVC.threePointPercentage = threePointPercentage
            destinationVC.statistics = statistics
        }
    }
    
}
