//
//  test.swift
//  Essentia
//
//  Created by Jason Cardwell on 12/1/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// Tests that ∀ e ∈ `array`, `block(e) == true`.
///
/// - Parameters:
///   - array: The array of elements to test.
///   - block: The block used to test the elements in `array`.
///   - element: The element of `array` being tested.
/// - Returns: `true` if all elements pass and `false` otherwise.
internal func test<T>(array: [T], using block: (_ element: T) -> Bool) -> Bool {
  for value in array where !block(value) { return false }
  return true
}

/// Tests that ∀ a ∈ `array`,  `test(array: a, using: block) == true`.
///
/// - Parameters:
///   - array: The array of arrays of elements to test.
///   - block: The block used to test the elements in the elements of `array`.
///   - element: The element of an element of `array` being tested.
/// - Returns: `true` if all elements pass and `false` otherwise.
internal func test<T>(array: [[T]], using block: (_ element: T) -> Bool) -> Bool {
  for child in array where !test(array: child, using: block) { return false }
  return true
}

/// Tests that ∀ a ∈ `array`,  `test(array: a, using: block) == true`.
///
/// - Parameters:
///   - array: The array of arrays of arrays of elements to test.
///   - block: The block used to test the elements in the elements of the elements of `array`.
///   - element: The element of an element of an element of `array` being tested.
/// - Returns: `true` if all elements pass and `false` otherwise.
internal func test<T>(array: [[[T]]], using block: (_ element: T) -> Bool) -> Bool {
  for child in array where !test(array: child, using: block) { return false }
  return true
}

/// Tests that ∀ e ∈ `array`, `block(e, value) == true`.
///
/// - Parameters:
///   - array: The array of elements to test.
///   - value: The value passed along with `element` to `block`.
///   - block: The block used to test the elements in `array`.
///   - element: The element of `array` being tested.
/// - Returns: `true` if all elements pass and `false` otherwise.
internal func test<T>(array: [T],
                      against value: T,
                      using block: (_ element: T, _ value: T) -> Bool) -> Bool
{
  for actual in array where !block(actual, value) { return false }
  return true
}

/// Tests that ∀ a ∈ `array`, `test(array: a, against: value, using: block) == true`.
///
/// - Parameters:
///   - array: The array of arrays of elements to test.
///   - value: The value passed along with `element` to `block`.
///   - block: The block used to test the elements in the elements of `array`.
///   - element: The element of an element of `array` being tested.
/// - Returns: `true` if all elements pass and `false` otherwise.
internal func test<T>(array: [[T]],
                      against value: T,
                      using block: (_ element: T, _ value: T) -> Bool) -> Bool
{
  for child in array where !test(array: child, against: value, using: block) { return false }
  return true
}

/// Tests that ∀ a ∈ `array`,  `test(array: a, against: value, using: block) == true`.
///
/// - Parameters:
///   - array: The array of arrays of arrays of elements to test.
///   - value: The value passed along with `element` to `block`.
///   - block: The block used to test the elements in the elements of the elements of `array`.
///   - element: The element of an element of an element of `array` being tested.
/// - Returns: `true` if all elements pass and `false` otherwise.
internal func test<T>(array: [[[T]]],
                      against value: T,
                      using block: (_ element: T, _ value: T) -> Bool) -> Bool
{
  for child in array where !test(array: child, against: value, using: block) { return false }
  return true
}

/// Tests that ∀ (e1, e2) ∈ `zip(array1, array2)`, `block(e1, e2) == true`.
///
/// - Parameters:
///   - array1: The first array of elements to test.
///   - array2: The second array of elements to test.
///   - countMismatch: A boolean flag for indicating whether two arrays had differing counts.
///   - block: The block used to test the elements in `array1` and `array2`.
///   - element1: The element of `array1` being tested.
///   - element2: The element of `array2` being tested.
/// - Returns: `true` if all element pairs pass and `false` otherwise.
internal func test<T>(array array1: [T],
                      against array2: [T],
                      countMismatch: UnsafeMutablePointer<Bool>? = nil,
                      using block: (_ element1: T, _ element2: T) -> Bool) -> Bool
{
  guard array1.count == array2.count else { countMismatch?.pointee = true; return false }
  for (element1, element2) in zip(array1, array2) where !block(element1, element2) { return false }
  return true
}

/// Tests that ∀ (a1, a2) ∈ `zip(array1, array2)`, `test(array: a1, against: a2, using: block)
/// == true`.
///
/// - Parameters:
///   - array1: The first array of elements to test.
///   - array2: The second array of elements to test.
///   - countMismatch: A boolean flag for indicating whether two arrays had differing counts.
///   - block: The block used to test the elements in the elements of `array1` and `array2`.
///   - element1: The element of an element of `array1` being tested.
///   - element2: The element of an element of `array2` being tested.
/// - Returns: `true` if all element pairs pass and `false` otherwise.
internal func test<T>(array array1: [[T]],
                      against array2: [[T]],
                      countMismatch: UnsafeMutablePointer<Bool>? = nil,
                      using block: (_ element1: T, _ element2: T) -> Bool) -> Bool
{
  guard array1.count == array2.count else { countMismatch?.pointee = true; return false }
  for (child1, child2) in zip(array1, array2) {
    guard test(array: child1, against: child2, countMismatch: countMismatch, using: block) else {
      return false
    }
  }
  return true
}

/// Tests that ∀ (a1, a2) ∈ `zip(array1, array2)`, `test(array: a1, against: a2, using: block)
/// == true`.
///
/// - Parameters:
///   - array1: The first array of elements to test.
///   - array2: The second array of elements to test.
///   - countMismatch: A boolean flag for indicating whether two arrays had differing counts.
///   - block: The block used to test the elements in the elements of the elements of `array1`
///            and `array2`.
///   - element1: The element of an element of an element of `array1` being tested.
///   - element2: The element of an element of an element of `array2` being tested.
/// - Returns: `true` if all element pairs pass and `false` otherwise.
internal func test<T>(array array1: [[[T]]],
                      against array2: [[[T]]],
                      countMismatch: UnsafeMutablePointer<Bool>? = nil,
                      using block: (_ element1: T, _ element2: T) -> Bool) -> Bool
{
  guard array1.count == array2.count else { countMismatch?.pointee = true; return false }
  for (child1, child2) in zip(array1, array2) {
    guard test(array: child1, against: child2, countMismatch: countMismatch, using: block) else {
      return false
    }
  }
  return true
}
