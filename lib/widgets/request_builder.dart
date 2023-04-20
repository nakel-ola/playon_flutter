import 'package:flutter/material.dart';

class RequestBuilder<T> extends StatefulWidget {
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;
  final Future<T> Function()? future;
  final Object? initialData;
  const RequestBuilder({
    super.key,
    required this.builder,
    this.future,
    this.initialData,
  });

  @override
  State<RequestBuilder<T>> createState() => _RequestBuilderState<T>();
}

class _RequestBuilderState<T> extends State<RequestBuilder<T>> {
  Object? _activeCallbackIdentity;

  late AsyncSnapshot<T> _snapshot;

  @override
  void initState() {
    super.initState();

    _snapshot = widget.initialData == null
        ? AsyncSnapshot<T>.nothing()
        : AsyncSnapshot<T>.withData(
            ConnectionState.none, widget.initialData as T);
    _subscribe();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _snapshot);

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (widget.future == null) return;

    final Object callbackIdentity = Object();
    _activeCallbackIdentity = callbackIdentity;

    widget.future!().then((T data) {
      if (_activeCallbackIdentity == callbackIdentity) {
        setState(() {
          _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
        });
      }
    }, onError: (Object error, StackTrace stackTrace) {
      if (_activeCallbackIdentity == callbackIdentity) {
        setState(() {
          _snapshot = AsyncSnapshot<T>.withError(
              ConnectionState.done, error, stackTrace);
        });
      }
    });

    if (_snapshot.connectionState != ConnectionState.done) {
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}
