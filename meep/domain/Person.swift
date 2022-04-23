//
//  Person.swift
//  meep
//
//  Created by Oğuzhan Aslan on 20.03.2022.
//

import Foundation

struct Person {
    let id: String
    let firstName: String
    let lastName : String
    let age: String
    let image: String
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
}
