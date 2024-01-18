//
//  PresenterTests.swift
//  SwiftHeroes2024SwiftyMockyTests
//
//  Created by Davide Tamiazzo on 16/01/24.
//

import XCTest
@testable import SwiftHeroes2024SwiftyMocky

final class PresenterTests: XCTestCase {
    struct UseCaseError: Error {}

    private let useCase = UseCaseMock()
    private let displayer = DisplayerMock()

    func test_displayContent_givenId_thenCallsUseCase() async throws {
        // GIVEN
        let id = "id"
        let underTest = Presenter(useCase: useCase, displayer: displayer)
        useCase.given(.getContent(id: .value(id), willReturn: "Content"))

        // WHEN
        let task = underTest.displayContent(for: id)

        // THEN
        await task.value
        useCase.verify(.getContent(id: .value(id)))
    }

    func test_displayContent_givenOtherId_andUseCaseSuccess_thenUpdatesDisplayerWithOtherContent() async throws {
        // GIVEN
        let id = "id"
        let otherId = "otherId"
        let content = "Content"
        let otherContent = "OtherContent"
        let underTest = Presenter(useCase: useCase, displayer: displayer)
        useCase.given(.getContent(id: .value(id), willReturn: content))
        useCase.given(.getContent(id: .value(otherId), willReturn: otherContent))

        // WHEN
        let task = underTest.displayContent(for: id)

        // THEN
        await task.value
        displayer.verify(.display(text: .value(content)))

        // WHEN
        let otherTask = underTest.displayContent(for: otherId)

        // THEN
        await otherTask.value
        displayer.verify(.display(text: .value(otherContent)))
    }

    func test_displayContent_givenUseCaseError_thenUpdatesDisplayerWithOtherContent() async throws {
        // GIVEN
        let error = UseCaseError()
        let underTest = Presenter(useCase: useCase, displayer: displayer)
        useCase.given(.getContent(id: .any, willThrow: error))

        // WHEN
        let task = underTest.displayContent(for: "")

        // THEN
        await task.value
        displayer.verify(.display(error: .value(error.localizedDescription)))
    }
}
