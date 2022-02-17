import Foundation

extension Data {
    init?(contentsOf localFile: String, bundle: Bundle = Bundle.main) {
        guard let url = bundle.url(forResource: localFile, withExtension: "json") else {
            return nil
        }

        try? self.init(contentsOf: url)
    }
}
