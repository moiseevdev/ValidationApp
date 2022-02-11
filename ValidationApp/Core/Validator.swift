//
//  Validator.swift
//  ValidationApp
//
//  Created by Андрей Моисеев on 11.02.2022.
//

import Foundation

protocol ValidatorStrategy {
    func validate(_ text: String) -> Bool
}

struct Validator {
    
    let strategy: ValidatorStrategy

    func validate(_ text: String) -> Bool {
        strategy.validate(text)
    }
}

struct EmailStrategy: ValidatorStrategy {
    
    func validate(_ text: String) -> Bool {
        let inputRegEx = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[A-Za-z]{2,64}"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with: text)
    }
}

struct PasswordStratgy: ValidatorStrategy {
    
    func validate(_ text: String) -> Bool {
        let inputRegEx = "^[A-Za-z0-9]{8,}$"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with: text)
    }
}
