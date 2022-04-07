//
//  PersonRepository.swift
//  meep
//
//  Created by Oğuzhan Aslan on 25.03.2022.
//

import Foundation

class PeopleRepository : PeopleListInformationProvider {
    
    private let peopleLocalAPI : PeopleLocalAPI
    private let peopleNetworkAPI : PeopleNetworkAPI
    
    init(peopleLocalAPI : PeopleLocalAPI,peopleNetworkAPI : PeopleNetworkAPI){
        self.peopleLocalAPI = peopleLocalAPI
        self.peopleNetworkAPI = peopleNetworkAPI
    }
    
    
    func getPersonList(
        onLoading : @escaping () -> Void,
        onComplation : @escaping  (AnyResult<[Person]>) -> Void
    ) {
       
        peopleNetworkAPI.fetchPeopleList(onLoading: onLoading, onComplation: { result in
          
            let peopleResult:  AnyResult<[Person]> =  result.map { apiResponse in
                var people : [Person] = []
              
                
                if  let apiResponse = result.value {
                    apiResponse.results?.forEach({ result  in
                        people.append(
                            Person(
                                id: result.id?.name ?? "",
                                fullName: ("\(result.name?.first ?? "") \(result.name?.last ?? "")"),
                                age: String(result.dob?.age ?? 0),
                                image: String(result.picture?.thumbnail ?? "")
                            )
                        )
                    })
                   
                }
                return AnyResult.success(people)
            }
            
            onComplation(peopleResult)
        })
       
    }
}
