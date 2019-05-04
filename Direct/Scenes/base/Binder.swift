//
//  Binder.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
typealias CompletionHandler = (() -> Void)
final class DynamicValue<T> {
    var value: T {
        didSet {
            notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: T) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        addObserver(observer, completionHandler: completionHandler)
        notify()
    }

    private func notify() {
        observers.forEach({ $0.value() })
    }

    deinit {
        observers.removeAll()
    }
}
