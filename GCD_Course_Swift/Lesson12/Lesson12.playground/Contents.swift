import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let imagesURL = ["https://images.all-free-download.com/images/graphiclarge/kitten_206705.jpg",
                 "https://images.all-free-download.com/images/graphiclarge/funny_cat_194619.jpg",
                 "https://upload.wikimedia.org/wikipedia/commons/c/c9/Cat.jpeg",
                 "https://cdn.vox-cdn.com/uploads/chorus_asset/file/22438416/cat.jpeg",
                 "https://m.media-amazon.com/images/I/51ZjBEW+qNL._AC_UF894,1000_QL80_.jpg",
                 "http://images4.fanpop.com/image/photos/23200000/kitty-softpaws-puss-in-boots-23247611-425-389.jpg",
                 "https://www.lovethispic.com/uploaded_images/253710-White-Adorable-Kitty.jpg",
                 "https://i.pinimg.com/550x/1c/75/bc/1c75bc1d65f58145ef0375f9287cb4bd.jpg"
                ]

let theme = "Dispatch Group"

class DispatchGroupTest {
    
    private let queueSerial = DispatchQueue(label: "serial")
    
    private let groupRed = DispatchGroup()
    
    func loadInfo() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("2")
        }
        
        groupRed.notify(queue: .main) {
            print("ended")
        }
        
    }
    
}

//let test = DispatchGroupTest()
//test.loadInfo()


class DispatchGroupTest2 {
    
    private let queue = DispatchQueue(label: "concurent", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        groupBlack.enter()
        queue.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        
        groupBlack.enter()
        queue.async {
            sleep(2)
            print("2")
            self.groupBlack.leave()
        }
        
        groupBlack.wait()
        
        print("eneded")
        
        groupBlack.notify(queue: .main) {
            print("group black is done")
        }
        
    }
    
}

//let test = DispatchGroupTest2()
//test.loadInfo()

class EightImage: UIView {
    
    public var ivs = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 300, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

var view = EightImage(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = .systemOrange

var images = [UIImage]()

PlaygroundPage.current.liveView = view

func asyncLoadImages(imageUrl: URL, runQueue: DispatchQueue, complitionQueue: DispatchQueue, complition: @escaping (UIImage?, Error?) -> ()) {
    runQueue.async {
        print(Thread.current)
        do {
            let data = try Data(contentsOf: imageUrl)
            complitionQueue.async {
                print(Thread.current)
                complition(UIImage(data: data), nil)
            }
        } catch let error {
            complitionQueue.async {
                complition(nil, error)
            }
        }
    }
}

func asyncGroup() {
    let aGroup = DispatchGroup()
    
    for i in 0...3 {
        aGroup.enter()
        asyncLoadImages(imageUrl: URL(string: imagesURL[i])!,
                        runQueue: .global(),
                        complitionQueue: .main) { (result, error) in
                            guard let image = result else {
                                return
                            }
                            images.append(image)
                            aGroup.leave()
                        }
    }
    
    aGroup.notify(queue: .main) {
        for i in 0...3 {
            view.ivs[i].image = images[i]
        }
    }
}




func asyncUrlSession() {
    for i in 4...7 {
        let url = URL(string: imagesURL[i - 4])
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                view.ivs[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

asyncGroup()
asyncUrlSession()

