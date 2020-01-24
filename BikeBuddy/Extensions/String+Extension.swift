//
//  String+Extension.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
extension String {
    func getFormattedTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var secondsString = String()
        var minutesString = String()
        var hoursString = String()
        
        if seconds < 10 {
            secondsString = "0"+String(seconds)
        } else {
            secondsString = String(seconds)
        }
        
        if minutes < 10 {
            minutesString = "0"+String(minutes)
        } else {
            minutesString = String(minutes)
        }
        
        if hours < 10 {
            hoursString = "0"+String(hours)
        } else {
            hoursString = String(hours)
        }
        return hoursString + ":" + minutesString + ":" + secondsString
    }
}
