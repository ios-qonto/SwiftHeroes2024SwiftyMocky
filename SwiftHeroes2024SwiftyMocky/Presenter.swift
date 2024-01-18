//
//  Presenter.swift
//  SwiftHeroes2024SwiftyMocky
//
//  Created by Davide Tamiazzo on 16/01/24.
//

import Foundation

//sourcery: AutoMockable
protocol UseCase {
    func getContent(id: String) async throws -> String
}

//sourcery: AutoMockable
protocol Displayer: AnyObject {
    func display(text: String)
    func display(error: String)
}

final class Presenter {
    private let id: String
    private let useCase: UseCase
    private weak var displayer: Displayer?

    init(id: String, useCase: UseCase, displayer: Displayer) {
        self.id = id
        self.useCase = useCase
        self.displayer = displayer
    }

    @discardableResult
    func onViewDidLoad() -> Task<Void, Never> {
        Task {
            do {
                let text = try await useCase.getContent(id: id)

                displayer?.display(text: text)
            } catch {
                displayer?.display(error: error.localizedDescription)
            }
        }
    }
}
