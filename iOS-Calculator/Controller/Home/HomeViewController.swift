//
//  HomeViewController.swift
//  iOS-Calculator
//
//  Created by Valerio Colantonio on 22/7/21.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var operatorSubstraction: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Button Actions
    @IBAction func operatorACAction(_ sender: UIButton) {
    }
    
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
    }
    
    @IBAction func operatorResultAction(_ sender: UIButton) {
    }
    
    @IBAction func operatorAdditionAction(_ sender: UIButton) {
    }
    
    @IBAction func operatorSubstractionAction(_ sender: UIButton) {
    }
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
    }
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        print(sender.tag)
    }
}
