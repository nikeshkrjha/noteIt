//
//  DateUtils.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case yyyyMMdd = "yyyy-MM-dd"
}

public struct DateUtils {
    
    static func getDateInString(format: DateFormat, date: Date = Date()) -> String{
        let formatter = DateFormatter()
        switch format {
        case .yyyyMMdd:
            formatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        default:
            formatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        }
        
        return formatter.string(from: date)
    }
    
}
