//
//  InternalTests.swift
//  Essentia
//
//  Created by Jason Cardwell on 12/1/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import XCTest
import Essentia
import Accelerate

private let descriptionSuffix = " [Internal]"

class InternalTests: XCTestCase {

  /// Overridden so that failures can be recorded selectively in order to test the assertion
  /// functions themselves.
  ///
  /// - Parameters:
  ///   - description: The description of the failure being reported.
  ///   - filePath: The file path to the source file where the failure being reported
  ///               was encountered.
  ///   - lineNumber: The line number in the source file at filePath where the failure being
  ///                 reported was encountered.
  ///   - expected: `true` if the failure being reported was the result of a failed assertion,
  ///               `false` if it was the result of an uncaught exception.
  override func recordFailure(withDescription description: String,
                              inFile filePath: String,
                              atLine lineNumber: Int,
                              expected: Bool)
  {

    guard description.hasSuffix(descriptionSuffix) else { return }

    let endIndex = description.index(description.endIndex, offsetBy: -descriptionSuffix.count)
    let actualDescription = String(description[..<endIndex])

    super.recordFailure(withDescription: actualDescription,
                        inFile: filePath,
                        atLine: lineNumber,
                        expected: expected)


  }

  func testDSPComplexExtensions() {

    /*
     Test deviation.
     */

    XCTAssertEqual((2+6⍳).deviation(from: 4+8⍳), 37.5, descriptionSuffix)
    XCTAssertEqual((0+6⍳).deviation(from: 4+8⍳), 62.5, descriptionSuffix)
    XCTAssertEqual((2+0⍳).deviation(from: 4+8⍳),   75, descriptionSuffix)
    XCTAssertEqual((0+0⍳).deviation(from: 4+8⍳),  100, descriptionSuffix)

    XCTAssertTrue((2+6⍳).deviation(from: 0+8⍳).isInfinite, descriptionSuffix)
    XCTAssertTrue((2+6⍳).deviation(from: 4+0⍳).isInfinite, descriptionSuffix)
    XCTAssertTrue((2+6⍳).deviation(from: 0+0⍳).isInfinite, descriptionSuffix)

    /*
     Test equality.
     */

    XCTAssertTrue( 4+2⍳ == DSPComplex(real:  4, imag:  2), descriptionSuffix)
    XCTAssertTrue( 4-2⍳ == DSPComplex(real:  4, imag: -2), descriptionSuffix)
    XCTAssertTrue(-4+2⍳ == DSPComplex(real: -4, imag:  2), descriptionSuffix)
    XCTAssertTrue(-4-2⍳ == DSPComplex(real: -4, imag: -2), descriptionSuffix)

    XCTAssertTrue( 4+2⍳ ==  4+2⍳, descriptionSuffix)
    XCTAssertTrue( 4-2⍳ ==  4-2⍳, descriptionSuffix)
    XCTAssertTrue(-4+2⍳ == -4+2⍳, descriptionSuffix)
    XCTAssertTrue(-4-2⍳ == -4-2⍳, descriptionSuffix)

    XCTAssertFalse( 4+2⍳ ==  4-2⍳, descriptionSuffix)
    XCTAssertFalse( 4-2⍳ ==  4+2⍳, descriptionSuffix)
    XCTAssertFalse(-4+2⍳ == -4-2⍳, descriptionSuffix)
    XCTAssertFalse(-4-2⍳ == -4+2⍳, descriptionSuffix)
    XCTAssertFalse( 4+2⍳ == -4+2⍳, descriptionSuffix)
    XCTAssertFalse( 4-2⍳ == -4-2⍳, descriptionSuffix)
    XCTAssertFalse(-4+2⍳ ==  4+2⍳, descriptionSuffix)
    XCTAssertFalse(-4-2⍳ ==  4-2⍳, descriptionSuffix)

    XCTAssertTrue((2+6⍳).isEqual(to: 4+8⍳, deviation: 40), descriptionSuffix)
    XCTAssertFalse((2+6⍳).isEqual(to: 4+8⍳, deviation: 30), descriptionSuffix)

    /*
     Test addition.
     */

    XCTAssertEqual( 4+2⍳ + ( 6-8⍳),  10-6⍳, descriptionSuffix)
    XCTAssertEqual( 4-2⍳ + ( 6+8⍳),  10+6⍳, descriptionSuffix)
    XCTAssertEqual(-4+2⍳ + ( 6-8⍳),   2-6⍳, descriptionSuffix)
    XCTAssertEqual(-4-2⍳ + ( 6+8⍳),   2+6⍳, descriptionSuffix)
    XCTAssertEqual( 4+2⍳ + (-6-8⍳),  -2-6⍳, descriptionSuffix)
    XCTAssertEqual( 4-2⍳ + (-6+8⍳),  -2+6⍳, descriptionSuffix)
    XCTAssertEqual(-4+2⍳ + (-6-8⍳), -10-6⍳, descriptionSuffix)
    XCTAssertEqual(-4-2⍳ + (-6+8⍳), -10+6⍳, descriptionSuffix)

    /*
     Test subtraction.
     */

    XCTAssertEqual( 4+2⍳ - ( 6-8⍳),  -2-6⍳, descriptionSuffix)
    XCTAssertEqual( 4-2⍳ - ( 6+8⍳),  -2+6⍳, descriptionSuffix)
    XCTAssertEqual(-4+2⍳ - ( 6-8⍳), -10-6⍳, descriptionSuffix)
    XCTAssertEqual(-4-2⍳ - ( 6+8⍳), -10+6⍳, descriptionSuffix)
    XCTAssertEqual( 4+2⍳ - (-6-8⍳),  10-6⍳, descriptionSuffix)
    XCTAssertEqual( 4-2⍳ - (-6+8⍳),  10+6⍳, descriptionSuffix)
    XCTAssertEqual(-4+2⍳ - (-6-8⍳),   2-6⍳, descriptionSuffix)
    XCTAssertEqual(-4-2⍳ - (-6+8⍳),   2+6⍳, descriptionSuffix)

    /*
     Test absolute value.
     */

    XCTAssertEqual(abs( 2+3⍳), sqrtf(13), descriptionSuffix)
    XCTAssertEqual(abs( 2-3⍳), sqrtf(13), descriptionSuffix)
    XCTAssertEqual(abs(-2+3⍳), sqrtf(13), descriptionSuffix)
    XCTAssertEqual(abs(-2-3⍳), sqrtf(13), descriptionSuffix)
    XCTAssertEqual(abs( 0+3⍳),         3, descriptionSuffix)
    XCTAssertEqual(abs( 0-3⍳),         3, descriptionSuffix)
    XCTAssertEqual(abs( 2+0⍳),         2, descriptionSuffix)
    XCTAssertEqual(abs(-2+0⍳),         2, descriptionSuffix)

  }

