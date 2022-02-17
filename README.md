![Actions Status](https://github.com/viviancrs/local-search-with-clean-architecture/actions/workflows/test.yml/badge.svg)

## Context

Project built to study clean architecture concepts. The idea is to solve a local search.

## Requirements

- iOS ~> 13.0
- Swift ~> 5
- Xcode ~> 11.0

ℹ️ To run the tests use simulator iPhone 8 (14.4) because of the snapshots

## Architecture

This project was built with concepts of clean architecture and MVP for the UI layer.

### UI Layer

- `Presenter`: contains the presentation logic and tells the `View` what to present.
- `View`: delegates user interaction events to the `Presenter` and displays data (`View Model`) passed by the `Presenter`.

### Domain Layer

- `UseCase`: contains the application / business logic for a specific use case. The `Presenter` can reference multiple `Use Cases` since it's common to have multiple use cases on the same screen.

### Data Layer

- `Repository`: abstraction over the data sources from which the `Use Cases` get the data. With repository pattern it is possibile query the model objects from different data sources (Core Data, Realm, web server, etc.) with a only single-entry point.

## Improvements

- Evolve table view animation
- Save data from providers in memory, so it would not be necessary to read JSON every time

## Dependencies

- [Swiftlint ~> 0.43.1](https://github.com/realm/SwiftLint#installation): Tool to enforce Swift style and conventions

### Test

- [Quick ~> 3.1.2](https://github.com/Quick/Quick): Behavior-driven development framework
- [Nimble ~> 9.0.0](https://github.com/Quick/Nimble): Matcher framework that allows express expectations using a natural language
- [SnapshotTesting ~> 1.8.2](https://github.com/pointfreeco/swift-snapshot-testing): Framework for snapshot testing
