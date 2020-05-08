//
//  Cancellable.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol Cancellable {
    var isCancelled: Bool { get }
    func cancel()
}


final class CancellableToken: Cancellable {
    // MARK: - Properties

    private var didCancelHandler: (() -> Void)?
    var isCancelled = false

    // MARK: - Lifecycle

    init(onCancel: (() -> Void)? = nil) {
        self.didCancelHandler = onCancel
    }

    // MARK: - Actions

    func cancel() {
        guard !isCancelled else { return }
        isCancelled = true
        didCancelHandler?()
    }

    func didCancel(_ action: @escaping () -> Void) {
        didCancelHandler = action
    }
}
