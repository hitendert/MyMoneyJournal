//
//  DetailExpensesViewController.swift
//  MyMoneyJournal
//
//  Created by Hitender Thejaswi on 11/12/17.
//  Copyright © 2017 Hitender Thejaswi. All rights reserved.
//

import UIKit

protocol ReceiveData {
    
    func receiveUpdatedData(receivingExpenseArray : [Expenses])
}

class DetailExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate : ReceiveData?

    @IBOutlet weak var expenseTableView: UITableView!
    
    var expenseArray2 : [Expenses] = [Expenses]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseTableView.delegate = self
        expenseTableView.dataSource = self
        
        //Registering the XIB File :
        
        expenseTableView.register(UINib(nibName : "CustomCell", bundle : nil), forCellReuseIdentifier: "customExpenseCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customExpenseCell", for: indexPath) as! CustomExpenseCell
        
        cell.dateLabel.text = expenseArray2[indexPath.row].dateOfExpense
        cell.forWhatLabel.text = expenseArray2[indexPath.row].forWhat
        cell.howMuchLabel.text = String(expenseArray2[indexPath.row].howMuch)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return expenseArray2.count
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        delegate?.receiveUpdatedData(receivingExpenseArray: expenseArray2)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            expenseArray2.remove(at: indexPath.row)
            
            expenseTableView.reloadData()
        }
    }
    


}
