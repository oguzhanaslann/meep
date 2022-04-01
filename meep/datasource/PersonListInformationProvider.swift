//
//  PersonListInformationProvider.swift
//  meep
//
//  Created by Oğuzhan Aslan on 25.03.2022.
//

import Foundation

protocol PersonListInformationProvider {
    func getPersonList() -> [Person]
}
