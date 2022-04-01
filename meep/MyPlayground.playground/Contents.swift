import UIKit
import Combine

let subject = PassthroughSubject<[Person], Never>()
//let anySubscriber =  AnySubscriber(subject)
let publisher = subject.eraseToAnyPublisher()

subject.sink { ints in
    print("ints \(ints)")
}

//subject.send([1,2,3])

//publisher.receive(subscriber: anySubscriber)
//
publisher.sink { ints in
    print("publisher ints \(ints)")
}

subject.send(PersonRepository().getPersonList())

