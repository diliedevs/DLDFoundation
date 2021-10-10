//
//  TimerHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation
import Combine

public extension Timer {
    /// Creates and schedules a timer on the current run loop in the default mode
    ///
    /// - Parameters:
    ///   - delay: The number of second between firings of the timer. If `delay` is less than or equal to `0.0`, this method chooses the nonnegative value of `0.1` milliseconds instead.
    ///   - block: A block to be executed when the timer fires.
    @discardableResult
    class func after(_ delay: TimeInterval = 0.0, perform block: @escaping () -> Void) -> Timer {
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { timer in
            block()
            timer.invalidate()
        }
    }
    /// Creates and schedules a timer on the current run loop in the default mode
    ///
    /// - Parameters:
    ///   - interval: The number of second between firings of the timer. If `interval` is less than or equal to `0.0`, this method chooses the nonnegative value of `0.1` milliseconds instead.
    ///   - block: A block to be executed when the timer fires.
    @discardableResult
    class func every(_ interval: TimeInterval = 0.0, perform block: @escaping (Timer) -> Void) -> Timer {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            block(timer)
        }
    }
    
    static func autoPublish(every interval: TimeInterval, tolerance: TimeInterval? = nil, on runLoop: RunLoop, in mode: RunLoop.Mode, options: RunLoop.SchedulerOptions? = nil) -> Publishers.Autoconnect<Timer.TimerPublisher> {
        publish(every: interval, tolerance: tolerance, on: runLoop, in: mode, options: options).autoconnect()
    }
}

public extension Publishers.Autoconnect {
    /// Cancels the publisher's activity.
    func cancel() {
        upstream.connect().cancel()
    }
}
