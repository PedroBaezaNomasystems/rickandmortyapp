//
//  RepositoryError.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

public enum RepositoryError: Error, Equatable {
    
    case notFound
    case generic(String)
}
