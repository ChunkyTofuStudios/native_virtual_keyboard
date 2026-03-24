import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/model/virtual_keyboard_key.dart';
import 'package:native_virtual_keyboard/src/view/inner_shadow_painter.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_animation.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_dimensions.dart';
import 'package:native_virtual_keyboard/src/view/keyboard_theme.dart';
import 'package:native_virtual_keyboard/src/view/virtual_keyboard_controller.dart';

typedef OverlayFollowerBuilder =
    CompositedTransformFollower Function(
      BuildContext context,
      LayerLink layerLink,
      KeyParams params,
    );

abstract class BaseKeyboard extends StatefulWidget {
  final VirtualKeyboardController controller;
  final KeyboardTheme? theme;
  final bool showEnter;
  final bool showBackspace;
  final double? specialKeyWidthMultiplier;
  final KeyboardAnimationConfig? animationConfig;

  const BaseKeyboard({
    super.key,
    required this.controller,
    this.theme,
    this.showEnter = true,
    this.showBackspace = true,
    this.specialKeyWidthMultiplier,
    this.animationConfig,
  });

  KeyboardTheme getTheme(Brightness brightness);

  KeyboardDimensionsConfig getDimensionsConfig();

  OverlayFollowerBuilder overlayFollowerBuilder();

  @override
  State<BaseKeyboard> createState() => _BaseKeyboardState();
}

class _BaseKeyboardState extends State<BaseKeyboard> {
  final AutoSizeGroup _autoSizeGroup = AutoSizeGroup();
  final Map<VirtualKeyboardKey, Duration> _keyToAnimationDelay = {};

  @override
  void initState() {
    super.initState();
    _populateAnimationDelays();
  }

  @override
  void didUpdateWidget(BaseKeyboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller.layout != widget.controller.layout ||
        oldWidget.animationConfig != widget.animationConfig) {
      _populateAnimationDelays();
    }
  }

  void _populateAnimationDelays() {
    final config = widget.animationConfig;
    final staggerPattern = config?.staggerPattern;
    if (config == null || staggerPattern == null) {
      if (mounted) {
        setState(() {
          _keyToAnimationDelay.clear();
        });
      } else {
        _keyToAnimationDelay.clear();
      }
      return;
    }

    final layout = widget.controller.layout.layout;
    var flatIndex = 0;
    final Map<VirtualKeyboardKey, Duration> newDelays = {};
    for (var r = 0; r < layout.length; r++) {
      for (var c = 0; c < layout[r].length; c++) {
        final key = layout[r][c];
        final staggerIndex = switch (staggerPattern) {
          StaggerPattern.sequential => flatIndex,
          StaggerPattern.diagonal => r + c,
        };
        newDelays[key] = config.staggerDelay * staggerIndex;
        flatIndex++;
      }
    }

    if (mounted) {
      setState(() {
        _keyToAnimationDelay
          ..clear()
          ..addAll(newDelays);
      });
    } else {
      _keyToAnimationDelay
        ..clear()
        ..addAll(newDelays);
    }
  }

  @override
  Widget build(BuildContext context) {
    final KeyboardTheme theme =
        widget.theme ??
        widget.getTheme(MediaQuery.platformBrightnessOf(context));

    final dimensions = KeyboardDimensions.compute(
      widget.getDimensionsConfig(),
      MediaQuery.sizeOf(context).width,
      widget.controller.layout,
      specialKeyWidthMultiplier: widget.specialKeyWidthMultiplier,
    );

    final animConfig = widget.animationConfig;
    final layout = widget.controller.layout.layout;

    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: theme.topBorderColor != null
            ? Border(top: BorderSide(color: theme.topBorderColor!, width: 0.7))
            : null,
        borderRadius: dimensions.topBorderRadius > 0
            ? BorderRadius.vertical(
                top: Radius.circular(dimensions.topBorderRadius),
              )
            : null,
      ),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: max(
                0,
                dimensions.topPadding -
                    dimensions.keyDimensions.verticalSpacing / 2,
              ),
            ),
            for (final row in layout)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final (colIndex, key) in row.indexed) ...[
                    if (key.special && colIndex > 0) const Spacer(),
                    Visibility(
                      visible:
                          !((key == VirtualKeyboardKey.enter &&
                                  !widget.showEnter) ||
                              (key == VirtualKeyboardKey.backspace &&
                                  !widget.showBackspace)),
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: ValueListenableBuilder(
                        valueListenable: widget.controller.enabledKeys,
                        builder: (context, enabledKeys, child) => _Key(
                          key: ValueKey(key),
                          data: KeyParams(
                            key: key,
                            size: key.special
                                ? dimensions.keyDimensions.specialSize
                                : dimensions.keyDimensions.size,
                            borderRadius: dimensions.keyDimensions.borderRadius,
                            elevation: dimensions.keyDimensions.elevation,
                            overlaySize: dimensions.keyDimensions.overlaySize,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  dimensions.keyDimensions.horizontalSpacing /
                                  2,
                              vertical:
                                  dimensions.keyDimensions.verticalSpacing / 2,
                            ),
                            theme: theme,
                            autoSizeGroup: _autoSizeGroup,
                            overlayFollowerBuilder: widget
                                .overlayFollowerBuilder(),
                            controller: widget.controller,
                            isDisabled:
                                enabledKeys != null &&
                                !enabledKeys.contains(key),
                            animationConfig: animConfig,
                            animationDelay:
                                _keyToAnimationDelay[key] ?? Duration.zero,
                          ),
                        ),
                      ),
                    ),
                    if (key.special && colIndex < row.length - 1)
                      const Spacer(),
                  ],
                ],
              ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

