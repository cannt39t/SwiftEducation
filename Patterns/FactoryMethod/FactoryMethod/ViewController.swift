//
//  ViewController.swift
//  FactoryMethod
//
//  Created by Илья Казначеев on 13.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var exerciseArray = [Exercise]()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let emptyView = UIView()
    
    private let gradientLayer = CAGradientLayer()
    private let colors = [UIColor.systemPink.cgColor, UIColor.blue.cgColor]
    private var currentColorIndex = 0
    private let animationDuration: CFTimeInterval = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, primaryAction: nil, menu: demoMenu)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Exercises"
        
        setupTableView()
        setupEmptyView()
        setupRefreshController()
        
        setupGradientLayer()
        animateGradient()
        
        sparklesButtonTapped()
    }
    
    @objc func sparklesButtonTapped() {
        // Create the emitter layer
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.frame.midX, y: view.frame.maxY)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)

        // Create the sparkles cell
        let sparkles = CAEmitterCell()
        sparkles.contents = UIImage(systemName: "volleyball")?.cgImage
        sparkles.birthRate = 20
        sparkles.lifetime = 20.0
        sparkles.velocity = 50
        sparkles.emissionRange = .pi / 4
        sparkles.scale = 0.2
        sparkles.scaleRange = 0.05
        sparkles.spin = .pi
        emitter.emitterCells = [sparkles]

        // Add the emitter layer to the view
        view.layer.addSublayer(emitter)

        // Start the animation
        emitter.beginTime = CACurrentMediaTime()
    }
    
    private func setupGradientLayer() {
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func animateGradient() {
        let fromColors = gradientLayer.colors
        let toColors = [colors[currentColorIndex], colors[currentColorIndex ^ 1]]
        currentColorIndex ^= 1
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = animationDuration
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        gradientLayer.add(animation, forKey: "gradientAnimation")
    }
    
    func setupEmptyView() {
        emptyView.backgroundColor = .systemRed
        let label = UILabel()
        label.text = "No data available"
        label.textAlignment = .center
        emptyView.addSubview(label)
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -120),
            label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
        ])
    }
    
    func setupRefreshController() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching data...")
        tableView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func createExercise(exName: Exercises) {
        let newExercise = FactoryExercises.defaultFactory.createExercise(name: exName)
        exerciseArray.append(newExercise)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if exerciseArray.count == 0 {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = exerciseArray[indexPath.item]
        var configuration = UIListContentConfiguration.valueCell()
        configuration.text = item.name
        configuration.secondaryText = item.type
        cell.contentConfiguration = configuration
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func setupTableView() {
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        tableView.addSubview(emptyView)
        emptyView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.reloadData()
    }
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Jumping", image: UIImage(systemName: "figure.jumprope"), handler: { (_) in
                self.createExercise(exName: .jumping)
            }),
            UIAction(title: "Squarts", image: UIImage(systemName: "figure.arms.open"), handler: { (_) in
                self.createExercise(exName: .squarts)
            }),
            UIAction(title: "Push-ups", image: UIImage(systemName: "figure.strengthtraining.traditional"), handler: { (_) in
                self.createExercise(exName: .pushups)
            })
        ]
    }

    var demoMenu: UIMenu {
        return UIMenu(image: .add, identifier: nil, options: [], children: menuItems)
    }
    
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let basicAnim = anim as? CABasicAnimation, flag {
            gradientLayer.colors = basicAnim.toValue as? [CGColor]
            animateGradient()
        }
    }
}

