//
//  String+Extension.swift
//  MovieDBSwift
//
//  Created by Renan Trapp on 29/09/19.
//  Copyright © 2019 Renan Trapp. All rights reserved.
//

import Foundation

extension String {
    var dateFormated: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        
        if let myDate = dateFormatterPrint.date(from: self) {
            dateFormatterPrint.dateFormat = "dd/MM/YYYY"
            
            return  dateFormatterPrint.string(from: myDate)
        }
        return ""
    }
}
