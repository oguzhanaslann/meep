//
//  PersonListInformationProvider.swift
//  meep
//
//  Created by Oğuzhan Aslan on 25.03.2022.
//

import Foundation

protocol PeopleListInformationProvider {
    func getPersonList(onLoading : @escaping () -> Void,onComplation : @escaping  (AnyResult<[Person]>) -> Void)
}
