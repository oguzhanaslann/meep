//
//  PersonDetailInfoProvider.swift
//  meep
//
//  Created by Oğuzhan Aslan on 29.04.2022.
//

import Foundation

protocol PersonDetailInfoProvider {
    func getPersonDetail(person id : String,onLoading : @escaping () -> Void,onComplation : @escaping  (AnyResult<PersonDetail>) -> Void) 
}
