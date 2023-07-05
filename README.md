![Actions Status](https://github.com/viviancrs/local-search-with-clean-architecture/actions/workflows/test.yml/badge.svg)

## Context

Project built to study clean architecture concepts. The idea is to solve a local search.

## Requirements

- iOS ~> 13.0
- Swift ~> 5
- Xcode ~> 11.0

ℹ️ To run the tests use simulator iPhone 8 (15.0) because of the snapshots

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
- [Nimble ~> 9.0.1](https://github.com/Quick/Nimble): Matcher framework that allows express expectations using a natural language
- [SnapshotTesting ~> 1.8.2](https://github.com/pointfreeco/swift-snapshot-testing): Framework for snapshot testing

## Debatable decisions

### Over engineering

The whole code looks pretty "over kill" due to the size of the challenge.

The domain/data layer is perhaps the main point that could have been simplified. Just abstracting the data loading (without use case and etc.) possibly would have been enough. However, as I am studying clean archtecture concepts, I chose to try to practice a little.

Another point that made the project grow in number of files was the cost of separating responsibility (Keyboardable, JSONHelper, Localizable, etc.)

Still, I took care not to add things I didn't need.
Example: There is nothing coordinating navigation.

### Filter inside local data source

- The responsibility of filtering the data was attributed to the data source if in the future the data were obtained from a server, or were paged.
- However, depending on the business need, it might make sense to assign this responsibility to the domain layer

### View, cell and data source tests

- Snapshot tests are controversial. But as the views are dumbs and basically know how to build themselves given a view model, I chose to cover these tests with snapshot.
- Unit testing the cell and data source might be over kill, given the low responsibility. This piece of code was covered by the view tests that use these features

### Local data source tests

- The testing of the local data source is actually loading the local JSON. Given the importance of loading the file and parsing the data, I chose to test this integrated piece of code without mocking it.
