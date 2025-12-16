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
                                (platform) => DropdownMenuItem(
                                  value: platform,
                                  child: Text(platform.name),
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
                        title: const Text('Custom Colors (Red/Yellow)'),
                        value: _customColors,
                        onChanged: (v) => setState(() => _customColors = v),
                      ),
                      SwitchListTile(
                        title: const Text('Custom Font (Serif/Bold)'),
                        value: _customStyle,
                        onChanged: (v) => setState(() => _customStyle = v),
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
                keyColor: _customColors ? Colors.yellow.shade200 : null,
                keyIconColor: _customColors ? Colors.red : null,
                // Custom Styles
                keyTextStyle: _customStyle
                    ? const TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      )
                    : null,
                // Example of passing a TextTheme
                textTheme: _customStyle
                    ? TextTheme(
                        bodyLarge: TextStyle(
                          fontSize: 24,
                          color: Colors.blue.shade900,
                        ),
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
