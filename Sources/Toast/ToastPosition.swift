import Foundation

/// Defines the vertical position where toasts will appear on screen.
public enum ToastPosition {
  /// Toast appears at the top of the screen.
  case top
  /// Toast appears at the bottom of the screen.
  case bottom
}

/// Visual style for the toast background / text color.
public enum ToastStyle {
  case normal
  case success
  case warning
  case destructive
}
