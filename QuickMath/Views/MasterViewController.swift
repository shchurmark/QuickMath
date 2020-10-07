//
//  ViewController.swift
//  QuickMath
//
//  Created by Mark ⠀ on 8/10/20.
//  Copyright © 2020 Mark ⠀. All rights reserved.
//

//TODO: MASS REFACTOR CODE.

import UIKit

class MasterViewController: UIViewController {
    @IBOutlet var additionButton: UIButton!
    @IBOutlet var subtractionButton: UIButton!
    @IBOutlet var multiplicationButton: UIButton!
    @IBOutlet var divisionButton: UIButton!
    @IBOutlet var homeTabBar: UITabBarItem!
    
    var pallet = CustomColorSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. 94,195,82
        buttonColorSetup()
        
        
    }
    
    func buttonColorSetup() {
        // a bit of a tedious implementation, but a work around for **custom** colors.
        individualButtonSetup(for: additionButton, backgroundColor: pallet.darkGreen, accentColor: pallet.lightGreen)
        individualButtonSetup(for: subtractionButton, backgroundColor: pallet.darkRed, accentColor: pallet.lightRed)
        individualButtonSetup(for: multiplicationButton, backgroundColor: pallet.darkBlue, accentColor: pallet.lightBlue)
        individualButtonSetup(for: divisionButton, backgroundColor: pallet.darkYellow, accentColor: pallet.lightYellow)
    }
    
    func individualButtonSetup(for button: UIButton, backgroundColor: UIColor, accentColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = accentColor.cgColor
        button.setTitleColor(accentColor, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Passing segue id into DetailViewController to prepare relevant colors and text.
        let vc = segue.destination as? DetailViewController
        vc.self!.masterSegueID = segue.identifier ?? "empty"
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        //empty

    }
    
    @IBAction func gotoGhostPlay(_ sender: Any) {
        additionButton.titleLabel?.text = "Easter egg"
    }
    


}

