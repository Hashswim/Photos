//
//  RandomDate.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/13/24.
//

import Foundation

extension Date {

    var random: Date {
        randomDate(start: Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
                   end: Date())
    }

    var toString: String {
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy년 MM월 dd"

        let convertStr = myDateFormatter.string(from: self)
        return convertStr
    }

    private func randomDate(start: Date, end: Date) -> Date {
        let timeInterval = end.timeIntervalSince(start)
        let randomInterval = TimeInterval(arc4random_uniform(UInt32(timeInterval)))
        return start.addingTimeInterval(randomInterval)
    }
}
