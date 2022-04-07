//
//  RandomUserClient.swift
//  meep
//
//  Created by Oğuzhan Aslan on 2.04.2022.
//

import Foundation

class RandomUserClient: PeopleNetworkAPI {
    func fetchPeopleList(onLoading: @escaping () -> Void, onComplation: @escaping (AnyResult<APIResponse>) -> Void) -> AnyResult<APIResponse> {
        return fetchResult(
            url: "https://randomuser.me/api/?results=10",
            onLoading: onLoading,
            onComplation: onComplation,
            method: .get,
            parameters: nil
        )
    }
    

}
