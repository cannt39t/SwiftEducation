//
//  ViewController.swift
//  AvitoTest
//
//  Created by Илья Казначеев on 01.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = .init(frame: .zero, style: .grouped)
    
    var company = Company(name: "", employees: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        loadEmployee()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        company.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? EmployeeTableViewCell
        else {
            fatalError("Could not deque cell of type \(EmployeeTableViewCell.self)")
        }

        let item = company.employees[indexPath.item]
        cell.setEmployee(name: item.name, phone: item.phoneNumber, skills: item.skills)
        return cell
    }
    
    private func setupTable(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        tableView.dataSource = self
        tableView.reloadData()
        tableView.delegate = self
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "MyCell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func loadEmployee() {
        Task {
            await getDataFromJSON()
            self.company.employees = self.company.employees.sorted(by: { $0.name < $1.name })
            tableView.reloadData()
        }
    }
    
    func getDataFromJSON() async {
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            return
        }
        
        let cache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        URLCache.shared = cache
        var urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataDontLoad)
        urlRequest.timeoutInterval = 3600
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(Response.self, from: data)
            self.company = response.company
        } catch {
        }
    }
    
}

// MARK: - Response
struct Response: Codable {
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    var employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name, phoneNumber: String
    let skills: [String]
}




