//
//  EmployeeTableViewCell.swift
//  AvitoTest
//
//  Created by Илья Казначеев on 01.01.2023.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    private var nameLabel = UILabel()
    private var phoneLabel = UILabel()
    private var skillsLabel = UILabel()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    private func setup() {
        // FONTs
        nameLabel.font = UIFont(name: "Comic Sans", size: 20)
        phoneLabel.font = UIFont(name: "System", size: 20)
        skillsLabel.font = UIFont(name: "Arial", size: 14)
        
        // TEXT_COLORs
        nameLabel.textColor = .black
        phoneLabel.textColor = .black
        skillsLabel.textColor = .systemGray
        
        let namePlusSkills = UIStackView(
            arrangedSubviews: [ nameLabel, skillsLabel ]
        )
        namePlusSkills.axis = .vertical
        namePlusSkills.spacing = 5
        
        contentView.addSubview(namePlusSkills)
        contentView.addSubview(phoneLabel)
        namePlusSkills.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            namePlusSkills.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            namePlusSkills.trailingAnchor.constraint(equalTo: phoneLabel.leadingAnchor, constant: -10),
            namePlusSkills.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            namePlusSkills.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            phoneLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -75),
            phoneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            phoneLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            phoneLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    public func setEmployee(name: String, phone: String, skills: [String]) {
        nameLabel.text = name
        phoneLabel.text = phone
        skillsLabel.text = skills.joined(separator: ", ")
    }

}
