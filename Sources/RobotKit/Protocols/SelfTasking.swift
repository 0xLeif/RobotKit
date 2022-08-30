//
//  SelfTasking.swift
//  RobotKit
//
//  Created by Leif on 8/27/22.
//

public protocol SelfTasking {
    /// Create an async rethrowing function using the current value of Self
    func task(
        _ work: @escaping (Self) async throws -> Void
    ) async rethrows
}

extension SelfTasking {
    public func task(
        _ work: @escaping (Self) async throws -> Void
    ) async rethrows {
        try await work(self)
    }
}
