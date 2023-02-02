//
//  ViewController.swift
//  Bridge+CustomUI
//
//  Created by Илья Казначеев on 02.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let locationKey = ""
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayPicker: DayPickerView!
    
    var days: Array<String> = {
        var week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        let today = Date()
        print(today)
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let weekdayName = week[weekday - 2]

        if let index = week.firstIndex(of: weekdayName) {
            week = Array(week[index...] + week[..<index])
        }
        return week
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPicker.dataSource = self
        dayPicker.delegate = self
    }

}

extension ViewController: DayPickerViewDataSource {
    func dayPickerCount(_ dayPicker: DayPickerView) -> Int {
        self.days.count
    }
    
    func dayPickerTitle(_ dayPicker: DayPickerView, indexPath: IndexPath) -> String {
        days[indexPath.row]
    }
}

extension ViewController: DayPickerViewDelegate {
    func dayPickerView(_ dayPickerView: DayPickerView, didSelectDayAtIndex index: Int) {
        let selectedDay = days[index]
        print(selectedDay)
    }
}


