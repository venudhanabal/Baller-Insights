//
//  ResultViewController.swift
//  Basket Facts
//
//  Created by Venu Aravind Dhanabal on 11/22/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    var playerName: String?
    var teamName: String?
    var primaryColor: UIColor?
    var secondaryColor: UIColor?
//    var fieldGoalPercentage: Double?
//    var freeThrowPercentage: Double?
//    var threePointPercentage: Double?
    
    var statistics: [Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        playerNameLabel.text = playerName
        teamNameLabel.text = teamName
        
        //MARK: - Swiping
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        //MARK: - ----------------
        
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
                dismiss(animated: true)
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped Up")
                performSegue(withIdentifier: K.toStat, sender: self)
            default:
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toStat {
            let destinationVC = segue.destination as! StatViewController
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
