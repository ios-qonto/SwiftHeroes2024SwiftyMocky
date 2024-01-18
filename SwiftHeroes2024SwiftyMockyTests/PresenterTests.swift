//
//  PresenterTests.swift
//  SwiftHeroes2024SwiftyMockyTests
//
//  Created by Davide Tamiazzo on 16/01/24.
//

import XCTest
@testable import SwiftHeroes2024SwiftyMocky

final class PresenterTests: XCTestCase {
    private let useCase = UseCaseMock()
    private let displayer = DisplayerMock()

    func test_onViewDidLoad() async throws {
        // GIVEN
        let id = "id"
        let underTest = Presenter(id: id, useCase: useCase, displayer: displayer)
        useCase.given(.getContent(id: .value(id), willReturn: "Content"))

        // WHEN
        let task = underTest.onViewDidLoad()

        // THEN
        await task.value
        useCase.verify(.getContent(id: .value(id)))
    }
}
