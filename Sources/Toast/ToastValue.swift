import Foundation
import SwiftUI

/// Action button configuration for a toast
public struct ToastAction {
  public let title: String
  public let action: () -> Void
  
  public init(title: String, action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }
}

/// Represents a toast notification with customizable content and behavior.
public struct ToastValue {
  internal var icon: AnyView?
  internal var message: String
  /// If nil, the toast will persist and not disappear. Used when displaying a loading toast.
  internal var duration: TimeInterval?
  public var style: ToastStyle
  /// Optional action button to display on the toast
  public var toastAction: ToastAction?

  /// Creates a new toast with the specified content and behavior.
  ///
  /// - Parameters:
  ///   - icon: An optional view to display as an icon in the toast.
  ///   - message: The text content of the toast.
  ///   - duration: How long the toast should be displayed before automatically dismissing, in seconds. Clamped between 0 and 10 seconds. Default is 3.0.
  ///   - style: Visual style for the toast (normal, warning, destructive). Default is `.normal`.
  ///   - action: Optional action button configuration.
  public init(
    icon: (any View)? = nil,
    message: String,
    duration: TimeInterval = 3.0,
    style: ToastStyle = .normal,
    action: ToastAction? = nil
  ) {
    self.icon = icon.map { AnyView($0) }
    self.message = message
    self.duration = min(max(0, duration), 10)
    self.style = style
    self.toastAction = action
  }
  @_disfavoredOverload
  internal init(
    icon: (any View)? = nil,
    message: String,
    duration: TimeInterval? = nil,
    style: ToastStyle = .normal,
    action: ToastAction? = nil
  ) {
    self.icon = icon.map { AnyView($0) }
    self.message = message
    self.duration = duration
    self.style = style
    self.toastAction = action
  }
}
