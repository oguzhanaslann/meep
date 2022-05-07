//
//  SearchResultProvider.swift
//  meep
//
//  Created by Oğuzhan Aslan on 6.05.2022.
//

import Foundation

protocol SearchResultProvider {
    func searchPersonWithName(name : String,onLoading : @escaping () -> Void,onComplation : @escaping  (AnyResult<[Person]>) -> Void)
}
