import UIKit

var greeting = "Hello, playground"

public protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    public func copy() -> Self {
        return type(of: self).init(self)
    }
}

class Person: Copying {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    required convenience init(_ prototype: Person) {
        self.init(name: prototype.name)
    }
    
//    // Прототип, клон
//
//    func clone() -> Person {
//        return Person(name: self.name)
//    }
}

var person1 = Person(name: "Jim")

var person2 = person1.copy()
person2.name = "Jack"

print(person1 === person2)
