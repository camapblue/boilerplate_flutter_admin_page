import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_admin_page/blocs/base/base_bloc.dart';
import 'package:boilerplate_flutter_admin_page/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';

import 'loader.dart';

class LoaderBloc extends BaseBloc<LoaderEvent, LoaderState> {
  LoaderBloc(Key key) : super(key);

  factory LoaderBloc.instance() {
    return EventBus().newBloc<LoaderBloc>(Keys.Blocs.loaderBloc);
  }

  @override
  LoaderState get initialState => LoaderInitial();

  @override
  Stream<LoaderState> mapEventToState(LoaderEvent event) async* {
    if (event is LoaderRun && !(state is LoaderRunSuccess)) {
      yield LoaderRunSuccess(message: event.loadingMessage);
    } else if (event is LoaderStopped && !(state is LoaderStopSuccess)) {
      yield LoaderStopSuccess();
    }
  }
}
