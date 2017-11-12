//
//  Expenses.swift
//  MyMoneyJournal
//
//  Created by Hitender Thejaswi on 11/12/17.
//  Copyright © 2017 Hitender Thejaswi. All rights reserved.
//

import Foundation
import os.log


class Expenses : NSObject, NSCoding {
    
    var dateOfExpense : String = ""
    var forWhat : String = ""
    var howMuch : Int = 0
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("expenses")
    
    init?(dateOfExpense : String, forWhat : String, howMuch : Int) {
        
        self.dateOfExpense = dateOfExpense
        self.forWhat = forWhat
        self.howMuch = howMuch
        
    }
    
    struct PropertyKey {
        
        static let dateOfExpense = "dateOfExpense"
        static let forWhat = "forWhat"
        static let howMuch = "howMuch"
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(dateOfExpense, forKey: PropertyKey.dateOfExpense)
        aCoder.encode(forWhat, forKey: PropertyKey.forWhat)
        aCoder.encode(howMuch, forKey: PropertyKey.howMuch)
    }
    
    required convenience init?(coder aDecoder : NSCoder) {
        
        guard let dateOfExpense = aDecoder.decodeObject(forKey: PropertyKey.dateOfExpense) as? String
        
            else {
                os_log("Unable to decode the date of the expense entered.", log: OSLog.default, type: .debug)
                return nil
            }
        
        let forWhat = aDecoder.decodeObject(forKey: PropertyKey.forWhat) as? String
        
        let howMuch = aDecoder.decodeInteger(forKey: PropertyKey.howMuch)
        
        self.init(dateOfExpense : dateOfExpense, forWhat : forWhat!, howMuch : howMuch)
    }
}
