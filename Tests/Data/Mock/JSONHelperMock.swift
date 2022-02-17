import Foundation
@testable import LocalSearch

struct JSONHelperMock: JSONHelperType {
    let mockDecodable: Decodable?

    func decode<T: Decodable>(from file: String) -> T? {
        return mockDecodable as? T
    }
}
