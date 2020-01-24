//
//  DurationTimer.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation

class DurationTimer {
    var delegate: DurationTimerDelegate?
    
    private var initialTime: Date!
    private var timer: Timer!
    private var currentDuration: TimeInterval?
    
    var totalDuration: TimeInterval? {
        return currentDuration
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerDidUpdate), userInfo: nil, repeats: true)
        initialTime = Date()
    }
    
    func stop() {
        timer.invalidate()
    }
    
    @objc private func timerDidUpdate() {
        let now = Date()
        currentDuration = now.timeIntervalSince(initialTime)
        delegate?.durationDidUpdateWith(currentDuration!)
    }
}

protocol DurationTimerDelegate {
    func durationDidUpdateWith(_ time: TimeInterval)
}
