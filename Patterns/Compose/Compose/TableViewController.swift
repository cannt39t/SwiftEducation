//
//  TableViewController.swift
//  Compose
//
//  Created by Илья Казначеев on 28.01.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var currentFolder: Compose = Folder(name: "Main")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func addFileBarButton(_ sender: Any) {
        currentFolder.addComponent(component: File(name: "New File"))
        tableView.reloadData()
    }
    
    @IBAction func addFolderBarButton(_ sender: Any) {
        currentFolder.addComponent(component: Folder(name: "New Folder"))
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentFolder.contentCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let contents = currentFolder.showContent() as? [Compose] else {
            fatalError()
        }
        let item = contents[indexPath.item]
        var configuration = UIListContentConfiguration.subtitleCell()
        configuration.text = item.name
        configuration.secondaryText = item is Folder ? "Folder" : "File"
        configuration.image = item is Folder ? UIImage(systemName: "folder")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal) :  UIImage(systemName: "doc.text")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        cell.contentConfiguration = configuration
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController
        guard let contents = currentFolder.showContent() as? [Compose] else {
            fatalError()
        }
        let item = contents[indexPath.item]
        vc!.currentFolder = item
        item is Folder ? showFolder(vc: vc!) : print(item.showContent())
    }
    
    func showFolder(vc : TableViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }


}
