import 'package:flutter/cupertino.dart';
import 'package:restaurant_finder/BLoC/bloc.dart';

// 1. Generic BlocProvider class to implement Bloc interface. Provider can only store Bloc objects.
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // 2. Allows widgets to retrieve the BlocProvider from a descendant in widget tree with current build context.
  static T of<T extends Bloc>(BuildContext context) {
    final type = _providerType<BlocProvider<T>>();
    final BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  // 3. Get reference to the generic type
  static Type _providerType<T>() => T;

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 4. Use widget build method to pass-through to widget's child. No rendering.
  @override
  Widget build(BuildContext context) => widget.child;

  // 5. Reason provider inherits from StatefulWidget: To access the dispose method and close the stream.
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