  func testFloatingPointExtensions() {


    /*
     Test deviation.
     */

    XCTAssertEqual(Float(2).deviation(from: 4),  50, descriptionSuffix)
    XCTAssertEqual(Float(0).deviation(from: 0),   0, descriptionSuffix)
    XCTAssertEqual(Float(0).deviation(from: 4), 100, descriptionSuffix)

    XCTAssertTrue(Float(2).deviation(from: 0).isInfinite, descriptionSuffix)

    /*
     Test equality.
     */

    XCTAssertTrue(Float(2).isEqual(to: 4, deviation: 60), descriptionSuffix)

    XCTAssertFalse(Float(2).isEqual(to: 4, deviation:  40), descriptionSuffix)
    XCTAssertFalse(Float(2).isEqual(to: 0, deviation: 100), descriptionSuffix)

  }

  func testArrayExtensions() {

    let floatValues1: [Float] = [1, 2, 3, 4, 5]
    let floatValues2: [Float] = [5, 4, 3, 2, 1]

    let complexValues1: [DSPComplex] = [1+1⍳, 2+2⍳, 3+3⍳, 4+4⍳, 5+5⍳]
    let complexValues2: [DSPComplex] = [5+5⍳, 4+4⍳, 3+3⍳, 2+2⍳, 1+1⍳]

    /*
     Test mean.
     */

    XCTAssertEqual(floatValues1.mean, 3, descriptionSuffix)
    XCTAssertEqual(floatValues2.mean, 3, descriptionSuffix)

    /*
     Test average difference.
     */

    XCTAssertEqual(floatValues1.averageDifference(with: floatValues2), 2.4)
    XCTAssertEqual(floatValues2.averageDifference(with: floatValues1), 2.4)
    XCTAssertEqual(floatValues1.averageDifference(with: floatValues1),   0)
    XCTAssertEqual(floatValues2.averageDifference(with: floatValues2),   0)

    XCTAssertEqual(complexValues1.averageDifference(with: complexValues2), 2.4)
    XCTAssertEqual(complexValues2.averageDifference(with: complexValues1), 2.4)
    XCTAssertEqual(complexValues1.averageDifference(with: complexValues1),   0)
    XCTAssertEqual(complexValues2.averageDifference(with: complexValues2),   0)

    /*
     Test average deviation.
     */

    XCTAssertEqual(floatValues1.averageDeviation(from: floatValues2), 126)
    XCTAssertEqual(floatValues2.averageDeviation(from: floatValues1), 126)
    XCTAssertEqual(floatValues1.averageDeviation(from: floatValues1),   0)
    XCTAssertEqual(floatValues2.averageDeviation(from: floatValues2),   0)

    XCTAssertEqual(complexValues1.averageDeviation(from: complexValues2), 126)
    XCTAssertEqual(complexValues2.averageDeviation(from: complexValues1), 126)
    XCTAssertEqual(complexValues1.averageDeviation(from: complexValues1),   0)
    XCTAssertEqual(complexValues2.averageDeviation(from: complexValues2),   0)

  }