final class KeyParams {
  final VirtualKeyboardKey key;
  final Size size;
  final double borderRadius;
  final double elevation;
  final Size overlaySize;
  final EdgeInsets padding;
  final KeyboardTheme theme;
  final AutoSizeGroup autoSizeGroup;
  final OverlayFollowerBuilder overlayFollowerBuilder;
  final VirtualKeyboardController controller;
  final bool isDisabled;
  final KeyboardAnimationConfig? animationConfig;
  final Duration animationDelay;

  const KeyParams({
    required this.key,
    required this.size,
    required this.borderRadius,
    required this.elevation,
    required this.overlaySize,
    required this.padding,
    required this.theme,
    required this.autoSizeGroup,
    required this.overlayFollowerBuilder,
    required this.controller,
    this.isDisabled = false,
    this.animationConfig,
    this.animationDelay = Duration.zero,
  });

  /// Creates a copy with a different [isDisabled] value.
  ///
  /// Only this field is supported because [KeyParams] is internal
  /// and only the disabled state changes at runtime.
  KeyParams withDisabled(bool isDisabled) {
    return KeyParams(
      key: key,
      size: size,
      borderRadius: borderRadius,
      elevation: elevation,
      overlaySize: overlaySize,
      padding: padding,
      theme: theme,
      autoSizeGroup: autoSizeGroup,
      overlayFollowerBuilder: overlayFollowerBuilder,
      controller: controller,
      isDisabled: isDisabled,
      animationConfig: animationConfig,
      animationDelay: animationDelay,
    );
  }
}

class _Key extends StatefulWidget {
  final KeyParams data;

  const _Key({super.key, required this.data});

  @override
  State<_Key> createState() => _KeyState();
}

