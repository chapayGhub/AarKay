//
//  zip3.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 02/01/18.
//

import Foundation

public func zip<Sequence1, Sequence2, Sequence3>(_ sequence1: Sequence1, _ sequence2: Sequence2, _ sequence3: Sequence3) -> Zip3Sequence<Sequence1, Sequence2, Sequence3> {
    return Zip3Sequence(_sequence1: sequence1, _sequence2: sequence2, _sequence3: sequence3)
}

public struct Zip3Sequence<Sequence1: Sequence, Sequence2: Sequence, Sequence3: Sequence> {
    internal let _sequence1: Sequence1
    internal let _sequence2: Sequence2
    internal let _sequence3: Sequence3

    public init(_sequence1 sequence1: Sequence1, _sequence2 sequence2: Sequence2, _sequence3 sequence3: Sequence3) {
        (self._sequence1, self._sequence2, self._sequence3) = (sequence1, sequence2, sequence3)
    }
}

extension Zip3Sequence {
    public struct Iterator {
        internal var _baseStream1: Sequence1.Iterator
        internal var _baseStream2: Sequence2.Iterator
        internal var _baseStream3: Sequence3.Iterator
        internal var _reachedEnd: Bool = false

        internal init(
            _ iterator1: Sequence1.Iterator,
            _ iterator2: Sequence2.Iterator,
            _ iterator3: Sequence3.Iterator
        ) {
            (self._baseStream1, self._baseStream2, self._baseStream3) = (iterator1, iterator2, iterator3)
        }
    }
}

extension Zip3Sequence.Iterator: IteratorProtocol {
    public typealias Element = (Sequence1.Element, Sequence2.Element, Sequence3.Element)

    public mutating func next() -> Element? {
        if _reachedEnd {
            return nil
        }

        guard let element1 = _baseStream1.next(),
            let element2 = _baseStream2.next(),
            let element3 = _baseStream3.next() else {
            _reachedEnd = true
            return nil
        }

        return (element1, element2, element3)
    }
}

extension Zip3Sequence: Sequence {
    public typealias Element = (Sequence1.Element, Sequence2.Element, Sequence3.Element)

    public func makeIterator() -> Iterator {
        return Iterator(
            self._sequence1.makeIterator(),
            self._sequence2.makeIterator(),
            self._sequence3.makeIterator()
        )
    }
}
