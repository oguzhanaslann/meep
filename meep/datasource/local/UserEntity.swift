//
//  UserEntity.swift
//  meep
//
//  Created by Oğuzhan Aslan on 10.04.2022.
//

import Foundation

struct UserEntity {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let birthdate: String
    let phone: String
    let profilePhoto: String
    let latitude: String
    let longitude: String
    let state: String
    let street: String
    let city: String
}


extension UserEntity {
    func toPerson() -> Person {
        return Person(id: self.id, firstName: self.firstName, lastName: self.lastName, age: String(age()) , image: self.profilePhoto)
    }
    
    
    private func age() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DOB_FORMAT
        let theDate = dateFormatter.date(from: self.birthdate)!
        
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: theDate)
        let yearAsInt = Int(year) ?? 0
        
        let currentDate = Date()
        let currentYear = dateFormatter.string(from: currentDate)
        let currentYearsInt = Int(currentYear) ?? 0
        
        let age = currentYearsInt - yearAsInt
        return age
    }
    
    func fullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    func address() -> String {
        return "\(self.state) \(self.street) \(self.city)"
    }
}
