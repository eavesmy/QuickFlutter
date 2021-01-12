import 'package:flutter/material.dart';

import 'multi_state_widget.dart';

class LoadingDialog<T> extends StatelessWidget {
  final text;
  LoadingDialog({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        width: 80,
        height: 80,
        decoration: ShapeDecoration(
          color: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        child: new DefaultLoadingWidget(
          textColor: Colors.white,
        ),
      ),
    );
  }
}

showLoadingDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  assert(debugCheckHasMaterialLocalizations(context));
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = builder == null
          ? LoadingDialog(
              text: "Loading...",
            )
          : builder(context);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black38, //全透会报错
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: child,
      );
    },
    useRootNavigator: true,
  );
}