  func testTestFunctions() {

    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented." + descriptionSuffix)

    /*
     test<T>(array: [T], using block: (_ element: T) -> Bool) -> Bool
     */


    /*
     test<T>(array: [[T]], using block: (_ element: T) -> Bool) -> Bool
     */


    /*
     test<T>(array: [[[T]]], using block: (_ element: T) -> Bool) -> Bool
     */


    /*
     test<T>(array: [T], against value: T, using block: (_ element: T, _ value: T) -> Bool) -> Bool
     */


    /*
     test<T>(array: [[T]], against value: T, using block: (_ element: T, _ value: T) -> Bool) -> Bool
     */


    /*
     test<T>(array: [[[T]]], against value: T, using block: (_ element: T, _ value: T) -> Bool) -> Bool
     */


    /*
     test<T>(array array1: [T], against array2: [T], countMismatch: UnsafeMutablePointer<Bool>? = nil, using block: (_ element1: T, _ element2: T) -> Bool) -> Bool
     */


    /*
     test<T>(array array1: [[T]], against array2: [[T]], countMismatch: UnsafeMutablePointer<Bool>? = nil, using block: (_ element1: T, _ element2: T) -> Bool) -> Bool
     */


    /*
     test<T>(array array1: [[[T]]], against array2: [[[T]]], countMismatch: UnsafeMutablePointer<Bool>? = nil, using block: (_ element1: T, _ element2: T) -> Bool) -> Bool
     */


  }

