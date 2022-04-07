//
//  PeopleAPI.swift
//  meep
//
//  Created by Oğuzhan Aslan on 2.04.2022.
//

import Foundation
import Alamofire

protocol PeopleNetworkAPI {
    func fetchPeopleList(
         onLoading : @escaping () -> Void,
         onComplation : @escaping  (AnyResult<APIResponse>) -> Void
    )-> AnyResult<APIResponse>
}


enum NetworkingError : Error {
    case stub
}

extension PeopleNetworkAPI {
    internal func fetchResult<T: Codable>(
        url : String,
        onLoading :@escaping () -> Void ,
        onComplation : @escaping  (AnyResult<T>) -> Void,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil
    ) -> AnyResult<T> {
        
        var result : AnyResult<T> = AnyResult.failure(error: NetworkingError.stub)
    
        onLoading()
        
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: Alamofire.JSONEncoding.default
        )
        .validate()
        .response { response in
            print("Call \(method.rawValue), response code :  \(String(describing: response.response?.statusCode))")
          
            switch response.result {
            case .success(let value):
                do {

                    let decodedResult = try JSONDecoder().decode(T.self, from: value!)
                    
                    result = AnyResult.success(decodedResult)
                    onComplation(result)
                    
                } catch {
                    
                    result = AnyResult.failure(error: error)
                    onComplation(result)

                }
                
            case .failure(let error):
                
                result = AnyResult.failure(error : error)
                onComplation(result)
            }
            

        }
        
        return result
    }
}


