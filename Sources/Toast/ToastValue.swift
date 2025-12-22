import Foundation
import SwiftUI

/// Represents a toast notification with customizable content and behavior.
public struct ToastValue {
  internal var icon: AnyView?
  internal var message: String
  /// If nil, the toast will persist and not disappear. Used when displaying a loading toast.
  internal var duration: TimeInterval?
  public var style: ToastStyle

  /// Creates a new toast with the specified content and behavior.
  ///
  /// - Parameters:
  ///   - icon: An optional view to display as an icon in the toast.
  ///   - message: The text content of the toast.
  ///   - duration: How long the toast should be displayed before automatically dismissing, in seconds. Clamped between 0 and 10 seconds. Default is 3.0.
  ///   - style: Visual style for the toast (normal, warning, destructive). Default is `.normal`.
  public init(
    icon: (any View)? = nil,
    message: String,
    duration: TimeInterval = 3.0,
    style: ToastStyle = .normal
  ) {
    self.icon = icon.map { AnyView($0) }
    self.message = message
    self.duration = min(max(0, duration), 10)
    self.style = style
  }
  @_disfavoredOverload
  internal init(
    icon: (any View)? = nil,
    message: String,
    duration: TimeInterval? = nil,
    style: ToastStyle = .normal
  ) {
    self.icon = icon.map { AnyView($0) }
    self.message = message
    self.duration = duration
    self.style = style
  }
}
