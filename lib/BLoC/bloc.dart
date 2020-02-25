// All BLoC classes will conform to this interface,
// to ensure we add a dispose method to close streams and prevent data leaks.

abstract class Bloc {
  void dispose();
}
