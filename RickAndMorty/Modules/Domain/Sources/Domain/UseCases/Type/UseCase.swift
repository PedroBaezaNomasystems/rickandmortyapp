//
//  UseCase.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Foundation

public enum UseCaseError: Error, Equatable {
    
    case generic
    case noMoreData
}

public protocol UseCase: Actor {
    
    associatedtype InputType
    associatedtype ResultType
    
    func execute(data: InputType) async -> Result<ResultType, UseCaseError>
}

public extension UseCase where InputType == Void {
    func execute() async -> Result<ResultType, UseCaseError> {
        await execute(data: ())
    }
}
