//
//  Attachments.swift
//  EssentiaTests
//
//  Created by Jason Cardwell on 11/7/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation
import XCTest

extension XCTAttachment {

  public convenience init(data payload: Data, lifetime: XCTAttachment.Lifetime) {
    self.init(data: payload)
    self.lifetime = lifetime
  }

  public convenience init(data payload: Data,
                          uniformTypeIdentifier identifier: String,
                          lifetime: XCTAttachment.Lifetime)
  {
    self.init(data: payload, uniformTypeIdentifier: identifier)
    self.lifetime = lifetime
  }

  public convenience init(string: String, lifetime: XCTAttachment.Lifetime) {
    self.init(string: string)
    self.lifetime = lifetime
  }

  public convenience init(archivableObject object: NSSecureCoding,
                          lifetime: XCTAttachment.Lifetime)
  {
    self.init(archivableObject: object)
    self.lifetime = lifetime
  }

  public convenience init(archivableObject object: NSSecureCoding,
                          uniformTypeIdentifier identifier: String,
                          lifetime: XCTAttachment.Lifetime)
  {
    self.init(archivableObject: object, uniformTypeIdentifier: identifier)
    self.lifetime = lifetime
  }

  public convenience init(plistObject object: Any, lifetime: XCTAttachment.Lifetime) {
    self.init(plistObject: object)
    self.lifetime = lifetime
  }

  public convenience init(contentsOfFile url: URL, lifetime: XCTAttachment.Lifetime) {
    self.init(contentsOfFile: url)
    self.lifetime = lifetime
  }

  #if os(iOS)

  public convenience init(image: UIImage, lifetime: XCTAttachment.Lifetime) {
    self.init(image: image)
    self.lifetime = lifetime
  }

  public convenience init(image: UIImage,
                          quality: XCTAttachment.ImageQuality,
                          lifetime: XCTAttachment.Lifetime)
  {
    self.init(image: image, quality: quality)
    self.lifetime = lifetime
  }

  #elseif os(OSX)

  public convenience init(image: NSImage, lifetime: XCTAttachment.Lifetime) {
    self.init(image: image)
    self.lifetime = lifetime
  }

  public convenience init(image: NSImage,
                          quality: XCTAttachment.ImageQuality,
                          lifetime: XCTAttachment.Lifetime)
  {
    self.init(image: image, quality: quality)
    self.lifetime = lifetime
  }

  #endif

  public convenience init(screenshot: XCUIScreenshot, lifetime: XCTAttachment.Lifetime) {
    self.init(screenshot: screenshot)
    self.lifetime = lifetime
  }

  public convenience init(screenshot: XCUIScreenshot,
                          quality: XCTAttachment.ImageQuality,
                          lifetime: XCTAttachment.Lifetime)
  {
    self.init(screenshot: screenshot, quality: quality)
    self.lifetime = lifetime
  }

}
