import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextWidget extends StatefulWidget {
  const SpeechToTextWidget({super.key});

  @override
  State<SpeechToTextWidget> createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    final enabled = await _speechToText.initialize(
      onStatus: (status) {
        print("Speech recognition status changed");
        print(status);
      },
      onError: (error) {
        print(error);
      },
    );

    if (enabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {
        _speechEnabled = enabled;
      });
    }
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    print("result");
    print(result);
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_lastWords),
        GestureDetector(
          onTap: () {
            _speechToText.isNotListening ? _startListening() : _stopListening();
          },
          child: Icon(
            _speechToText.isListening ? Icons.mic : Icons.mic_off,
            size: 20,
          ),
        ),
      ],
    );
  }
}
