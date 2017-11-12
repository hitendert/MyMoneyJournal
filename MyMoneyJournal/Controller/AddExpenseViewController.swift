//
//  ViewController.swift
//  MyMoneyJournal
//
//  Created by Hitender Thejaswi on 11/12/17.
//  Copyright © 2017 Hitender Thejaswi. All rights reserved.
//

import UIKit
import os.log


class AddExpenseViewController: UIViewController, ReceiveData {
    
    @IBOutlet weak var forWhatLabel: UITextField!
    @IBOutlet weak var howMuchLabel: UITextField!
    @IBOutlet weak var totalMoneySpentLabel: UILabel!
    
    
    var expenseArray : [Expenses] = [Expenses]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let savedExpenses = loadExpenses() {
            
            expenseArray += savedExpenses
        }
        
        calculateTotalMoneySpent()
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        
    if (forWhatLabel.text != "") && (howMuchLabel.text != "") {
        
     
        
        let date = Date()
        let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        
        let expenses = Expenses(dateOfExpense: result, forWhat: forWhatLabel.text!, howMuch: Int(howMuchLabel.text!)!)
        
        
        
        forWhatLabel.text = ""
        howMuchLabel.text = ""
        
        expenseArray.append(expenses!)
        
        calculateTotalMoneySpent()
        
        saveExpenses()
        
        }
    else {
        
        let alert = UIAlertController(title: "Oops!", message: "Looks like you missed one the fields, Please enter a value to record your expenses", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        }
        
    }
    
  
    @IBAction func clearAllButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure ?", message: "This will delete all the data! This can't be undone !", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
          
            self.expenseArray.removeAll()
            
            self.calculateTotalMoneySpent()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func calculateTotalMoneySpent() {
        
        var totalMoneySpent : Int = 0
        
        for i in 0..<expenseArray.count {
            
            totalMoneySpent = totalMoneySpent + expenseArray[i].howMuch
        }
        
        totalMoneySpentLabel.text = "Rs. \(totalMoneySpent)"
        
    }
    
    @IBAction func viewDetailsPressed(_ sender: Any) {
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destinationVC = segue.destination as! DetailExpensesViewController
            
            destinationVC.expenseArray2 = expenseArray
        
            destinationVC.delegate = self
        
        
    }
    
    func receiveUpdatedData(receivingExpenseArray: [Expenses]) {
        
        expenseArray = receivingExpenseArray
        
        calculateTotalMoneySpent()
        
        saveExpenses()
        
    }
    
    private func saveExpenses() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(expenseArray, toFile: Expenses.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Expenses successfully saved.", log: OSLog.default, type: .debug)
            
        } else {
            os_log("Failed to save expenses..", log: OSLog.default, type: .error)
        }
    }
    

    private func loadExpenses() -> [Expenses]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Expenses.ArchiveURL.path) as? [Expenses]
    }

}






























