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
    
    // MARK: - Variables
    private var operationData = OperationData()
    private var isADecimalValue = false
    private var currentOperationType: OperationType = .none
    
    // MARK: - Constants
    private let KDecimalSeparetor = Locale.current.decimalSeparator!
    private let KMaxLength: Int = 9
    private let KToltal = "total"
    
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()

    private let auxTotalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()

    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()

    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumIntegerDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()

    
    private enum OperationType{
        case none, addiction, substraction, multiplication, division, percent
    }
    
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
        
        numberDecimal.setTitle(KDecimalSeparetor, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        roundAllButtons()
    }
    
    // MARK: - Button Actions
    @IBAction func operatorACAction(_ sender: UIButton) {
        cleanAllData()
        
        sender.shineEffect()
    }
    
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
        if currentOperationType != .none {
            operationData.value2 = operationData.value2 * (-1)
            resultLabel.text = printFormatter.string(from: NSNumber(value: operationData.value2 ))
        } else {
            operationData.value1 = operationData.value1 * (-1)
            resultLabel.text = printFormatter.string(from: NSNumber(value: operationData.value1 ))
        }

        sender.shineEffect()
    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        if currentOperationType != .percent{
            calculateFinalResult()
        }
        
        currentOperationType = .percent
        calculateFinalResult()
        
        sender.shineEffect()
    }
    
    @IBAction func operatorResultAction(_ sender: UIButton) {
        calculateFinalResult()
        
        operationData.value1 = 0
        operationData.value2 = 0
        
        sender.shineEffect()
    }

    
    @IBAction func operatorAdditionAction(_ sender: UIButton) {
        executeThe(operation: .addiction)        
        sender.invertColors()
        
        sender.shineEffect()
    }
    
    @IBAction func operatorSubstractionAction(_ sender: UIButton) {
        executeThe(operation: .substraction)
        sender.invertColors()
        
        sender.shineEffect()
    }
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        executeThe(operation: .multiplication)
        sender.invertColors()
        
        sender.shineEffect()
    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        executeThe(operation: .division)
        sender.invertColors()
        
        sender.shineEffect()
    }
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        /*
        let currentTempValue = auxTotalFormatter.string(from: NSNumber(value: tempValue))
        if !isOperationSelected && currentTempValue!.count >= KMaxLength{
            return
        }
        
        resultLabel.text = resultLabel.text! + KDecimalSeparetor
        isADecimalValue = true
        
        higlightSelectedButton()
        
        sender.shineEffect()
 */
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        printVariables()
        
        operatorAC.setTitle("C", for: .normal)
        
        var tempValue = currentOperationType != .none ? operationData.value2 : operationData.value1
        var currentTempValue = auxTotalFormatter.string(from: NSNumber(value: tempValue))
        
        if currentOperationType == .none && currentTempValue!.count >= KMaxLength{
            return
        }
        
        currentTempValue = auxFormatter.string(from: NSNumber(value: tempValue))

        if isADecimalValue{
            currentTempValue = "\(currentTempValue!)\(KDecimalSeparetor)"
            isADecimalValue = false
        }
        
        let number = sender.tag
        tempValue = Double(currentTempValue! + String(number))!
        
        if currentOperationType == .none {
            operationData.value1 = Double(tempValue)
            operationData.value2 = 0
            operationData.total = 0
        } else{
            operationData.value1 =  operationData.total != 0 ?   operationData.total :   operationData.value1
            operationData.value2 =  Double(tempValue)
        }
        
        resultLabel.text = printFormatter.string(from: NSNumber(value: tempValue))

        sender.shineEffect()
        printVariables()
        
    }
    
    // MARK: - Private Methods
    private func roundAllButtons() {
        number0.roundCornerBorders()
         number1.roundCornerBorders()
         number2.roundCornerBorders()
         number3.roundCornerBorders()
         number4.roundCornerBorders()
         number5.roundCornerBorders()
         number6.roundCornerBorders()
         number7.roundCornerBorders()
         number8.roundCornerBorders()
         number9.roundCornerBorders()
         numberDecimal.roundCornerBorders()
        
         operatorAC.roundCornerBorders()
         operatorPlusMinus.roundCornerBorders()
         operatorPercent.roundCornerBorders()
         operatorResult.roundCornerBorders()
         operatorAddition.roundCornerBorders()
         operatorSubstraction.roundCornerBorders()
         operatorMultiplication.roundCornerBorders()
         operatorDivision.roundCornerBorders()
    }
    
    private func cleanAllData(){
        currentOperationType = .none
        operatorAC.setTitle("AC", for: .normal)
        operationData.total = 0
        operationData.value1 = 0
        operationData.value2 = 0
        resultLabel.text = ""
        
        printVariables()
    }
        
    private func executeThe(operation: OperationType) {
        if currentOperationType != .none {
            calculateFinalResult()
        }
        currentOperationType = operation
    }
    
    private func calculateFinalResult(){
        printVariables()
        
        switch currentOperationType {
        case .none:
            break
        case .addiction:
            operationData.total = operationData.value1 + operationData.value2
            break
        case .substraction:
            operationData.total = operationData.value1 - operationData.value2
            break
        case .multiplication:
            operationData.total = operationData.value1 * operationData.value2
            break
        case .division:
            operationData.total = operationData.value1 / operationData.value2
            break
        case .percent:
            operationData.total = operationData.value1/100
            break
        }
        
        if let currentTotal = auxTotalFormatter.string(from: NSNumber(value: operationData.total)), currentTotal.count > KMaxLength{
            resultLabel.text = printScientificFormatter.string(from: NSNumber(value: operationData.total))
        } else {
            resultLabel.text = printFormatter.string(from: NSNumber(value: operationData.total))
        }
        
        currentOperationType = .none
                
        higlightSelectedButton()
        
        UserDefaults.standard.set(operationData.total, forKey: KToltal)
        
        printVariables()
    }

    
    private func higlightSelectedButton(){
        if currentOperationType == .none {
            resetOperationButtons()
        }else{
            switch currentOperationType {
                case .none, .percent:
                    resetOperationButtons()
                    break
                case .addiction:
                    resetOperationButtons()
                    operatorAddition.invertColors()
                    break
                case .substraction:
                    resetOperationButtons()
                    operatorSubstraction.invertColors()
                    break
                case .multiplication:
                    resetOperationButtons()
                    operatorMultiplication.invertColors()
                    break
                case .division:
                    resetOperationButtons()
                    operatorDivision.invertColors()
                    break
            }
        }
    }
    
    private func resetOperationButtons(){
        operatorAddition.resetColors()
        operatorSubstraction.resetColors()
        operatorDivision.resetColors()
        operatorMultiplication.resetColors()
    }
    
    private func printVariables(){
        print("VALUE1: \(operationData.value1)")
        print("VALUE2: \(operationData.value2)")
        print("TOTAL: \(operationData.total)")
        print("\r\n")
    }
}