class _KeyState extends State<_Key> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _overlayLayerLink = LayerLink();

  /// The effective disabled state, which may be delayed for staggered animations
  /// so that the key retains its normal appearance until its turn arrives.
  ///
  /// Both the visual appearance (opacity) and the interactive state are derived
  /// from this single source of truth, ensuring they stay in sync.
  late bool _effectiveDisabled;
  Timer? _staggerDelayTimer;

  @override
  void initState() {
    super.initState();
    _effectiveDisabled = widget.data.isDisabled;
  }

  @override
  void didUpdateWidget(_Key oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.isDisabled != widget.data.isDisabled) {
      _staggerDelayTimer?.cancel();
      final delay = widget.data.animationDelay;

      if (delay == Duration.zero) {
        setState(() {
          _effectiveDisabled = widget.data.isDisabled;
        });
      } else {
        _staggerDelayTimer = Timer(delay, () {
          if (mounted) {
            setState(() {
              _effectiveDisabled = widget.data.isDisabled;
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _staggerDelayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveData = _effectiveDisabled == widget.data.isDisabled
        ? widget.data
        : widget.data.withDisabled(_effectiveDisabled);

    // Block taps immediately when the real state is disabled,
    // even if the stagger delay hasn't elapsed yet.
    final blockTaps = widget.data.isDisabled && !_effectiveDisabled;

    Widget child = CompositedTransformTarget(
      link: _overlayLayerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) => Positioned(
          width: widget.data.overlaySize.width,
          height: widget.data.overlaySize.height,
          bottom: 0,
          child: IgnorePointer(
            child: widget.data.overlayFollowerBuilder(
              context,
              _overlayLayerLink,
              widget.data,
            ),
          ),
        ),
        child: _ActiveKey(
          data: effectiveData,
          overlayController: _overlayController,
        ),
      ),
    );

    if (blockTaps) {
      child = IgnorePointer(child: child);
    }

    final config = widget.data.animationConfig;
    if (config == null) return child;

    final disabledOpacity =
        widget.data.theme.keyTheme.disabledBackgroundColor != null ? 1.0 : 0.4;
    final targetOpacity = _effectiveDisabled ? disabledOpacity : 1.0;

    return AnimatedOpacity(
      opacity: targetOpacity,
      duration: config.duration,
      curve: config.curve,
      child: child,
    );
  }
}

class _ActiveKey extends StatefulWidget {
  final KeyParams data;
  final OverlayPortalController overlayController;

  const _ActiveKey({required this.data, required this.overlayController});

  @override
  State<_ActiveKey> createState() => _ActiveKeyState();
}

class _ActiveKeyState extends State<_ActiveKey> {
  bool _isPressed = false;
  bool _hidePending = false;

  @override
  void didUpdateWidget(_ActiveKey oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data.isDisabled && !oldWidget.data.isDisabled) {
      _hideOverlayNow();
    }
  }

  void _hideOverlayNow() {
    _hidePending = false;
    if (!mounted) return;
    if (widget.overlayController.isShowing) {
      widget.overlayController.hide();
    }
  }

  /// Defers the overlay hide to a post-frame callback so the popup is
  /// guaranteed to be painted for at least one frame.  On devices with
  /// high-frequency touch sampling (e.g. ProMotion 120 Hz on iOS 18),
  /// pointer-down and pointer-up can arrive within the same vsync window.
  /// Without this deferral, [show] and [hide] execute in the same build
  /// pass and the overlay is never actually rendered.
  void _hideOverlayDeferred() {
    if (_hidePending) return;
    _hidePending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => _hideOverlayNow());
  }

  @override
  Widget build(BuildContext context) {
    // Disabled keys are not interactive
    if (widget.data.isDisabled) {
      // Safety net: if the overlay is still showing when the key becomes
      // disabled (e.g. due to stagger timing or rapid state changes),
      // hide it to prevent a stuck overlay controller.
      _hideOverlayNow();
      return Padding(
        padding: widget.data.padding,
        child: _KeyButton(data: widget.data, isPressed: false),
      );
    }

    return InkWell(
      onTap: () => widget.data.controller.onKeyPress?.call(widget.data.key),
      onTapDown: (_) {
        if (!mounted) return;
        widget.data.controller.onKeyDown?.call(widget.data.key);
        if (!widget.data.key.special) {
          // Defensive reset: if the controller thinks it's still showing
          // (e.g. after a mass rebuild triggered by enabledKeys change),
          // force-hide first so the subsequent show() is not a no-op.
          _hideOverlayNow();
          widget.overlayController.show();
        }
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        if (!mounted) return;
        widget.data.controller.onKeyUp?.call(widget.data.key);
        _hideOverlayDeferred();
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        if (!mounted) return;
        widget.data.controller.onKeyUp?.call(widget.data.key);
        _hideOverlayDeferred();
        setState(() {
          _isPressed = false;
        });
      },
      child: Padding(
        padding: widget.data.padding,
        child: _KeyButton(data: widget.data, isPressed: _isPressed),
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  final KeyParams data;
  final bool isPressed;

  const _KeyButton({required this.data, required this.isPressed});

  Color _backgroundColor() {
    if (data.isDisabled) {
      return data.theme.keyTheme.disabledBackgroundColor ??
          data.theme.keyTheme.backgroundColor.withValues(alpha: 0.4);
    }
    return data.key.special
        ? (isPressed
              ? Color.alphaBlend(
                  data.theme.specialKeyTheme.pressedOverlayColor ??
                      Colors.transparent,
                  data.theme.specialKeyTheme.pressedBackgroundColor,
                )
              : data.theme.specialKeyTheme.backgroundColor)
        : (isPressed
              ? data.theme.keyTheme.pressedBackgroundColor
              : data.theme.keyTheme.backgroundColor);
  }

  Color _foregroundColor() {
    if (data.isDisabled) {
      return data.theme.keyTheme.disabledForegroundColor ??
          data.theme.keyTheme.foregroundColor.withValues(alpha: 0.4);
    }
    return data.key.special
        ? data.theme.specialKeyTheme.foregroundColor
        : data.theme.keyTheme.foregroundColor;
  }

  List<BoxShadow>? _shadows() => data.key.special
      ? data.theme.specialKeyTheme.shadows
      : data.theme.keyTheme.shadows;

  List<BoxShadow>? _innerShadows() => data.key.special
      ? data.theme.specialKeyTheme.innerShadows
      : data.theme.keyTheme.innerShadows;

  @override
  Widget build(BuildContext context) {
    final innerShadows = _innerShadows();
    return SizedBox(
      width: data.size.width,
      height: data.size.height,
      child: CustomPaint(
        foregroundPainter: innerShadows != null && innerShadows.isNotEmpty
            ? InnerShadowPainter(
                shadows: innerShadows,
                borderRadius: BorderRadius.circular(data.borderRadius),
              )
            : null,
        child: Container(
          decoration: BoxDecoration(
            color: _backgroundColor(),
            borderRadius: BorderRadius.circular(data.borderRadius),
            boxShadow: _shadows(),
          ),
          child: Center(
            child: data.key.special
                ? _buildSpecialKeyContent(context)
                : _buildKeyContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKeyContent(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.55,
      heightFactor: 0.8,
      child: FittedBox(
        child: Icon(
          data.key.icon,
          fill: isPressed && (data.theme.specialKeyTheme.pressedFillIcon)
              ? 1
              : 0,
          weight: 600,
          color: _foregroundColor(),
        ),
      ),
    );
  }

  Widget _buildKeyContent(BuildContext context) {
    final keyTextStyle = data.theme.keyTheme.keyTextStyle;
    return AutoSizeText(
      data.key.text,
      style: (data.controller.textTheme ?? keyTextStyle)
          ?.copyWith(color: _foregroundColor())
          .merge(keyTextStyle),
      minFontSize: 4,
      maxLines: 1,
      group: data.autoSizeGroup,
    );
  }
}
