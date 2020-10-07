//
//  GameViewController.swift
//  QuickMath
//
//  Created by Mark ⠀ on 8/17/20.
//  Copyright © 2020 Mark ⠀. All rights reserved.
//

//TODO: MASS REFACTOR CODE.

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var firstNumberLabel: UILabel!
    @IBOutlet var operatorLabel: UILabel!
    @IBOutlet var secondNumberLabel: UILabel!
    @IBOutlet var equationLabelStack: [UIStackView]!
    @IBOutlet var equationLabelCollection: [UILabel]!
    @IBOutlet var button: UIButton!
    @IBOutlet var answerButtonCollection: [UIButton]!
    @IBOutlet var problemNavBarLabel: UINavigationItem!
    @IBOutlet var timerNavBar: UIBarButtonItem!
    @IBOutlet var operatorImage: UIImageView!
    
    var pallet = CustomColorSet()
    var equationGenerator = EquationGenerator()
    var rightAnswer = 0, score = 0, requestedProblemSet = 0, time = 0, timerEnabled = true
    var problemProgress = 1 {
        didSet {
            problemNavBarLabel.title = "Problem \(problemProgress)/\(requestedProblemSet)"
            if problemProgress > requestedProblemSet {
                problemNavBarLabel.title = "Problem \(requestedProblemSet)/\(requestedProblemSet)"
                self.performSegue(withIdentifier: "end", sender: self)
            }
        }
    }
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        equationGenerator.generate(operand: "+", difficulty: .easy)
        problemNavBarLabel.title = "Problem 1/\(requestedProblemSet)"
        if !(timerEnabled) { timerNavBar.tintColor = UIColor.clear }
        else {timerNavBar.tintColor = UIColor.systemBlue}
        megaSetup()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)


        //new function
        
//
//        for label in equationLabelCollection {
//            label.backgroundColor = .none
//        }
        
    }
    
    @objc func timerAction(){
           time += 1
        timerNavBar.title = timeString(time: TimeInterval(time))
        }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func megaSetup() {
        setup(equationLabelCollection)
        setup(answerButtonCollection)
        placeRightAnswer(in: answerButtonCollection)
    }
    
    func setup(_ answers: [UIButton]!){
        var alreadyFilledAnswers = [Int]()
         for button in answers {
            button.isEnabled = true
        }
        for button in answers {
//            button.backgroundColor = pallet.lightGray
            button.backgroundColor = UIColor.systemGray5
            button.layer.cornerRadius = 25
//            button.layer.borderWidth = -5
//            button.layer.borderColor = pallet.darkBlue.cgColor
            button.setTitleColor(.systemBlue, for: .normal)
            equationGenerator.generateNewEquation()
            let i = equationGenerator.z
            
//
            if (alreadyFilledAnswers.contains(i) || i == rightAnswer) {
                button.setTitle("", for: .disabled)
                button.isEnabled = false
            }
            else {
                button.isEnabled = true
                alreadyFilledAnswers.append(i)
                button.setTitle(" \(i) ", for: .normal)
                button.titleLabel!.makeFontFitWidth()
            }
//            button.titleLabel!.numberOfLines = 1
//            button.titleLabel!.adjustsFontSizeToFitWidth = true
//            button.titleLabel!.baselineAdjustment = .alignCenters
//            button.titleLabel!.lineBreakMode = NSLineBreakMode.byClipping
        }
    }
    
    func setup(_ equations: [UILabel]!) {
        for label in equations {
            label.backgroundColor = .none
        }
        equationGenerator.generateNewEquation()
        equations[0].text = String(equationGenerator.y)
        equations[2].text = String(equationGenerator.x)
        rightAnswer = equationGenerator.z
        
        switch equationGenerator.operationType {
        case .addition:
            equations[1].text = "+"
            equations[1].textColor = pallet.lightGreen
            operatorImage.image = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .black))?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        case .none:
            equations[1].text = "?"
        case .subtraction:
            equations[1].text = "-"
            equations[1].textColor = pallet.lightRed
            operatorImage.image = UIImage(systemName: "minus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .black))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        case .multiplication:
            equations[1].text = "*"
            equations[1].textColor = pallet.lightBlue
            operatorImage.image = UIImage(systemName: "multiply.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .black))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        case .division:
            equations[1].text = "÷"
            equations[1].textColor = pallet.lightYellow
            operatorImage.image = UIImage(systemName: "divide.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .black))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        }
    }
    
    func placeRightAnswer(in answers: [UIButton]!) {
        let randomIndex = Int.random(in: 0..<answers.count)
        answers[randomIndex].setTitle(" \(String(rightAnswer)) ", for: .normal)
        answers[randomIndex].isEnabled = true
    }
    
    @IBAction func answerGuessed(_ sender: UIButton) {
        if sender.titleLabel?.text == " \(String(rightAnswer)) " {
            score += 1
            print("wow")
        }
        progress()
    }
    
    func progress() {
        problemProgress += 1
        if problemProgress <= requestedProblemSet {
            megaSetup()
        }
    }
    
    @IBAction func exit(_ sender: Any) {
        self.performSegue(withIdentifier: "quit", sender: self)
    }
    
    @IBAction func skip(_ sender: Any) {
        progress()
    }
    
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as? ScoreViewController
        vc?.score = String(score)
        vc?.problemSetAmount = requestedProblemSet
        
        vc?.timerWasEnabled = timerEnabled
        if timerEnabled {
            vc?.completionTime = timerNavBar.title!
        }
        
        vc?.operatorType = equationGenerator.operationType
    }
    

}
