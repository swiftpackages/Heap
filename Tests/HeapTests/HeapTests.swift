import XCTest
@testable import Heap

final class HeapTests: XCTestCase {
    func testMin() {
        var heap = MinHeap<Int>()
        heap.add(7)
        heap.add(5)
        heap.add(15)
        heap.add(17)
        heap.add(3)
        heap.add(57)
        heap.add(47)
        // results.
        XCTAssertEqual(heap.pull(), 3)
        XCTAssertEqual(heap.pull(), 5)
        XCTAssertEqual(heap.pull(), 7)
    }

    func testMax() {
        var heap = MaxHeap<Int>()
        heap.add(7)
        heap.add(5)
        heap.add(15)
        heap.add(17)
        heap.add(3)
        heap.add(57)
        heap.add(47)
        // results.
        XCTAssertEqual(heap.pull(), 57)
        XCTAssertEqual(heap.pull(), 47)
        XCTAssertEqual(heap.pull(), 17)
    }


    static var allTests = [
        ("testMin", testMin),
        ("testMax", testMax),
    ]
}
