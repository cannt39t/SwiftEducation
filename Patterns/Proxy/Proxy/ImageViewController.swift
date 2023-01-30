//
//  ImageViewController.swift
//  Proxy
//
//  Created by Илья Казначеев on 27.01.2023.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    private let url = URL(string: "https://duckstories.net/wp-content/uploads/2020/07/52523-oficial-kupe-mercedes-benz-s-class-coupe-63-amg-kiev-2015-2.jpg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadImage()
    }
    
    func loadImage() {
        let imageService = LoadImageService()
        let proxy = Proxy(service: imageService)
        
        proxy.loadImage(url: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data)
            }
        }
    }
    
    
    @IBAction func pressOnUpdateButton(_ sender: Any) {
        cacheData = nil
        image.image = nil
        loadImage()
    }
    
}