  func testAssertions() {

    //TODO: Implement the  function
    XCTFail("\(#function) not yet implemented." + descriptionSuffix)

    /*
     Test multi-dimensional arrays of an equatable type.
     XCTAssertEqual<T:Equatable>(_ array1: [[T]], _ array2: [[T]]) -> Bool
     XCTAssertEqual<T:Equatable>(_ array1: [[[T]]], _ array2: [[[T]]]) -> Bool
     */

    
    /*
     Test equal with accuracy.
     XCTAssertEqual<T:FloatingPoint>(_ array1: [T], _ array2: [T], accuracy: T = 0) -> Bool
     XCTAssertEqual<T:FloatingPoint>(_ array1: [[T]], _ array2: [[T]], accuracy: T = 0) -> Bool
     XCTAssertEqual<T:FloatingPoint>(_ array1: [[[T]]], _ array2: [[[T]]], accuracy: T = 0) -> Bool
     XCTAssertEqual(_ array1: [DSPComplex], _ array2: [DSPComplex], accuracy: Float = 0) -> Bool
     XCTAssertEqual(_ array1: [[DSPComplex]], _ array2: [[DSPComplex]], accuracy: Float = 0) -> Bool
     XCTAssertEqual(_ array1: [[[DSPComplex]]], _ array2: [[[DSPComplex]]], accuracy: Float = 0) -> Bool
     */


    /*
     Test equal with deviation.
     XCTAssertEqual<T:FloatingPoint>(_ actual: T, _ expected: T, deviation: T = 0) -> Bool
     XCTAssertEqual<T:FloatingPoint>(_ array1: [T], _ array2: [T], deviation: T = 0) -> Bool
     XCTAssertEqual<T:FloatingPoint>(_ array1: [[T]], _ array2: [[T]], deviation: T = 0) -> Bool
     XCTAssertEqual<T:FloatingPoint>(_ array1: [[[T]]], _ array2: [[[T]]], deviation: T = 0) -> Bool
     XCTAssertEqual(_ array1: [DSPComplex], _ array2: [DSPComplex], deviation: Float = 0) -> Bool
     XCTAssertEqual(_ array1: [[DSPComplex]], _ array2: [[DSPComplex]], deviation: Float = 0) -> Bool
     XCTAssertEqual(_ array1: [[[DSPComplex]]], _ array2: [[[DSPComplex]]], deviation: Float = 0) -> Bool
     */


    /*
     Test not nan or inf.
     XCTAssertNotNaNOrInf<T:FloatingPoint>(_ value: T) -> Bool
     XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [T]) -> Bool
     XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [[T]]) -> Bool
     XCTAssertNotNaNOrInf<T:FloatingPoint>(_ array: [[[T]]]) -> Bool
     */


    /*
     Test ≥.
     XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [T], _ value: T) -> Bool
     XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [[T]], _ value: T) -> Bool
     XCTAssertGreaterThanOrEqual<T:FloatingPoint>(_ array: [[[T]]], _ value: T) -> Bool
     */


    /*
     Test average equal.
     XCTAssertAverageEqual<T:FloatingPoint>(_ array: [T], _ expected: T, accuracy: T = 0) -> Bool
     XCTAssertAverageEqual<T:FloatingPoint>(_ array: [T], _ expected: T, deviation: T = 0) -> Bool
     */


    /*
     Test difference mean ≤.
     XCTAssertDifferenceMeanLessThanOrEqual<T:FloatingPoint>(_ array1: [T], _ array2: [T], _ mean: T) -> Bool
     XCTAssertDifferenceMeanLessThanOrEqual<T:FloatingPoint>(_ array1: [[T]], _ array2: [[T]], _ mean: T) -> Bool
     XCTAssertDifferenceMeanLessThanOrEqual(_ array1: [DSPComplex], _ array2: [DSPComplex], _ mean: Float) -> Bool
     */


    /*
     Test deviation ≤.
     XCTAssertPercentDeviationLessThanOrEqual<T>(_ array1: [T], _ array2: [T], _ deviation: T) -> Bool where T:FloatingPoint
     XCTAssertPercentDeviationLessThanOrEqual<T>(_ array1: [[T]], _ array2: [[T]], _ deviation: T) -> Bool where T:FloatingPoint
     XCTAssertPercentDeviationLessThanOrEqual(_ array1: [DSPComplex], _ array2: [DSPComplex], _ deviation: Float) -> Bool
     */


    /*
     Test difference mean or deviation ≤.
     XCTAssertDifferenceMeanOrDeviationLessThanOrEqual<T:FloatingPoint>( _ array1: [T], _ array2: [T], differenceMean: T, deviation: T) -> Bool
     XCTAssertDifferenceMeanOrDeviationLessThanOrEqual<T:FloatingPoint>( _ array1: [[T]], _ array2: [[T]], differenceMean: T, deviation: T) -> Bool
     XCTAssertDifferenceMeanOrDeviationLessThanOrEqual( _ array1: [DSPComplex], _ array2: [DSPComplex], differenceMean: Float, deviation: Float) -> Bool
     */


  }

}
