//
//  SpeedGradientGenerator.swift
//  BikeBuddy
//
//  Created by Edan on 2/21/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
import UIKit

struct Color {
    var red: Double
    var green: Double
    var blue: Double
}

struct SpeedGradientGenerator {
    private let initialColor = Color(red: 100, green: 100, blue: 100)
    private let minSpeed: Double = 0
    private let endColor: Color
    private let stepSize: Double
    private let maxSpeed: Double
    
    private var colorsForSpeed = [Double: Color]()
    private var stepSizes: (Double, Double, Double)!
    
    init(_ endColor: Color, _ stepSize: Int, _ maxSpeed: Int) {
        self.endColor = endColor
        self.stepSize = Double(stepSize)
        self.maxSpeed = Double(maxSpeed)
        generateColorTable()
    }
    
    mutating private func generateColorTable() {
        var currentColor = initialColor
        let colorDiff = Color(red: initialColor.red - endColor.red, green: initialColor.green - endColor.green, blue: initialColor.blue - endColor.blue)
        let stepSizes = (colorDiff.red/stepSize, colorDiff.green/stepSize, colorDiff.blue/stepSize)
        for i in stride(from: minSpeed, through: maxSpeed, by: maxSpeed/stepSize) {
            let speed = i.rounded(toPlaces: 2)
            colorsForSpeed[speed] = Color(red: currentColor.red/100.0, green: currentColor.green/100.0, blue: currentColor.blue/100.0)
            currentColor.red -= stepSizes.0
            currentColor.green -= stepSizes.1
            currentColor.blue -= stepSizes.2
        }
    }
    
    func colorForSpeed(speed: Double) -> UIColor {
        var result: UIColor
        let speedInMPH = speed * 2.237
        let roundedSpeed = speedInMPH.rounded(toPlaces: 2)
        if let color = colorsForSpeed[roundedSpeed] {
            result = UIColor(displayP3Red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: 1)
        } else {
            result = UIColor.red
        }
        return result
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
