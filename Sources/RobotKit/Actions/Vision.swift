//
//  Vision.swift
//  RobotKit
//
//  Created by Leif on 8/27/22.
//

import Vision

/// Robot information using [Vision](https://developer.apple.com/documentation/vision)
public struct RobotVision: SelfTasking {
    /// Use [Vision](https://developer.apple.com/documentation/vision) to request the text in the provided image
    public func text(
        in image: CGImage,
        options: [VNImageOption : Any] = [:]
    ) async throws -> [VNRecognizedTextObservation] {
        let imageRequestHandler = VNImageRequestHandler(
            cgImage: image,
            orientation: .up,
            options: options
        )
        
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try imageRequestHandler.perform(
                    [
                        VNRecognizeTextRequest { request, error in
                            if let error = error {
                                continuation.resume(throwing: error)
                            }
                            
                            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                                continuation.resume(with: .success([]))
                                return
                            }
                            
                            continuation.resume(with: .success(observations))
                        }
                    ]
                )
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
