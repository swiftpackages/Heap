import XCTest
@testable import Heap

final class HeapTests: XCTestCase {
    let numberOfHeaps = 100
    let maxNumberOfValues = 1000

    func testMaxHeap() {
        for _ in 1...numberOfHeaps {
            var values: [Int] = []
            var heap = MaxHeap<Int>()

            let amount = Int.random(in: 1...maxNumberOfValues)
            for _ in 1...amount {
                let value = Int.random(in: Int.min...Int.max)
                values.append(value)
                heap.add(value)
            }

            values.sort(by: { $0 > $1 })

            for value in values {
                XCTAssertEqual(value, heap.pull())
            }
        }
    }

    func testMaxHeapNilPull() {
        var heap = MaxHeap<Int>()
        XCTAssertNil(heap.pull())
    }

    func testMaxHeapRecursive() {
        for _ in 1...numberOfHeaps {
            var values: [Int] = []
            var heap = MaxHeapRecursive<Int>()

            let amount = Int.random(in: 1...maxNumberOfValues)
            for _ in 1...amount {
                let value = Int.random(in: Int.min...Int.max)
                values.append(value)
                heap.add(value)
            }

            values.sort(by: { $0 > $1 })

            for value in values {
                XCTAssertEqual(value, heap.pull())
            }
        }
    }

    func testMaxHeapRecursiveNilPull() {
        var heap = MaxHeapRecursive<Int>()
        XCTAssertNil(heap.pull())
    }

    func testMinHeap() {
        for _ in 1...numberOfHeaps {
            var values: [Int] = []
            var heap = MinHeap<Int>()

            let amount = Int.random(in: 1...maxNumberOfValues)
            for _ in 1...amount {
                let value = Int.random(in: Int.min...Int.max)
                values.append(value)
                heap.add(value)
            }

            values.sort(by: { $0 < $1 })

            for value in values {
                XCTAssertEqual(value, heap.pull())
            }
        }
    }

    func testMinHeapNilPull() {
        var heap = MinHeap<Int>()
        XCTAssertNil(heap.pull())
    }

    func testMinHeapRecursive() {
        for _ in 1...numberOfHeaps {
            var values: [Int] = []
            var heap = MinHeapRecursive<Int>()

            let amount = Int.random(in: 1...maxNumberOfValues)
            for _ in 1...amount {
                let value = Int.random(in: Int.min...Int.max)
                values.append(value)
                heap.add(value)
            }

            values.sort(by: { $0 < $1 })

            for value in values {
                XCTAssertEqual(value, heap.pull())
            }
        }
    }

    func testMinHeapRecursiveNilPull() {
        var heap = MinHeapRecursive<Int>()
        XCTAssertNil(heap.pull())
    }

    static var allTests = [
        ("testMaxHeap", testMaxHeap),
        ("testMaxHeapNilPull", testMaxHeapNilPull),
        ("testMaxHeapRecursive", testMaxHeapRecursive),
        ("testMaxHeapRecursiveNilPull", testMaxHeapRecursiveNilPull),
        ("testMinHeap", testMinHeap),
        ("testMinHeapNilPull", testMinHeapNilPull),
        ("testMinHeapRecursive", testMinHeapRecursive),
        ("testMinHeapRecursivePull", testMinHeapRecursiveNilPull),
    ]
}
