import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

typedef ObserverFn<TOutput> = TOutput Function(BuildContext context);
typedef ObserverFn1<TInput, TOutput> = TOutput Function(
    BuildContext context, TInput in1);
typedef ObserverFn2<TInput1, TInput2, TOutput> = TOutput Function(
    BuildContext context, TInput1 in1, TInput2 in2);
typedef ObserverFn3<TInput1, TInput2, TInput3, TOutput> = TOutput Function(
    BuildContext context, TInput1 in1, TInput2 in2, TInput3 in3);

class ObserverProvider<TOutput> extends SingleChildStatelessWidget {
  final ObserverFn<TOutput> _observerFn;

  ObserverProvider({
    Key? key,
    required ObserverFn<TOutput> observerFn,
    Widget? child,
  })  : _observerFn = observerFn,
        super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Observer(builder: (ctx) {
      final out = _observerFn(ctx);
      return ProxyProvider0<TOutput>(
          lazy: false, update: (_, __) => out, child: child);
    });
  }
}

class ObserverProvider1<TInput, TOutput> extends ObserverProvider<TOutput> {
  ObserverProvider1({
    Key? key,
    required ObserverFn1<TInput, TOutput> observerFn,
    Widget? child,
  }) : super(
            key: key,
            child: child,
            observerFn: (ctx) {
              final in1 = Provider.of<TInput>(ctx);
              return observerFn(ctx, in1);
            });
}

class ObserverProvider2<TInput1, TInput2, TOutput>
    extends ObserverProvider<TOutput> {
  ObserverProvider2({
    Key? key,
    required ObserverFn2<TInput1, TInput2, TOutput> observerFn,
    Widget? child,
  }) : super(
            key: key,
            child: child,
            observerFn: (ctx) {
              final in1 = Provider.of<TInput1>(ctx);
              final in2 = Provider.of<TInput2>(ctx);
              return observerFn(ctx, in1, in2);
            });
}

class ObserverProvider3<TInput1, TInput2, TInput3, TOutput>
    extends ObserverProvider<TOutput> {
  ObserverProvider3({
    Key? key,
    required ObserverFn3<TInput1, TInput2, TInput3, TOutput> observerFn,
    Widget? child,
  }) : super(
            key: key,
            child: child,
            observerFn: (ctx) {
              final in1 = Provider.of<TInput1>(ctx);
              final in2 = Provider.of<TInput2>(ctx);
              final in3 = Provider.of<TInput3>(ctx);
              return observerFn(ctx, in1, in2, in3);
            });
}
