//
//  ScoreViewController.swift
//  QuickMath
//
//  Created by Mark ⠀ on 8/21/20.
//  Copyright © 2020 Mark ⠀. All rights reserved.
//

//TODO: MASS REFACTOR CODE.

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet var currentScoreLabel: UILabel!
    @IBOutlet var scoreAdmireLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var OKLabel: UIButton!
    @IBOutlet var highestScoreYetLabel: UILabel!
    @IBOutlet var completionTimeLabel: UILabel!
    var score = "", problemSetAmount = 0, timerWasEnabled = false, completionTime = ""
    var operatorType = EquationGenerator().operationType
    
    var pallet = CustomColorSet()

    override func viewDidLoad() {
        super.viewDidLoad()
        OKLabel.applyGradient(colors: [pallet.darkBlue.cgColor, pallet.lightBlue.cgColor])
        highestScoreYetLabel.isHidden = true
        // Do any additional setup after loading the view.
        
        if timerWasEnabled {
            completionTimeLabel.text = completionTime
        }
        
        currentScoreLabel.makeFontFitWidth()
        
        switch Double(score)! / Double(problemSetAmount) {
        case 0.75...1.0:
            currentScoreLabel.text = "🥳 \(score) / \(problemSetAmount)"
            scoreAdmireLabel.text = "Excellent job!"
        case 0.4..<0.75:
            currentScoreLabel.text = "🙂 \(score) / \(problemSetAmount)"
            scoreAdmireLabel.text = "Good work."
        default:
            currentScoreLabel.text = "😕 \(score) / \(problemSetAmount)"
            scoreAdmireLabel.text = "Oh well, better luck next time."


        }
        let defaults = UserDefaults.standard
        var key = ""
        switch operatorType {
        case .none:
            key = ""
        case .addition:
            key = "a"
        case .subtraction:
            key = "s"
        case .multiplication:
            key = "m"
        case .division:
            key = "d"
        }
        if let highScore = defaults.string(forKey: key) {
            scoreLabel.text = "\(highScore) / 10"
            if Int(score)! > Int(highScore)! {
                saveScore()
                highestScoreYetLabel.isHidden = false
            }
        }
        else {
            //Highest score yet
            scoreLabel.text = "\(score) / 10"
            saveScore()
            highestScoreYetLabel.isHidden = false
        }
    }
    
    func saveScore() {
        let defaults = UserDefaults.standard
        switch operatorType {
        case .none:
            defaults.set(score, forKey: defaultsKeys.keyOne)
        case .addition:
            defaults.set(score, forKey: defaultsKeys.keyOne)
        case .subtraction:
            defaults.set(score, forKey: defaultsKeys.keyTwo)
        case .multiplication:
            defaults.set(score, forKey: defaultsKeys.keyThree)
        case .division:
            defaults.set(score, forKey: defaultsKeys.keyFour)
        }
    }
    
    struct defaultsKeys {
        static let keyOne = "a", keyTwo = "s", keyThree = "m", keyFour = "d"
    }
    
    @IBAction func unwindBackToMain(_ sender: Any) {
        self.performSegue(withIdentifier: "aaa", sender: self)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
