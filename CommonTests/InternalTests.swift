//
//  InternalTests.swift
//  Essentia
//
//  Created by Jason Cardwell on 12/1/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import XCTest
@testable import Essentia
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

  /// Tests the functionality of the complex number extensions.
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

    XCTAssertTrue((2+6⍳).isEqual(to: 4+8⍳, accuracy: 3), descriptionSuffix)
    XCTAssertFalse((2+6⍳).isEqual(to: 4+8⍳, accuracy: 1), descriptionSuffix)

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

  /// Tests the functionality of the floating point extenions.
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

    XCTAssertTrue(Float(2).isEqual(to: 2, accuracy: 0), descriptionSuffix)
    XCTAssertTrue(Float(2).isEqual(to: 3, accuracy: 2), descriptionSuffix)

    XCTAssertFalse(Float(2).isEqual(to: 3, accuracy: 0.5), descriptionSuffix)

  }

  /// Tests the functionality of the array extensions.
  func testArrayExtensions() {

    let f1: [Float] = [1, 2, 3, 4, 5]
    let f2: [Float] = [5, 4, 3, 2, 1]

    let c1: [DSPComplex] = [1+1⍳, 2+2⍳, 3+3⍳, 4+4⍳, 5+5⍳]
    let c2: [DSPComplex] = [5+5⍳, 4+4⍳, 3+3⍳, 2+2⍳, 1+1⍳]

    /*
     Test mean.
     */

    XCTAssertEqual(f1.mean, 3, descriptionSuffix)
    XCTAssertEqual(f2.mean, 3, descriptionSuffix)

    /*
     Test average difference.
     */

    XCTAssertEqual(f1.averageDifference(with: f2), 2.4)
    XCTAssertEqual(f2.averageDifference(with: f1), 2.4)
    XCTAssertEqual(f1.averageDifference(with: f1),   0)
    XCTAssertEqual(f2.averageDifference(with: f2),   0)

    XCTAssertEqual(c1.averageDifference(with: c2), 2.4)
    XCTAssertEqual(c2.averageDifference(with: c1), 2.4)
    XCTAssertEqual(c1.averageDifference(with: c1),   0)
    XCTAssertEqual(c2.averageDifference(with: c2),   0)

    /*
     Test average deviation.
     */

    XCTAssertEqual(f1.averageDeviation(from: f2), 126)
    XCTAssertEqual(f2.averageDeviation(from: f1), 126)
    XCTAssertEqual(f1.averageDeviation(from: f1),   0)
    XCTAssertEqual(f2.averageDeviation(from: f2),   0)

    XCTAssertEqual(c1.averageDeviation(from: c2), 126)
    XCTAssertEqual(c2.averageDeviation(from: c1), 126)
    XCTAssertEqual(c1.averageDeviation(from: c1),   0)
    XCTAssertEqual(c2.averageDeviation(from: c2),   0)

  }

  /// Tests the functionality of the test functions used to construct the assertions.
  func testTestFunctions() {

    let f1d1: [Float] = [1, 2, 3, 4, 5]
    let f1d2: [Float] = [1, 2, 3, .nan, 5]
    let f1d3: [Float] = [1, 2, 3, .infinity, 5]
    let f1d4: [Float] = [5, 5, 5, 5, 5]

    let f2d12 = [f1d1, f1d2]
    let f2d14 = [f1d1, f1d4]
    let f2d31 = [f1d3, f1d1]
    let f2d41 = [f1d4, f1d1]
    let f2d11 = [f1d1, f1d1]
    let f2d44 = [f1d4, f1d4]

    let f3d11_11 = [f2d11, f2d11]
    let f3d12_11 = [f2d12, f2d11]
    let f3d11_31 = [f2d11, f2d31]
    let f3d14_44 = [f2d14, f2d44]
    let f3d44_41 = [f2d44, f2d41]
    let f3d14_14 = [f2d14, f2d14]
    let f3d14_41 = [f2d14, f2d41]

    let notNaNorInfFloatBlock: (Float) -> Bool = {!($0.isNaN || $0.isInfinite)}
    let equalWithAccuracyPassBlock: (Float, Float) -> Bool = { $0.isEqual(to: $1, accuracy: 5) }
    let equalWithAccuracyFailBlock: (Float, Float) -> Bool = { $0.isEqual(to: $1, accuracy: 1) }

    /*
     Test the test function for a 1d array.
     */


    XCTAssertTrue(test(array: f1d1, using: notNaNorInfFloatBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f1d2, using: notNaNorInfFloatBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f1d3, using: notNaNorInfFloatBlock), descriptionSuffix)

    /*
     Test the test function for a 2d array.
     */

    XCTAssertTrue(test(array: f2d11, using: notNaNorInfFloatBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f2d12, using: notNaNorInfFloatBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f2d31, using: notNaNorInfFloatBlock), descriptionSuffix)

    /*
     Test the test function for a 3d array.
     */

    XCTAssertTrue(test(array: f3d11_11, using: notNaNorInfFloatBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f3d12_11, using: notNaNorInfFloatBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f3d11_31, using: notNaNorInfFloatBlock), descriptionSuffix)

    /*
     Test the test function for a 1d array and a value.
     */

    XCTAssertTrue(test(array: f1d1, against: 1, using: >=), descriptionSuffix)
    XCTAssertFalse(test(array: f1d1, against: 2, using: >=), descriptionSuffix)

    /*
     Test the test function for a 2d array and a value.
     */

    XCTAssertTrue(test(array: f2d14, against: 1, using: >=), descriptionSuffix)
    XCTAssertTrue(test(array: f2d41, against: 1, using: >=), descriptionSuffix)
    XCTAssertFalse(test(array: f2d14, against: 2, using: >=), descriptionSuffix)
    XCTAssertFalse(test(array: f2d41, against: 2, using: >=), descriptionSuffix)

    /*
     Test the test function for a 3d array and a value.
     */

    XCTAssertTrue(test(array: f3d14_44, against: 1, using: >=), descriptionSuffix)
    XCTAssertTrue(test(array: f3d44_41, against: 1, using: >=), descriptionSuffix)
    XCTAssertFalse(test(array: f3d14_44, against: 2, using: >=), descriptionSuffix)
    XCTAssertFalse(test(array: f3d44_41, against: 2, using: >=), descriptionSuffix)

    /*
     Test the test function for two 1d arrays.
     */

    XCTAssertTrue(test(array: f1d1, against: f1d1, using: ==), descriptionSuffix)
    XCTAssertFalse(test(array: f1d1, against: f1d4, using: ==), descriptionSuffix)

    XCTAssertTrue(test(array: f1d1, against: f1d4,
                       using: equalWithAccuracyPassBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f1d1, against: f1d4,
                        using: equalWithAccuracyFailBlock), descriptionSuffix)

    /*
     Test the test function for two 2d arrays.
     */

    XCTAssertTrue(test(array: f2d14, against: f2d14, using: ==), descriptionSuffix)
    XCTAssertFalse(test(array: f2d41, against: f2d14, using: ==), descriptionSuffix)

    XCTAssertTrue(test(array: f2d14, against: f2d14,
                       using: equalWithAccuracyPassBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f2d41, against: f2d14,
                        using: equalWithAccuracyFailBlock), descriptionSuffix)

    /*
     Test the test function for two 3d arrays.
     */

    XCTAssertTrue(test(array: f3d14_14, against: f3d14_14, using: ==), descriptionSuffix)
    XCTAssertFalse(test(array: f3d14_41, against: f3d14_14, using: ==), descriptionSuffix)

    XCTAssertTrue(test(array: f3d14_14, against: f3d14_14,
                       using: equalWithAccuracyPassBlock), descriptionSuffix)
    XCTAssertFalse(test(array: f3d14_41, against: f3d14_14,
                        using: equalWithAccuracyFailBlock), descriptionSuffix)

  }

  /// Tests the functionality of the assertions.
  func testAssertions() {

    let s1d1 = ["a", "b"]
    let s1d2 = ["c", "d"]

    let s2d11 = [s1d1, s1d1]
    let s2d12 = [s1d1, s1d2]
    let s2d21 = [s1d2, s1d1]
    let s2d22 = [s1d2, s1d2]

    let s3d11_22 = [s2d11, s2d22]
    let s3d12_21 = [s2d12, s2d21]

    let f1d1: [Float] = [1, 2, 3, 4, 5]
    let f1d2: [Float] = [1, 2, 3, .nan, 5]
    let f1d3: [Float] = [1, 2, 3, .infinity, 5]
    let f1d4: [Float] = [5, 5, 5, 5, 5]

    let f2d12 = [f1d1, f1d2]
    let f2d14 = [f1d1, f1d4]
    let f2d31 = [f1d3, f1d1]
    let f2d41 = [f1d4, f1d1]
    let f2d11 = [f1d1, f1d1]
    let f2d44 = [f1d4, f1d4]

    let f3d11_11 = [f2d11, f2d11]
    let f3d14_41 = [f2d14, f2d41]
    let f3d11_12 = [f2d11, f2d12]
    let f3d11_31 = [f2d11, f2d31]

    let c1d1: [DSPComplex] = [1+1⍳, 2+2⍳, 3+3⍳, 4+4⍳, 5+5⍳]
    let c1d2: [DSPComplex] = [5+5⍳, 4+4⍳, 3+3⍳, 2+2⍳, 1+1⍳]

    let c2d11 = [c1d1, c1d1]
    let c2d12 = [c1d1, c1d2]
    let c2d21 = [c1d2, c1d1]

    let c3d11_11 = [c2d11, c2d11]
    let c3d12_21 = [c2d12, c2d21]

    /*
     Test multi-dimensional arrays of an equatable type.
     */

    XCTAssertTrue(XCTAssertEqual(s2d11, s2d11), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(s2d11, s2d12), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(s3d11_22, s3d11_22), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(s3d11_22, s3d12_21), descriptionSuffix)


    /*
     Test equal with accuracy.
     */

    XCTAssertTrue(XCTAssertEqual(f1d1, f1d1, accuracy: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(f1d1, f1d4, accuracy: 5), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(f1d1, f1d4, accuracy: 1), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(f2d11, f2d11, accuracy: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(f2d11, f2d14, accuracy: 5), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(f2d11, f2d14, accuracy: 1), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(f3d11_11, f3d11_11, accuracy: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(f3d11_11, f3d14_41, accuracy: 5), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(f3d11_11, f3d14_41, accuracy: 1), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(c1d1, c1d1, accuracy: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(c1d1, c1d2, accuracy: 5), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(c1d1, c1d2, accuracy: 1), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(c2d11, c2d11, accuracy: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(c2d11, c2d12, accuracy: 5), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(c2d11, c2d12, accuracy: 1), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(c3d11_11, c3d11_11, accuracy: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(c3d11_11, c3d12_21, accuracy: 5), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(c3d11_11, c3d12_21, accuracy: 1), descriptionSuffix)



    /*
     Test equal with deviation.
     */

    XCTAssertTrue(XCTAssertEqual(Float(2), Float(4), deviation: 60), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(Float(2), Float(4), deviation: 30), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(f1d1, f1d1, deviation: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(f1d1, f1d4, deviation: 90), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(f1d1, f1d4, deviation: 10), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(f2d11, f2d11, deviation: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(f2d11, f2d14, deviation: 90), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(f2d11, f2d14, deviation: 10), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(f3d11_11, f3d11_11, deviation: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(f3d11_11, f3d14_41, deviation: 90), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(f3d11_11, f3d14_41, deviation: 10), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(c1d1, c1d1, deviation: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(c1d1, c1d2, deviation: 500), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(c1d1, c1d2, deviation: 100), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(c2d11, c2d11, deviation: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(c2d11, c2d12, deviation: 500), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(c2d11, c2d12, deviation: 100), descriptionSuffix)

    XCTAssertTrue(XCTAssertEqual(c3d11_11, c3d11_11, deviation: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertEqual(c3d11_11, c3d12_21, deviation: 500), descriptionSuffix)
    XCTAssertFalse(XCTAssertEqual(c3d11_11, c3d12_21, deviation: 100), descriptionSuffix)

    /*
     Test not nan or inf.
     */

    XCTAssertTrue(XCTAssertNotNaNOrInf(Float(4)), descriptionSuffix)
    XCTAssertFalse(XCTAssertNotNaNOrInf(Float.nan), descriptionSuffix)
    XCTAssertFalse(XCTAssertNotNaNOrInf(Float.infinity), descriptionSuffix)

    XCTAssertTrue(XCTAssertNotNaNOrInf(f1d1), descriptionSuffix)
    XCTAssertFalse(XCTAssertNotNaNOrInf(f1d2), descriptionSuffix)
    XCTAssertFalse(XCTAssertNotNaNOrInf(f1d3), descriptionSuffix)

    XCTAssertTrue(XCTAssertNotNaNOrInf(f2d14), descriptionSuffix)
    XCTAssertFalse(XCTAssertNotNaNOrInf(f2d12), descriptionSuffix)
    XCTAssertFalse(XCTAssertNotNaNOrInf(f2d31), descriptionSuffix)

    XCTAssertTrue(XCTAssertNotNaNOrInf(f3d11_11), descriptionSuffix)
    XCTAssertFalse(XCTAssertNotNaNOrInf(f3d11_12), descriptionSuffix)
    XCTAssertFalse(XCTAssertNotNaNOrInf(f3d11_31), descriptionSuffix)

    /*
     Test ≥ for arrays..
     */

    XCTAssertTrue(XCTAssertGreaterThanOrEqual(f1d1, 0), descriptionSuffix)
    XCTAssertFalse(XCTAssertGreaterThanOrEqual(f1d1, 2), descriptionSuffix)

    XCTAssertTrue(XCTAssertGreaterThanOrEqual(f2d11, 0), descriptionSuffix)
    XCTAssertFalse(XCTAssertGreaterThanOrEqual(f2d11, 2), descriptionSuffix)

    XCTAssertTrue(XCTAssertGreaterThanOrEqual(f3d11_11, 0), descriptionSuffix)
    XCTAssertFalse(XCTAssertGreaterThanOrEqual(f3d11_11, 2), descriptionSuffix)

    /*
     Test average equal using accuracy and deviation.
     */

    XCTAssertTrue(XCTAssertAverageEqual(f1d1, 3, accuracy: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertAverageEqual(f1d1, 3, accuracy: 10), descriptionSuffix)
    XCTAssertTrue(XCTAssertAverageEqual(f1d1, 4, accuracy: 10), descriptionSuffix)
    XCTAssertFalse(XCTAssertAverageEqual(f1d1, 4, accuracy: 0), descriptionSuffix)
    XCTAssertFalse(XCTAssertAverageEqual(f1d1, 10, accuracy: 4), descriptionSuffix)

    XCTAssertTrue(XCTAssertAverageEqual(f1d1, 3, deviation: 0), descriptionSuffix)
    XCTAssertTrue(XCTAssertAverageEqual(f1d1, 3, deviation: 10), descriptionSuffix)
    XCTAssertTrue(XCTAssertAverageEqual(f1d1, 4, deviation: 26), descriptionSuffix)
    XCTAssertFalse(XCTAssertAverageEqual(f1d1, 4, deviation: 0), descriptionSuffix)
    XCTAssertFalse(XCTAssertAverageEqual(f1d1, 4, deviation: 24), descriptionSuffix)

    /*
     Test difference mean ≤.
     */

    XCTAssertTrue(XCTAssertDifferenceMeanLessThanOrEqual(f1d1, f1d4, 2), descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanLessThanOrEqual(f1d1, f1d4, 3), descriptionSuffix)
    XCTAssertFalse(XCTAssertDifferenceMeanLessThanOrEqual(f1d1, f1d4, 1), descriptionSuffix)

    XCTAssertTrue(XCTAssertDifferenceMeanLessThanOrEqual(f2d11, f2d44, 2), descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanLessThanOrEqual(f2d11, f2d44, 3), descriptionSuffix)
    XCTAssertFalse(XCTAssertDifferenceMeanLessThanOrEqual(f2d11, f2d44, 1), descriptionSuffix)

    XCTAssertTrue(XCTAssertDifferenceMeanLessThanOrEqual(c1d1, c1d2, 2.4), descriptionSuffix)
    XCTAssertFalse(XCTAssertDifferenceMeanLessThanOrEqual(c1d1, c1d2, 2), descriptionSuffix)

/*
     1 5  4
     2 4  2
     3 3  0
     4 2  2
     5 1  4
     ──────
          2.4
 */


    /*
     Test deviation ≤.
     */

    XCTAssertTrue(XCTAssertPercentDeviationLessThanOrEqual(f1d1, f1d4, 40), descriptionSuffix)
    XCTAssertTrue(XCTAssertPercentDeviationLessThanOrEqual(f1d1, f1d4, 50), descriptionSuffix)
    XCTAssertFalse(XCTAssertPercentDeviationLessThanOrEqual(f1d1, f1d4, 10), descriptionSuffix)

    XCTAssertTrue(XCTAssertPercentDeviationLessThanOrEqual(f2d11, f2d44, 40), descriptionSuffix)
    XCTAssertTrue(XCTAssertPercentDeviationLessThanOrEqual(f2d11, f2d44, 50), descriptionSuffix)
    XCTAssertFalse(XCTAssertPercentDeviationLessThanOrEqual(f2d11, f2d44, 10), descriptionSuffix)

    XCTAssertTrue(XCTAssertPercentDeviationLessThanOrEqual(c1d1, c1d2, 126), descriptionSuffix)
    XCTAssertTrue(XCTAssertPercentDeviationLessThanOrEqual(c1d1, c1d2, 130), descriptionSuffix)
    XCTAssertFalse(XCTAssertPercentDeviationLessThanOrEqual(c1d1, c1d2, 100), descriptionSuffix)

    /*
     Test difference mean or deviation ≤.
     */

    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f1d1, f1d4,
                                                                    mean: 2, deviation: 10),
                  descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f1d1, f1d4,
                                                                    mean: 3, deviation: 10),
                  descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f1d1, f1d4,
                                                                    mean: 1, deviation: 40),
                  descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f1d1, f1d4,
                                                                    mean: 1, deviation: 50),
                  descriptionSuffix)

    XCTAssertFalse(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f1d1, f1d4,
                                                                     mean: 1, deviation: 10),
                   descriptionSuffix)

    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f2d11, f2d44,
                                                                    mean: 2, deviation: 10),
                  descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f2d11, f2d44,
                                                                    mean: 3, deviation: 10),
                  descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f2d11, f2d44,
                                                                    mean: 1, deviation: 40),
                  descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f2d11, f2d44,
                                                                    mean: 1, deviation: 50),
                  descriptionSuffix)

    XCTAssertFalse(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(f2d11, f2d44,
                                                                     mean: 1, deviation: 10),
                   descriptionSuffix)

    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(c1d1, c1d2,
                                                                    mean: 5.5, deviation: 100),
                  descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(c1d1, c1d2,
                                                                    mean: 5, deviation: 126),
                  descriptionSuffix)
    XCTAssertTrue(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(c1d1, c1d2,
                                                                    mean: 5, deviation: 130),
                  descriptionSuffix)

    XCTAssertFalse(XCTAssertDifferenceMeanOrDeviationLessThanOrEqual(c1d1, c1d2,
                                                                     mean: 2, deviation: 100),
                   descriptionSuffix)

  }

}
