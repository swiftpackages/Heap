![macOS](https://github.com/swiftpackages/Heap/workflows/macOS/badge.svg)
![ubuntu](https://github.com/swiftpackages/Heap/workflows/ubuntu/badge.svg)
![docs](https://github.com/swiftpackages/Heap/workflows/docs/badge.svg)

# Heap

A maintained swift heap package that provides min and max heaps in both iterative and recursive variants.

## Getting Started

You can easily add as a requirement with SwiftPM.

### Know what you’re doing?

Here are some quick copypastas for you
```swift
.package(url: "https://github.com/swiftpackages/Heap.git", from: "1.2.0"),
```
```swift
.product(name: "Heap", package: "Heap"),
```

### Need a reminder?

Your `Package.swift` file should look something like this

```swift
// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SuperCoolProject",
    products: [
        .library(
            name: "SuperCoolProject",
            targets: ["SuperCoolProject"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftpackages/Heap.git", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "SuperCoolProject",
            dependencies: [
                .product(name: "Heap", package: "Heap"),
            ]),
        .testTarget(
            name: "SuperCoolProject",
            dependencies: ["SuperCoolProject"])
    ]
)
```

## Usage

The datatype must conform to `Comparable`.

```swift
// initialize MinHeap<Int>
var minHeap = MinHeap<Int>()

// initialize MaxHeap<Int>
var maxHeap = MaxHeap<Int>()

// initialize MinHeapRecursive<Int>
var minHeap = MinHeapRecursive<Int>()

// initialize MaxHeapRecursive<Int>
var maxHeap = MaxHeapRecursive<Int>()

// get root node value without removing it
heap.peak()

// get root node value and remove it
heap.pull()
```
### Iteration

With [v1.2.0](https://github.com/swiftpackages/Heap/tree/v1.2.0) `Heap` conforms to `Sequence` allowing you to iterate through the stored items.

```swift
var heap = MinHeap<Int>()

heap.add(2)
heap.add(1)
heap.add(3)

for value in heap {
    print(value)
}
/* 1
   2
   3 */

// heap can still be used as if it wasn't iterated over.
heap.pull() // 1
heap.pull() // 2
heap.pull() // 3
```

### Additional Documentation

[You can find the full documentation on the documentation website.](https://swiftpackages.github.io/Heap)
