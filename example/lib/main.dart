import 'package:flutter/material.dart';
import 'package:native_virtual_keyboard/native_virtual_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Config state
  KeyboardPlatform? _selectedPlatform;
  bool _useCustomTheme = false;
  bool _showEnter = true;
  bool _showBackspace = true;
  Set<String> _disabledKeys = {'Q', 'W', 'E'}; // Demo: disable some keys
  bool _enableDisabledKeys = true;

  // Text controller
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Example of a completely custom theme (e.g. "Midnight Blue")
  KeyboardTheme get _customTheme {
    // Start with a base, or build from scratch
    return KeyboardTheme(
      backgroundColor: const Color(0xFF0F172A), // Dark slate
      keyTheme: const KeyboardKeyTheme(
        backgroundColor: Color(0xFF1E293B), // Slate 800
        pressedBackgroundColor: Color(0xFF334155), // Slate 700
        foregroundColor: Colors.white,
        shadows: [
          BoxShadow(color: Colors.black45, offset: Offset(0, 2), blurRadius: 2),
        ],
        // innerShadows: ... optional
        overlayBackgroundColor: Color(0xFF1E293B),
        overlayTextColor: Colors.white,
        keyTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto', // Or any custom font
        ),
      ),
      specialKeyTheme: const KeyboardSpecialKeyTheme(
        backgroundColor: Color(0xFF334155),
        pressedBackgroundColor: Color(0xFF475569),
        foregroundColor: Colors.white,
        pressedOverlayColor: Colors.white12,
        pressedFillIcon: true,
        shadows: [
          BoxShadow(color: Colors.black45, offset: Offset(0, 2), blurRadius: 2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Virtual Keyboard'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const Text(
                    'Configuration',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Platform Selector
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Simulated Platform',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<KeyboardPlatform?>(
                        value: _selectedPlatform,
                        isExpanded: true,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Auto-detect (System Default)'),
                          ),
                          ...KeyboardPlatform.values.map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)),
                          ),
                        ],
                        onChanged: (value) =>
                            setState(() => _selectedPlatform = value),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Theme Toggle
                  SwitchListTile(
                    title: const Text('Use Custom Theme'),
                    subtitle: const Text('Demonstrates full customization API'),
                    value: _useCustomTheme,
                    onChanged: (v) => setState(() => _useCustomTheme = v),
                  ),

                  // Key Toggles
                  SwitchListTile(
                    title: const Text('Show Enter Key'),
                    value: _showEnter,
                    onChanged: (v) => setState(() => _showEnter = v),
                  ),
                  SwitchListTile(
                    title: const Text('Show Backspace Key'),
                    value: _showBackspace,
                    onChanged: (v) => setState(() => _showBackspace = v),
                  ),
                  SwitchListTile(
                    title: const Text('Enable Disabled Keys Demo'),
                    subtitle: Text(
                      _enableDisabledKeys
                          ? 'Keys disabled: ${_disabledKeys.join(", ")}'
                          : 'All keys enabled',
                    ),
                    value: _enableDisabledKeys,
                    onChanged: (v) => setState(() => _enableDisabledKeys = v),
                  ),
                  if (_enableDisabledKeys)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Disabled Keys',
                          hintText: 'Enter letters to disable (e.g. ABC)',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _disabledKeys = value
                                .toUpperCase()
                                .split('')
                                .where((c) => c.trim().isNotEmpty)
                                .toSet();
                          });
                        },
                      ),
                    ),

                  const Divider(height: 32),

                  // Text Input visualization
                  TextField(
                    controller: _textController,
                    readOnly: true, // Prevent system keyboard
                    autofocus: true,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Typed Text',
                      hintText: 'Type using the virtual keyboard below...',
                      border: OutlineInputBorder(),
                      filled: true,
                    ),
                    minLines: 3,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            // The Keyboard Widget
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: VirtualKeyboard(
                platform: _selectedPlatform,
                // If _useCustomTheme is true, apply our custom "Midnight Blue" theme.
                // Otherwise, pass null to let the widget use the native platform default.
                theme: _useCustomTheme ? _customTheme : null,

                showEnter: _showEnter,
                showBackspace: _showBackspace,
                disabledKeys: _enableDisabledKeys ? _disabledKeys : {},
                controller: VirtualKeyboardController(
                  layout: EnglishQwertyKeyboardLayout(),
                  onKeyPress: (key) {
                    final text = _textController.text;

                    if (key == VirtualKeyboardKey.backspace) {
                      if (text.isNotEmpty) {
                        _textController.text = text.substring(
                          0,
                          text.length - 1,
                        );
                      }
                      return;
                    }

                    if (key == VirtualKeyboardKey.enter) {
                      _textController.text = '$text\n';
                      return;
                    }

                    _textController.text = text + key.text;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
