import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var greeting = "Work Item"


class DispatchWorkItem1 {
    
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create() {
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Task finish")
        }
        
        print("try")
        queue.async(execute: workItem)
        
    }
    
}

//let dispatch = DispatchWorkItem1()
//dispatch.create()

class DispatchWorkItem2 {
    
    private let queue = DispatchQueue(label: "DispatchWorkItem1")
    
    func create() {
        
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task1")
        }
        
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start work item task 3")
        }
        
        queue.async(execute: workItem)
        
    }
    
}


//let dis2 = DispatchWorkItem2()
//dis2.create()

var view = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))

imageView.backgroundColor = .systemYellow
imageView.contentMode = .scaleAspectFit
view.addSubview(imageView)

PlaygroundPage.current.liveView = view

let imageURL = URL(string: "https://blog.soundcloud.com/wp-content/uploads/2011/11/kitten2.jpg")!

// classic

func fetchImage() {
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        if let data = try? Data(contentsOf: imageURL) {
            DispatchQueue.main.async{
                imageView.image = UIImage(data: data)
            }
        }
    }
}

// fetchImage()

// 2 DispatchWorkItem

func fetchImage2() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageURL)
        print(Thread.current)
    }
    
    queue.async(execute: workItem)
    
    workItem.notify(queue: DispatchQueue.main) {
        if let imageData = data {
            imageView.image = UIImage(data: imageData)
        }
    }
    
    
    
}

//fetchImage2()

//# 3 URLSession


func fetchImage3() {
    let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
        print(Thread.current)
        if let imageData = data {
            DispatchQueue.main.async {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    task.resume()
    
}

fetchImage3()

