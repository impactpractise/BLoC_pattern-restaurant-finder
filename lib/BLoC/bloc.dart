// All BLoC classes will conform to this interface, which will force us to add a dispose method to close streams and prevent data leaks.

abstract class Bloc {
  void dispose();
}
