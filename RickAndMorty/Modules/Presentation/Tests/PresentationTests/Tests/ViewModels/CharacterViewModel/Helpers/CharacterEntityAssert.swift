//
//  CharacterEntityAssert.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

import XCTest
import Domain

final class CharacterEntityAssert {
    
    static func assertCharacter(_ character: CharacterEntity, equals expected: CharacterEntity, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(character.id, expected.id, file: file, line: line)
        XCTAssertEqual(character.name, expected.name, file: file, line: line)
        XCTAssertEqual(character.status, expected.status, file: file, line: line)
        XCTAssertEqual(character.species, expected.species, file: file, line: line)
        XCTAssertEqual(character.type, expected.type, file: file, line: line)
        XCTAssertEqual(character.gender, expected.gender, file: file, line: line)
        XCTAssertEqual(character.origin, expected.origin, file: file, line: line)
        XCTAssertEqual(character.location, expected.location, file: file, line: line)
        XCTAssertEqual(character.image, expected.image, file: file, line: line)
    }
}
