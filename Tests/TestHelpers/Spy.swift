@propertyWrapper
struct Spy<T> {
    private(set) var value: T
    private(set) var history: [T] = []

    var count: Int {
        return history.count
    }

    var wrappedValue: T {
        get { value }
        set {
            history.append(newValue)
            value = newValue
        }
    }

    public var projectedValue: Self {
        get { self }
        set { self = newValue }
    }

    init(wrappedValue: T) {
        self.value = wrappedValue
    }
}
