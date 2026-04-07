import 'package:web/web.dart' as web;

void toggleWebFullscreen(bool enable) {
  final document = web.window.document;
  if (enable) {
    document.documentElement?.requestFullscreen();
  } else {
    // Only exit if we are currently in fullscreen
    if (document.fullscreenElement != null) {
      document.exitFullscreen();
    }
  }
}
