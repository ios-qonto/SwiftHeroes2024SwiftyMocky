# SwiftHeroes 2024 SwiftyMocky sample project

Small project containing a `Presenter` class with a couple of injected dependencies:
- a `UseCase` to load content from 
- a `Displayer` to update the UI with 

The `PresenterTests` are unit tests containing the auto-generated mocks for the two dependencies.

## Setup
Run 
```
make mocks
```
in the root of this project to generate the `Mock.generated.swift` containing `DisplayerMock` and `UseCaseMock`

## Credits

Davide Tamiazzo - Sara Sipione, iOS engineers at Qonto
