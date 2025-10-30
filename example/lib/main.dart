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
        appBar: AppBar(title: const Text('Native Virtual Keyboard')),
        body: Center(
          child: Column(
            children: [
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
                onChanged: (value) => setState(() => _selectedPlatform = value),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _textController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              VirtualKeyboard(
                platform: _selectedPlatform,
                controller: VirtualKeyboardController(
                  layout: EnglishQwertyKeyboardLayout(),
                  onKeyPress: (key) {
                    final text = _textController.text;
                    if (key == VirtualKeyboardKey.backspace &&
                        text.isNotEmpty) {
                      _textController.text = text.substring(0, text.length - 1);
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
