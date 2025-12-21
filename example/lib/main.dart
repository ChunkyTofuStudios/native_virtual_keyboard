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
  KeyboardPlatform? _selectedPlatform;
  final _textController = TextEditingController();

  // Theming state
  bool _customColors = false;
  bool _customStyle = false;
  bool _showEnter = true;
  bool _showBackspace = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Virtual Keyboard'),
          backgroundColor: const Color.fromARGB(255, 135, 191, 237),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Platform:'),
                          const SizedBox(width: 6),
                          DropdownButton<KeyboardPlatform?>(
                            value: _selectedPlatform,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('Auto-detect'),
                              ),
                              ...KeyboardPlatform.values.map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              ),
                            ],
                            onChanged: (value) =>
                                setState(() => _selectedPlatform = value),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Theme Controls
                      SwitchListTile(
                        title: const Text('Custom Colors (Red/Yellow/Orange)'),
                        value: _customColors,
                        onChanged: (value) {
                          setState(() {
                            _customColors = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Custom Font (Serif/Bold)'),
                        value: _customStyle,
                        onChanged: (v) => setState(() => _customStyle = v),
                      ),
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
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: TextField(
                          controller: _textController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Input',
                          ),
                          minLines: 3,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              VirtualKeyboard(
                platform: _selectedPlatform,
                // Custom colors
                backgroundColor: _customColors ? Colors.red.shade100 : null,
                keyBackgroundColor: _customColors
                    ? Colors.yellow.shade200
                    : null,
                specialKeyBackgroundColor: _customColors
                    ? Colors.orange.shade200
                    : null,
                keyIconColor: _customColors ? Colors.red : null,

                showEnter: _showEnter,
                showBackspace: _showBackspace,
                // Custom Styles
                keyTextStyle: _customStyle
                    ? const TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      )
                    : null,

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
            ],
          ),
        ),
      ),
    );
  }
}
