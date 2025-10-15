//
//  UseCase.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Foundation

public enum UseCaseError: Error {
    
    case generic
}

public protocol UseCase: Actor {
    
    associatedtype InputType
    associatedtype ResultType
    
    func execute(data: InputType) async -> Result<ResultType, UseCaseError>
}
