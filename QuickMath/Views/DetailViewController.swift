//
//  DetailViewController.swift
//  QuickMath
//
//  Created by Mark ⠀ on 8/10/20.
//  Copyright © 2020 Mark ⠀. All rights reserved.
//

//TODO: MASS REFACTOR CODE.

import UIKit

//TODO: Add rest of segues. Finish setup() cases. Add descriptor and a start button. Work on last viewcontroller.

class DetailViewController: UIViewController {
    @IBOutlet var upperColoredView: UIView!
    @IBOutlet var operatorTypeLabel: UILabel!
    @IBOutlet var equationExampleLabel: UILabel!
    @IBOutlet var difficultyStatus: UISegmentedControl!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var requestProblemSetControl: UISegmentedControl!
    @IBOutlet var timerSwitch: UISwitch!
    
    var masterSegueID = "" // if empty or "empty" == error
    var pallet = CustomColorSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        equationExampleLabel.layer.cornerRadius = 90
//        equationExampleLabel.layer.borderColor = pallet.darkBlue.cgColor
//        equationExampleLabel.layer.borderWidth = 11
//        equationExampleLabel.backgroundColor = pallet.lightGray
//        equationExampleLabel.numberOfLines = 3
//        equationExampleLabel.adjustsFontSizeToFitWidth = true
//        equationExampleLabel.baselineAdjustment = .alignCenters
//        equationExampleLabel.lineBreakMode = NSLineBreakMode.byClipping
//        equationExampleLabel.text = "The next screen will take you to a set of 10 problems based on the  difficulty you choose below."
        // Do any additional setup after loading the view.
        descriptionLabel.text = "⠀Complete your setup below⠀"
        descriptionLabel.layer.backgroundColor = UIColor.systemGray5.cgColor
        descriptionLabel.layer.cornerRadius = 8
        descriptionLabel.frame.size.width = descriptionLabel.intrinsicContentSize.width + 10
        descriptionLabel.frame.size.height = descriptionLabel.intrinsicContentSize.height + 10
        descriptionLabel.textAlignment = .center
        descriptionLabel.makeFontFitWidth()
        descriptionLabel.numberOfLines = 0
        setup(with: masterSegueID)
        difficultySwitched(0)
    }
    
    func setup(with identifier: String) {
        switch identifier {
        case "Addition":
            detailViewSetup(for: identifier, button: startButton, backgroundColor: pallet.darkGreen, accentColor: pallet.lightGreen)
        case "Subtraction":
            detailViewSetup(for: identifier, button: startButton, backgroundColor: pallet.darkRed, accentColor: pallet.lightRed)
        case "Multiplication":
            detailViewSetup(for: identifier, button: startButton, backgroundColor: pallet.darkBlue, accentColor: pallet.lightBlue)
        case "Division":
            detailViewSetup(for: identifier, button: startButton, backgroundColor: pallet.darkYellow, accentColor: pallet.lightYellow)
        default:
            upperColoredView.backgroundColor = .cyan
            print("identifier error")
        }
    }
    
    func detailViewSetup(for operation: String, button: UIButton, backgroundColor: UIColor, accentColor: UIColor) {
        upperColoredView.layer.borderWidth = 5.5
        upperColoredView.layer.cornerRadius = 8
        
        upperColoredView.backgroundColor = backgroundColor
        upperColoredView.layer.borderColor = accentColor.cgColor
        operatorTypeLabel.text = operation
        operatorTypeLabel.textColor = accentColor
        operatorTypeLabel.makeFontFitWidth()
        
//        button.backgroundColor = backgroundColor
//        button.layer.cornerRadius = 8
////        button.layer.borderWidth = 2
//        button.layer.borderColor = accentColor.cgColor
//        button.setTitleColor(accentColor, for: .normal)
        
        button.applyGradient(colors: [backgroundColor.cgColor, accentColor.cgColor])
        
 
    }
    
    @IBAction func difficultySwitched(_ sender: Any) {
        let status = difficultyStatus.titleForSegment(at: difficultyStatus.selectedSegmentIndex)
//        let generatorResults = EquationGenerator().generateNewEquation()
//        equationExampleLabel.text = status
        
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as? GameViewController
        
        let statusOnLeave = difficultyStatus.titleForSegment(at: difficultyStatus.selectedSegmentIndex)
        let requestedProblemSet = requestProblemSetControl.titleForSegment(at: requestProblemSetControl.selectedSegmentIndex)
        
        vc.self?.requestedProblemSet = Int(requestedProblemSet!) ?? 7
        
        vc.self?.timerEnabled = timerSwitch.isOn ? true : false
        
        switch statusOnLeave {
        case "Easy":
            vc.self?.equationGenerator.difficulty = .easy
        case "Medium":
            vc.self?.equationGenerator.difficulty = .medium
        case "Hard":
            vc.self?.equationGenerator.difficulty = .hard
        default:
            print("Console Log: (ERROR) reached default case in prepare()")
            vc.self?.equationGenerator.difficulty = .none
        }
        
        switch masterSegueID {
            case "Addition":
                vc.self?.equationGenerator.operationType = .addition
            case "Subtraction":
                vc.self?.equationGenerator.operationType = .subtraction
            case "Multiplication":
                vc.self?.equationGenerator.operationType = .multiplication
            case "Division":
                vc.self?.equationGenerator.operationType = .division
            default:
                print("ERRORROROROR and stuff ufh idk im tired") //excellent error handling here.
        }
        
        
    }

}
