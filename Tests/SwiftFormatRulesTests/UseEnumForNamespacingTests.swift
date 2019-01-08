import Foundation
import SwiftSyntax
import XCTest

@testable import SwiftFormatRules

public class UseEnumForNamespacingTests: DiagnosingTestCase {
  public func testNonEnumsUsedAsNamespaces() {
    XCTAssertFormatting(
      UseEnumForNamespacing.self,
      input: """
             struct A {
               static func foo() {}
               private init() {}
             }
             struct B {
               var x: Int = 3
               static func foo() {}
               private init() {}
             }
             class C {
               static func foo() {}
             }
             public final class D {
               static func bar()
             }
             """,
      expected: """
                enum A {
                  static func foo() {}
                }
                struct B {
                  var x: Int = 3
                  static func foo() {}
                  private init() {}
                }
                enum C {
                  static func foo() {}
                }
                public enum D {
                  static func bar()
                }
                """)
  }

#if !os(macOS)
  static let allTests = [
    UseEnumForNamespacingTests.testNonEnumsUsedAsNamespaces,
  ]
#endif

}
