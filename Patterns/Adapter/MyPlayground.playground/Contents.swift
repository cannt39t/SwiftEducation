import UIKit

protocol BirdProtocol {
    func sing()
    func fly()
}

class Bird: BirdProtocol {
    func sing() {
        print("tew-tew")
    }
    
    func fly() {
        print("im flying")
    }
}

class Raven {
    func flySearchAndDestroy() {
        print("im raven fly")
    }
    
    func voice() {
        print("car car")
    }
}

func makeTheBirdTest(bird : BirdProtocol) {
    bird.fly()
    bird.sing()
}

class RavenAdapter: BirdProtocol {
    private var raven: Raven
    
    init(adaptee: Raven) {
        self.raven = adaptee
    }
    
    func sing() {
        raven.voice()
    }
    
    func fly() {
        raven.flySearchAndDestroy()
    }
}

let simpleBird = Bird()
let simpleRaven = Raven()
let adapterRaven = RavenAdapter(adaptee: simpleRaven)
makeTheBirdTest(bird: simpleBird)
makeTheBirdTest(bird: adapterRaven)
