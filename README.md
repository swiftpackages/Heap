# Heap

A basic heap implementation in Swift.

## Use

```swift
// initialize MinHeap<Int>
var minHeap = MinHeap<Int>()

// initialize MaxHeap<Int>
var maxHeap = MaxHeap<Int>()

// get root node value without removing it
heap.peak()

// get root node value and remove it
heap.pull()
```

The generic type **must** be _Comparable_
