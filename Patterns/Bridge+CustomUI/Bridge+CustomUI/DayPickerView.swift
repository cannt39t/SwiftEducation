//
//  DayPickerView.swift
//  Bridge+CustomUI
//
//  Created by Илья Казначеев on 02.02.2023.
//


//extension ViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        UITableViewCell()
//    }
//
//}

import UIKit


protocol DayPickerViewDataSource {
    
    func dayPickerCount(_ dayPicker: DayPickerView) -> Int
    func dayPickerTitle(_ dayPicker: DayPickerView, indexPath: IndexPath) -> String
    
}

protocol DayPickerViewDelegate {
    
    func dayPickerView(_ dayPickerView: DayPickerView, didSelectDayAtIndex index: Int)
    
}

class DayPickerView: UIControl {
    
    public var dataSource: DayPickerViewDataSource? {
        didSet {
            setupView()
        }
    }
    
    public var delegate: DayPickerViewDelegate?
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = self.bounds
    }
    
    func setupView() {
        let count = dataSource?.dayPickerCount(self)
        
        for item in 0..<count! {
            let indexPath = IndexPath(row: item, section: 0)
            let title = dataSource?.dayPickerTitle(self, indexPath: indexPath)
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tag = item
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectedBetton), for: .touchUpInside)
            buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    @objc func selectedBetton(sender: UIButton) {
        for b in buttons {
            b.isSelected = false
        }
        let index = sender.tag
        let button = buttons[index]
        button.isSelected = true
        delegate?.dayPickerView(self, didSelectDayAtIndex: index)
    }
        
}
