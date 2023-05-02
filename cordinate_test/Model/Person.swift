//
//  Person.swift
//  cordinate_test
//
//  Created by 최진용 on 2023/04/27.
//

import Foundation
import Combine

struct Person {
    var name: String
    var age: String
    var occupation: String
    var isValid: Bool {
        !name.isEmpty && !age.isEmpty && !occupation.isEmpty
    }
    var message: String {
        return "\(name), \(age), \(occupation)"
    }
}
