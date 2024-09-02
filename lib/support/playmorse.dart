import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();

Future<void> playMorseCode(String morseCode) async {
  for (int i = 0; i < morseCode.length; i++) {
    String symbol = morseCode[i];
    if (symbol == '.') {
      await _playDot();
    } else if (symbol == '-') {
      await _playDash();
    } else if (symbol == ' ') {
      await Future.delayed(Duration(milliseconds: 200));  // Space between letters
    } else if (symbol == '/') {
      await Future.delayed(Duration(milliseconds: 600));  // Space between words
    }
  }
}

Future<void> _playDot() async {
  // Play a short beep for dot
  await audioPlayer.play(AssetSource('dot.wav')); 
  await Future.delayed(Duration(milliseconds: 200)); // Delay for symbol length
}

Future<void> _playDash() async {
  // Play a long beep for dash
  await audioPlayer.play(AssetSource('dash.wav')); 
  await Future.delayed(Duration(milliseconds: 600)); // Delay for symbol length
}
