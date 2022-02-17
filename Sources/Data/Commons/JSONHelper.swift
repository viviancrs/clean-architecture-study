import Foundation

protocol JSONHelperType {
    func decode<T: Decodable>(from file: String) -> T?
}

struct JSONHelper: JSONHelperType {
    private let bundle: Bundle

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }

    func decode<T: Decodable>(from file: String) -> T? {
        guard let data = Data(contentsOf: file, bundle: bundle) else { return nil }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(T.self, from: data)
    }
}
