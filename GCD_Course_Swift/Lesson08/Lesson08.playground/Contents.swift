import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VC1"
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
    }
    
    @objc func pressAction() {
        let vc = MyViewController2()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initButton()
    }
    
    private func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("press", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
    }
    
}

class MyViewController2: UIViewController {
    
    var image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VC2"
        view.backgroundColor = .white
        
        loadPhoto()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImage()
    }
    
    private func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = self.view.center
        self.view.addSubview(image)
    }
    
    private func loadPhoto() {
        let imageURL: URL = URL(string: "https://blog.soundcloud.com/wp-content/uploads/2011/11/kitten2.jpg")!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    
}

let vc = MyViewController()
let navBar = UINavigationController(rootViewController: vc)
navBar.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)

PlaygroundPage.current.liveView = navBar
PlaygroundPage.current.needsIndefiniteExecution = true
