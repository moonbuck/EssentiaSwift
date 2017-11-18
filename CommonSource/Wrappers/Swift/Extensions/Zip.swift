//
//  Zip.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/18/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
//  The content in this file is a modification of the file 'Zip.swift' from the standard
//  library modified to zip three elements instead of two.
//
import Foundation

@_inlineable
public func zip<S1, S2, S3>(_ seq1: S1, _ seq2: S2, _ seq3: S3) -> Zip3Sequence<S1, S2, S3>
  where S1:Sequence, S2:Sequence, S3:Sequence
{
  return Zip3Sequence(seq1, seq2, seq3)
}

/// An iterator for `Zip3Sequence`.
@_fixed_layout
public struct Zip3Iterator<Iterator1, Iterator2, Iterator3> : IteratorProtocol
  where Iterator1:IteratorProtocol, Iterator2:IteratorProtocol, Iterator3:IteratorProtocol
{
  /// The type of element returned by `next()`.
  public typealias Element = (Iterator1.Element, Iterator2.Element, Iterator3.Element)

  /// Creates an instance around a trio of underlying iterators.
  @_inlineable
  @_versioned
  internal init(_ iterator1: Iterator1, _ iterator2: Iterator2, _ iterator3: Iterator3) {
    (_baseStream1, _baseStream2, _baseStream3) = (iterator1, iterator2, iterator3)
  }

  /// Advances to the next element and returns it, or `nil` if no next element
  /// exists.
  ///
  /// Once `nil` has been returned, all subsequent calls return `nil`.
  @_inlineable
  public mutating func next() -> Element? {

    if _reachedEnd {
      return nil
    }

    guard let element1 = _baseStream1.next(),
          let element2 = _baseStream2.next(),
          let element3 = _baseStream3.next()
      else
    {
      _reachedEnd = true
      return nil
    }

    return (element1, element2, element3)
  }

  @_versioned
  internal var _baseStream1: Iterator1

  @_versioned
  internal var _baseStream2: Iterator2

  @_versioned
  internal var _baseStream3: Iterator3

  @_versioned
  internal var _reachedEnd: Bool = false
}

@_fixed_layout
public struct Zip3Sequence<Sequence1:Sequence, Sequence2:Sequence, Sequence3:Sequence> : Sequence {

  /// A type whose instances can produce the elements of this
  /// sequence, in order.
  public typealias Iterator = Zip3Iterator<Sequence1.Iterator,
                                           Sequence2.Iterator,
                                           Sequence3.Iterator>

  /// Creates an instance that makes tuples of elements from `sequence1`, `sequence2` and
  /// `sequence3`.
  @_inlineable
  public
  init(_ sequence1: Sequence1, _ sequence2: Sequence2, _ sequence3: Sequence3) {
    (_sequence1, _sequence2, _sequence3) = (sequence1, sequence2, sequence3)
  }

  /// Returns an iterator over the elements of this sequence.
  @_inlineable
  public func makeIterator() -> Iterator {
    return Iterator(
      _sequence1.makeIterator(),
      _sequence2.makeIterator(),
      _sequence3.makeIterator())
  }

  @_versioned
  internal let _sequence1: Sequence1

  @_versioned
  internal let _sequence2: Sequence2

  @_versioned
  internal let _sequence3: Sequence3

}
