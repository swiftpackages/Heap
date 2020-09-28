enum HeapErrors: Error {
    case IllegalStateException
}

protocol Heap {
    associatedtype T
    var storage: [T] { get set }
    var size: Int { get }
    mutating func heapifyUp()
    mutating func heapifyDown()
}

extension Heap {
    var size: Int {
        return self.storage.count
    }

    internal func getLeftChildIndex(_ parentIndex: Int) -> Int {
        return (2 * parentIndex) + 1
    }

    internal func getRightChildIndex(_ parentIndex: Int) -> Int {
        return (2 * parentIndex) + 2
    }

    internal func getParentIndex(_ childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    internal func hasLeftChild(_ parentIndex: Int) -> Bool {
        return self.getLeftChildIndex(parentIndex) < self.size
    }

    internal func hasRightChild(_ parentIndex: Int) -> Bool {
        return self.getRightChildIndex(parentIndex) < self.size
    }

    internal func hasParent(_ childIndex: Int) -> Bool {
        return self.getParentIndex(childIndex) >= 0
    }

    internal func getLeftChild(_ parentIndex: Int) -> T {
        return self.storage[self.getLeftChildIndex(parentIndex)]
    }

    internal func getRightChild(_ parentIndex: Int) -> T {
        return self.storage[self.getRightChildIndex(parentIndex)]
    }

    internal func getParent(_ childIndex: Int) -> T {
        return self.storage[self.getParentIndex(childIndex)]
    }

    mutating internal func swap(_ indexOne: Int, _ indexTwo: Int) {
        let tmp = self.storage[indexOne]
        storage[indexOne] = self.storage[indexTwo]
        storage[indexTwo] = tmp
    }

    func peak() throws -> T {
        if self.size == 0 {
            throw HeapErrors.IllegalStateException
        }

        return self.storage[0]
    }

    mutating func pull() throws -> T {
        let item = try self.peak()
        storage[0] = self.storage[self.size - 1]
        self.heapifyDown()
        return item
    }

    mutating func add(_ elem: T) {
        self.storage.append(elem)
        self.heapifyUp()
    }
}

struct MinHeap<T: Comparable> : Heap {
    internal var storage: [T] = []

    mutating internal func heapifyUp() {
        var index = self.size - 1
        while (self.hasParent(index) && self.getParent(index) > self.storage[index]) {
            swap(self.getParentIndex(index), index)
            index = self.getParentIndex(index)
        }
    }

    mutating internal func heapifyDown() {
        var index = 0
        while (self.hasLeftChild(index)) {
            var smallerChildIndex = self.getLeftChildIndex(index)
            if (self.hasRightChild(index) && self.getRightChild(index) < self.getLeftChild(index)) {
                smallerChildIndex = self.getRightChildIndex(index)
            }

            if (self.storage[index] < self.storage[smallerChildIndex]) {
                break
            } else {
                swap(index, smallerChildIndex)
                index = smallerChildIndex
            }
        }
    }
}

struct MaxHeap<T: Comparable> : Heap {
    internal var storage: [T] = []

    mutating internal func heapifyUp() {
        var index = self.size - 1
        while (self.hasParent(index) && self.getParent(index) < self.storage[index]) {
            swap(self.getParentIndex(index), index)
            index = self.getParentIndex(index)
        }
    }

    mutating internal func heapifyDown() {
        var index = 0
        while (self.hasLeftChild(index)) {
            var smallerChildIndex = self.getLeftChildIndex(index)
            if (self.hasRightChild(index) && self.getRightChild(index) > self.getLeftChild(index)) {
                smallerChildIndex = self.getRightChildIndex(index)
            }

            if (self.storage[index] > self.storage[smallerChildIndex]) {
                break
            } else {
                swap(index, smallerChildIndex)
                index = smallerChildIndex
            }
        }
    }
}
