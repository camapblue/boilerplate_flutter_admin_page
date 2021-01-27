import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:boilerplate_flutter_admin_page/theme/theme.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoaderBloc, LoaderState>(
      builder: (context, state) {
        return Visibility(
          visible: state is LoaderRunSuccess,
          child: Container(
            color: AppColors.dark.withOpacity(0.78),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: whiteColor,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${state.loadingMessage ?? "Loading"}...',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                              color: whiteColor,
                            ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
