import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_admin_page/theme/theme.dart';

import 'toast_route.dart';
import 'toast_type.dart';

export 'toast_type.dart';

extension ToastTheme on ThemeData {
  TextStyle get toastMessageTextStyle =>
      primaryRegular.copyWith(color: whiteColor, fontSize: 16);
}

typedef ToastStatusCallBack = void Function();

const String ToastRouteName = '/ToastRoute';

// ignore: must_be_immutable
class Toast<T extends Object> extends StatefulWidget {
  final String message;
  final ToastType type;
  final Function onFinished;

  Toast(this.message, {Key key, this.type = ToastType.success, this.onFinished})
      : super(key: key);

  int duration = 4;

  ToastRoute<T> _toastRoute;

  Future<T> show(BuildContext context) async {
    _toastRoute = showToast<T>(context: context, toast: this);

    return Navigator.of(context, rootNavigator: false).push(_toastRoute);
  }

  Future<T> showWithNavigator(NavigatorState navigator) async {
    _toastRoute = showToast<T>(context: navigator.context, toast: this);

    return navigator.push(_toastRoute);
  }

  Future<T> dismiss([T result]) async {
    if (_toastRoute == null) {
      return null;
    }

    return null;
  }

  @override
  State createState() {
    return _ToastState<T>();
  }
}

class _ToastState<K extends Object> extends State<Toast>
    with TickerProviderStateMixin {
  FocusScopeNode _focusScopeNode;
  FocusAttachment _focusAttachment;

  GlobalKey backgroundBoxKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _focusScopeNode = FocusScopeNode();
    _focusAttachment = _focusScopeNode.attach(context);
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _focusAttachment.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight =
        AppBar().preferredSize.height + MediaQuery.of(context).padding.top - 20;

    return Container(
      padding: EdgeInsets.only(top: appBarHeight + 36),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              alignment: Alignment.centerLeft,
              key: backgroundBoxKey,
              decoration: BoxDecoration(
                color: widget.type.toBackgroundColor(),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2.0,
                    offset: Offset(0.3, 0.3),
                  )
                ],
              ),
              child: Text(
                widget.message,
                textAlign: TextAlign.left,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).toastMessageTextStyle.copyWith(
                      color: widget.type.toTextColor(),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
