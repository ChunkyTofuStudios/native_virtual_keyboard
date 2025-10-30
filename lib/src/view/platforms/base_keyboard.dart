import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/src/model/virtual_keyboard_key.dart';
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

  const BaseKeyboard({super.key, required this.controller});

  KeyboardTheme getTheme(Brightness brightness);

  KeyboardDimensionsConfig getDimensionsConfig();

  OverlayFollowerBuilder overlayFollowerBuilder();

  @override
  State<BaseKeyboard> createState() => _BaseKeyboardState();
}

class _BaseKeyboardState extends State<BaseKeyboard> {
  final AutoSizeGroup _autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    final theme = widget.getTheme(MediaQuery.platformBrightnessOf(context));
    final dimensions = KeyboardDimensions.compute(
      widget.getDimensionsConfig(),
      MediaQuery.sizeOf(context).width,
      widget.controller.layout,
    );

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
            for (final row in widget.controller.layout.layout)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final (index, key) in row.indexed) ...[
                    if (key.special && index > 0) const Spacer(),
                    _Key(
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
                              dimensions.keyDimensions.horizontalSpacing / 2,
                          vertical:
                              dimensions.keyDimensions.verticalSpacing / 2,
                        ),
                        theme: theme,
                        autoSizeGroup: _autoSizeGroup,
                        overlayFollowerBuilder: widget.overlayFollowerBuilder(),
                        controller: widget.controller,
                      ),
                    ),
                    if (key.special && index < row.length - 1) const Spacer(),
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
  });
}

class _Key extends StatefulWidget {
  final KeyParams data;

  const _Key({required this.data});

  @override
  State<_Key> createState() => _KeyState();
}

class _KeyState extends State<_Key> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _overlayLayerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _overlayLayerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) => Positioned(
          width: widget.data.overlaySize.width,
          height: widget.data.overlaySize.height,
          bottom: 0,
          child: widget.data.overlayFollowerBuilder(
            context,
            _overlayLayerLink,
            widget.data,
          ),
        ),
        child: _ActiveKey(
          data: widget.data,
          overlayController: _overlayController,
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.data.controller.onKeyPress?.call(widget.data.key),
      onTapDown: (_) {
        if (!mounted) return;
        widget.data.controller.onKeyDown?.call(widget.data.key);
        if (!widget.data.key.special) {
          widget.overlayController.show();
        }
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        if (!mounted) return;
        widget.data.controller.onKeyUp?.call(widget.data.key);
        if (widget.overlayController.isShowing) {
          widget.overlayController.hide();
        }
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        if (!mounted) return;
        widget.data.controller.onKeyUp?.call(widget.data.key);
        if (widget.overlayController.isShowing) {
          widget.overlayController.hide();
        }
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

  Color _backgroundColor() => data.key.special
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

  Color _foregroundColor() => data.key.special
      ? data.theme.specialKeyTheme.foregroundColor
      : data.theme.keyTheme.foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: data.size.width,
      height: data.size.height,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: data.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(data.borderRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: _backgroundColor(),
            borderRadius: BorderRadius.circular(data.borderRadius),
          ),
          child: Center(
            child: data.key.special
                ? FractionallySizedBox(
                    widthFactor: 0.55,
                    heightFactor: 0.8,
                    child: FittedBox(
                      child: Icon(
                        data.key.icon,
                        fill:
                            isPressed &&
                                data.theme.specialKeyTheme.pressedFillIcon
                            ? 1
                            : 0,
                        weight: 600,
                        color: _foregroundColor(),
                      ),
                    ),
                  )
                : AutoSizeText(
                    data.key.text,
                    style:
                        (data.controller.textTheme ??
                                TextTheme.of(context).bodyLarge)
                            ?.copyWith(color: _foregroundColor()),
                    minFontSize: 4,
                    maxLines: 1,
                    group: data.autoSizeGroup,
                  ),
          ),
        ),
      ),
    );
  }
}
