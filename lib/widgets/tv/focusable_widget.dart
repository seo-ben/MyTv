import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget focusable pour Android TV avec support du D-pad
/// Entoure n'importe quel widget pour le rendre navigable avec le D-pad
class FocusableWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool autofocus;
  final FocusNode? focusNode;
  final Color? focusColor;
  final double focusBorderWidth;
  final BorderRadius? borderRadius;

  const FocusableWidget({
    Key? key,
    required this.child,
    this.onPressed,
    this.autofocus = false,
    this.focusNode,
    this.focusColor,
    this.focusBorderWidth = 3.0,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<FocusableWidget> createState() => _FocusableWidgetState();
}

class _FocusableWidgetState extends State<FocusableWidget> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          // Handle D-pad center button and Enter key
          if (event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.space) {
            widget.onPressed?.call();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: _isFocused
                ? Border.all(
                    color: widget.focusColor ?? Colors.white,
                    width: widget.focusBorderWidth,
                  )
                : null,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Bouton focusable spécialement conçu pour Android TV
class TvFocusableButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool autofocus;
  final Color? backgroundColor;
  final Color? focusColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const TvFocusableButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.autofocus = false,
    this.backgroundColor,
    this.focusColor,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusableWidget(
      autofocus: autofocus,
      onPressed: onPressed,
      focusColor: focusColor,
      borderRadius: borderRadius,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.blue,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
