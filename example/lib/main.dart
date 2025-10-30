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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Platform:'),
                        SizedBox(width: 6),
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
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: TextField(
                        controller: _textController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        minLines: 5,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
              VirtualKeyboard(
                platform: _selectedPlatform,
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
