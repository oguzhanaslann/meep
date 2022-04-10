//
//  PeopleLocalSource.swift
//  meep
//
//  Created by Oğuzhan Aslan on 2.04.2022.
//

import Foundation


class PeopleLocalSource : PeopleLocalAPI {
    let peopleDB : PeopleDatabase

    init(peopleDb: PeopleDatabase) {
        self.peopleDB = peopleDb
    }
}
