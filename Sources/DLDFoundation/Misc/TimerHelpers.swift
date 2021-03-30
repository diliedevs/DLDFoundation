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
    /// Creates and schedules a timer on the current run loop in the default mode.
    ///
    /// - Parameters:
    ///   - action: The action-message selector to send to `target` when the timer fires.
    ///   - target: The object to which to send the message specified by `action` when the timer fires. The timer maintains a strong reference to `target` until it (the timer) is invalidated.
    ///   - delay: The number of seconds between firings of the timer. If `delay` is less than or equal to `0.0`, this method chooses the nonnegative value of `0.1` milliseconds instead.
    ///   - repeats: If `true`, the timer will repeatedly reschedule itself until invalidated. If `false` (default), the timer will be invalidated after it fires.
    ///   - userInfo: The user info for the timer. The timer maintains a strong reference to this object until it (the timer) is invalidated. This parameter may be `nil`.
    @discardableResult
    class func delayAction(_ action: Selector, on target: Any, for delay: TimeInterval = 0.0, repeating repeats: Bool = false, withInfo userInfo: Any? = nil) -> Timer {
        Timer.scheduledTimer(timeInterval: delay, target: target, selector: action, userInfo: userInfo, repeats: repeats)
    }
    
    /// Creates and schedules a timer on the current run loop in the default mode
    ///
    /// - Parameters:
    ///   - delay: The number of second between firings of the timer. If `delay` is less than or equal to `0.0`, this method chooses the nonnegative value of `0.1` milliseconds instead.
    ///   - block: A block to be executed when the timer fires.
    @available(iOS 10.0, OSX 10.12, *)
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
    @available(iOS 10.0, OSX 10.12, *)
    @discardableResult
    class func every(_ interval: TimeInterval = 0.0, perform block: @escaping (Timer) -> Void) -> Timer {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            block(timer)
        }
    }
    
    @available(OSX 10.15, iOS 13.0, *)
    static func autoPublish(every interval: TimeInterval, tolerance: TimeInterval? = nil, on runLoop: RunLoop, in mode: RunLoop.Mode, options: RunLoop.SchedulerOptions? = nil) -> Publishers.Autoconnect<Timer.TimerPublisher> {
        publish(every: interval, tolerance: tolerance, on: runLoop, in: mode, options: options).autoconnect()
    }
}

@available(OSX 10.15, iOS 13.0, *)
public extension Publishers.Autoconnect {
    func cancel() {
        upstream.connect().cancel()
    }
}

public extension Selector {
    
    /// Delays sending the selector to the given target after the specified seconds have elapsed.
    ///
    /// - Parameters:
    ///   - target: The target object to which to send the selector when the timer delay has elapsed.
    ///   - time: The number of seconds to delay the timer. If `delay` is less than or equal to `0.0`, this method chooses the nonnegative value of `0.1` milliseconds instead.
    func delay(on target: Any, for time: TimeInterval = 0.0) {
        Timer.delayAction(self, on: target)
    }
}
