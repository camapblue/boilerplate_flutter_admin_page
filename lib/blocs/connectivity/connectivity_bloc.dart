import 'dart:async';
import 'dart:io';
import 'connectivity.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';


typedef CheckingInternet = Future<List<InternetAddress>> Function(String host,
    {InternetAddressType type});

class ConnectivityBloc extends BaseBloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  final CheckingInternet _internetCheckingFunction;
  final String _internetCheckingHost;
  StreamSubscription subscription;

  ConnectivityBloc(Key key,
      {Connectivity connectivity,
      CheckingInternet internetCheckingFunction,
      String internetCheckingHost})
      : _connectivity = connectivity ?? Connectivity(),
        _internetCheckingHost = internetCheckingHost ?? 'google.com',
        _internetCheckingFunction =
            internetCheckingFunction ?? InternetAddress.lookup,
        super(key) {
    subscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      final isConnected = await _checkConnection();

      if (isConnected != state.isConnected) {
        add(ConnectivityChanged(isConnected));
      }
    });
  }

  factory ConnectivityBloc.instance() {
    return EventBus().newBloc<ConnectivityBloc>(Keys.Blocs.connectivityBloc);
  }

  Future<bool> _checkConnection() async {
    var hasConnection = state.isConnected;
    try {
      final result = await _internetCheckingFunction(_internetCheckingHost);
      hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      hasConnection = false;
    }

    return hasConnection;
  }

  @override
  ConnectivityState get initialState => ConnectivityInitial();

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is ConnectivityChecked) {
      final isConnected = await _checkConnection();
      if (isConnected != state.isConnected) {
        yield ConnectivityUpdateSuccess(isConnected);
      }
    } else if (event is ConnectivityChanged) {
      yield ConnectivityUpdateSuccess(event.isConnected);
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();

    await super.close();
  }
}
