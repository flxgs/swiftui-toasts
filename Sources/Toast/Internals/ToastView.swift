import SwiftUI

internal struct ToastView: View {
  @ObservedObject var model: ToastModel
  @Environment(\.colorScheme) private var colorScheme
  var onActionTapped: (() -> Void)?

  private var isDark: Bool { colorScheme == .dark }
  private var backgroundColor: Color {
    switch model.style {
    case .normal:
      return Color.toastBackground
    case .success:
      return Color.green
    case .warning:
      return Color.orange
    case .destructive:
      return Color.red
    }
  }
  private var textColor: Color {
    switch model.style {
    case .normal:
      return .primary
    case .success, .warning, .destructive:
      return .white
    }
  }
  
  private var actionButtonColor: Color {
    switch model.style {
    case .normal:
      return .blue
    case .success, .warning, .destructive:
      return .white.opacity(0.9)
    }
  }

  var body: some View {
    main
      ._background {
        Capsule().fill(backgroundColor)
      }
      // Keep the classic pill height while still allowing content to grow if needed
      .frame(minHeight: 48, maxHeight: 120)
      .fixedSize(horizontal: false, vertical: true)
      .compositingGroup()
      .shadow(color: .primary.opacity(isDark ? 0.0 : 0.1), radius: 16, y: 8.0)
  }

  private var main: some View {
    HStack(spacing: 10) {
      if let icon = model.icon {
        icon
          .frame(width: 19, height: 19)
          .padding(.leading, 15)
      } else {
        Color.clear
          .frame(width: 14)
      }
      Text(model.message)
        .lineLimit(4)
        .fixedSize(horizontal: false, vertical: true)
        ._foregroundColor(textColor)
        .id(model.message)
        .transition(.asymmetric(
            insertion: .opacity
                .animation(.spring(duration: 0.3).delay(0.3)),
            removal: .opacity
                .animation(.spring(duration: 0.3))
        ))
      
      if let toastAction = model.toastAction {
        Button(action: {
          toastAction.action()
          onActionTapped?()
        }) {
          Text(toastAction.title)
            .font(.system(size: 14, weight: .semibold))
            ._foregroundColor(actionButtonColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
              Capsule()
                .fill(actionButtonColor.opacity(0.2))
            )
        }
        .padding(.trailing, 12)
      } else {
        Color.clear
          .frame(width: 14)
      }
    }
    .font(.system(size: 16, weight: .medium))
    .padding(.vertical, 8)
  }
}

@available(iOS 17.0, *)
#Preview {
  VStack {
    ToastView(
      model: .init(
        value:
          .init(
            icon: Image(systemName: "info.circle"),
            message: "This is a toast message"
          )
      )
    )
    ToastView(
      model: .init(
        value:
          .init(
            icon: Image(systemName: "checkmark.circle"),
            message: "Success!"
          )
      )
    )
    ToastView(
      model: .init(
        value:
          .init(
            icon: nil,
            message: "This is a message-only toast"
          )
      )
    )
    ToastView(
      model: .init(
        value:
          .init(
            icon: Image(systemName: "exclamationmark.triangle"),
            message: "Warning toast",
            style: .warning
          )
      )
    )
    ToastView(
      model: .init(
        value:
          .init(
            icon: Image(systemName: "xmark.circle"),
            message: "Error toast",
            style: .destructive
          )
      )
    )
    // Toast with action button
    ToastView(
      model: .init(
        value:
          .init(
            icon: Image(systemName: "exclamationmark.triangle"),
            message: "Limit reached",
            style: .warning,
            action: ToastAction(title: "Upgrade", action: {})
          )
      )
    )
    .padding(20)
    .background {
      Color.black
    }
    .environment(\.colorScheme, .dark)
  }
}
