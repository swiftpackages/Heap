/// The `Heap` protocol
public protocol Heap {
    /// The type to store in the `Heap`
    associatedtype T
    /// The storage array of the `Heap`
    var storage: [T] { get set }
    /// The size of the `Heap`
    var size: Int { get }
    /// True if the `Heap` is empty it is true and otherwise is false.
    var isEmpty: Bool { get }
    /// A function implementing the `heapifyUp` algorithm
    mutating func heapifyUp()
    /// A function implementing the `heapifyDown` algorithm
    mutating func heapifyDown()
}
/// `Heap` extension to provides all the shared code between `MaxHeap`, `MinHeap`, `MaxHeapRecursive`, and `MinHeapRecursive`.
extension Heap {
    /// The internal storage's `Array`.`size` property
    public var size: Int {
        return self.storage.count
    }
    /// The internal storage's `Array`.`isEmpty` property
    public var isEmpty: Bool {
        return self.storage.isEmpty
    }
    /// Read the next item off the `Heap` without removing it.
    ///
    /// - returns: The next item of type `T` from the `Heap` or, if the `Heap`.`isEmpty` return's `nil`.
    public func peak() -> T? {
        guard !self.isEmpty else {
            return nil
        }
        return self.storage[0]
    }
    /// Read and remove the next item off `Heap`.
    ///
    /// - returns: The next item of type `T` from the `Heap` or, if the `Heap`.`isEmpty` return's `nil`.
    mutating public func pull() -> T? {
        let item = peak()
        guard !self.isEmpty else {
            return nil
        }
        guard self.size > 1 else {
            return self.storage.popLast()!
        }
        storage[0] = self.storage.popLast()!
        heapifyDown()
        return item
    }
    /// Add an item to the `Heap`.
    ///
    /// - parameters:
    ///     - elem: Item to add to the `Heap`.
    mutating public func add(_ elem: T) {
        self.storage.append(elem)
        self.heapifyUp()
    }
    /// Calculates the left child index for any given index
    ///
    /// - parameters:
    ///     - parent: the parent index
    /// - returns: left child index
    internal static func getLeftChildIndex(_ parent: Int) -> Int {
        return (2 * parent) + 1
    }
    /// Calculates the right child index for any given index
    ///
    /// - parameters:
    ///     - parent: the parent index
    /// - returns: right child index
    internal static func getRightChildIndex(_ parent: Int) -> Int {
        return (2 * parent) + 2
    }
    /// Calculates the parent index for any given index
    ///
    /// - parameters:
    ///     - child: the parent index
    /// - returns: right child index
    internal static func getParentIndex(_ child: Int) -> Int {
        return (child - 1) / 2
    }
    /// Checks to see if there is a left child
    ///
    /// - parameters:
    ///     - parent: the parent index
    /// - returns: true if there is a left child otherwise it returns false.
    internal func hasLeftChild(_ parent: Int) -> Bool {
        return Self.getLeftChildIndex(parent) < self.size
    }
    /// Checks to see if there is a right child
    ///
    /// - parameters:
    ///     - parent: the parent index
    /// - returns: true if there is a right child otherwise it returns false.
    internal func hasRightChild(_ parentIndex: Int) -> Bool {
        return Self.getRightChildIndex(parentIndex) < self.size
    }
    /// Checks to see if there is a parent
    ///
    /// - parameters:
    ///     - child: The child index.
    /// - returns: True if there is a parent otherwise it returns false.
    internal func hasParent(_ child: Int) -> Bool {
        return child != 0 && Self.getParentIndex(child) >= 0
    }
    /// Retrieve the left child
    ///
    /// - parameters:
    ///     - parent: The parent index.
    /// - returns: The left child
    internal func getLeftChild(_ parent: Int) -> T {
        return self.storage[Self.getLeftChildIndex(parent)]
    }
    /// Retrieve the right child
    ///
    /// - parameters:
    ///     - parent: the parent index
    /// - returns: The right child.
    internal func getRightChild(_ parent: Int) -> T {
        return self.storage[Self.getRightChildIndex(parent)]
    }
    /// Retrieve the parent
    ///
    /// - parameters:
    ///     - child: the child index
    /// - returns: the parent
    internal func getParent(_ child: Int) -> T {
        return self.storage[Self.getParentIndex(child)]
    }
    /// Swap element's indecies
    ///
    /// - parameters:
    ///     - first: The first element's index.
    ///     - second: The second element's index.
    mutating internal func swap(_ first: Int, _ second: Int) {
        let tmp = self.storage[first]
        self.storage[first] = self.storage[second]
        self.storage[second] = tmp
    }
}
/// A `MaxHeap` using iterative heapify methods.
/// - note: The datatype in the `Heap` must conform to `Comparable`.
public struct MaxHeap<T: Comparable>: Heap {
    /// Public init
    public init() {}
    /// The storage array of the `Heap`
    public var storage: [T] = []
    /// The `MaxHeap` iterative `heapifyUp` algorithm.
    mutating public func heapifyUp() {
        var index = self.size - 1
        while (hasParent(index) && self.storage[index] > getParent(index)) {
            let parentIndex = Self.getParentIndex(index)
            swap(parentIndex, index)
            index = parentIndex
        }
    }
    /// The `MaxHeap` iterative `heapifyDown` algorithm.
    mutating public func heapifyDown() {
        var index = 0
        while (hasLeftChild(index)) {
            var largest = Self.getLeftChildIndex(index)
            if (hasRightChild(index) && getRightChild(index) > getLeftChild(index)) {
                largest = Self.getRightChildIndex(index)
            }

            if (self.storage[index] > self.storage[largest]) {
                break
            } else {
                swap(index, largest)
                index = largest
            }
        }
    }
}
/// A `MinHeap` using iterative heapify methods.
/// - note: The datatype in the `Heap` must conform to `Comparable`.
public struct MinHeap<T: Comparable>: Heap {
    /// Public init
    public init() {}
    /// The storage array of the `Heap`
    public var storage: [T] = []
    /// The `MinHeap` iterative `heapifyUp` algorithm.
    mutating public func heapifyUp() {
        var index = self.size - 1
        while (hasParent(index) && self.storage[index] < getParent(index)) {
            let parentIndex = Self.getParentIndex(index)
            swap(parentIndex, index)
            index = parentIndex
        }
    }
    /// The `MinHeap` iterative `heapifyDown` algorithm.
    mutating public func heapifyDown() {
        var index = 0
        while (hasLeftChild(index)) {
            var smallest = Self.getLeftChildIndex(index)
            if (hasRightChild(index) && getRightChild(index) < getLeftChild(index)) {
                smallest = Self.getRightChildIndex(index)
            }

            if (self.storage[index] < self.storage[smallest]) {
                break
            } else {
                swap(index, smallest)
                index = smallest
            }
        }
    }
}
/// A `MaxHeapRecursive` using recursive heapify methods.
/// - note: The datatype in the `Heap` must conform to `Comparable`.
public struct MaxHeapRecursive<T: Comparable>: Heap {
    /// Public init
    public init() {}
    /// The storage array of the `Heap`
    public var storage: [T] = []
    /// The `MaxHeapRecursive` recursive `heapifyUp` starter method.
    mutating public func heapifyUp() {
        heapifyUp(at: self.size - 1)
    }
    /// The `MaxHeapRecursive` recursive `heapifyUp` algorithm.
    /// - parameters:
    ///     - at: The index to `heapifyUp` from.
    mutating internal func heapifyUp(at index: Int) {
        if hasParent(index) && self.storage[index] > getParent(index) {
            let parentIndex = Self.getParentIndex(index)
            swap(index, parentIndex)
            heapifyUp(at: parentIndex)
        }
    }
    /// The `MaxHeapRecursive` recursive `heapifyDown` starter method.
    mutating public func heapifyDown() {
        heapifyDown(at: 0)
    }
    /// The `MaxHeapRecursive` recursive `heapifyDown` algorithm.
    /// - parameters:
    ///     - at: The index to `heapifyDown` from.
    mutating internal func heapifyDown(at index: Int) {
        var largest = index

        if hasLeftChild(index) && getLeftChild(index) > self.storage[index] {
            largest = Self.getLeftChildIndex(index)
        }

        if hasRightChild(index) && getRightChild(index) > self.storage[largest] {
            largest = Self.getRightChildIndex(index)
        }

        if (largest != index) {
            swap(index, largest)
            heapifyDown(at: largest)
        }
    }
}
/// A `MinHeapRecursive` using recursive heapify methods.
/// - note: The datatype in the `Heap` must conform to `Comparable`.
public struct MinHeapRecursive<T: Comparable>: Heap {
    /// Public init
    public init() {}
    /// The storage array of the `Heap`
    public var storage: [T] = []
    /// The `MinHeapRecursive` recursive `heapifyUp` starter method.
    mutating public func heapifyUp() {
        heapifyUp(at: self.size - 1)
    }
    /// The `MinHeapRecursive` recursive `heapifyUp` algorithm.
    /// - parameters:
    ///     - at: The index to `heapifyUp` from.
    mutating internal func heapifyUp(at index: Int) {
        if (hasParent(index) && storage[index] < getParent(index)) {
            let parentIndex = Self.getParentIndex(index)
            swap(index, parentIndex)
            heapifyUp(at: parentIndex)
        }
    }
    /// The `MinHeapRecursive` recursive `heapifyDown` starter method.
    mutating public func heapifyDown() {
        self.heapifyDown(at: 0)
    }
    /// The `MinHeapRecursive` recursive `heapifyDown` algorithm.
    /// - parameters:
    ///     - at: The index to `heapifyDown` from.
    mutating internal func heapifyDown(at index: Int) {
        var smallest = index

        if (hasLeftChild(index) && getLeftChild(index) < storage[index]) {
            smallest = Self.getLeftChildIndex(index)
        }

        if (hasRightChild(index) && getRightChild(index) < storage[smallest]) {
            smallest = Self.getRightChildIndex(index)
        }

        if smallest != index {
            swap(index, smallest)
            heapifyDown(at: smallest)
        }
    }
}
