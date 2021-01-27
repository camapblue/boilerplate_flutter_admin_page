import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_admin_page/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter_admin_page/blocs/blocs.dart';
import 'package:boilerplate_flutter_admin_page/constants/constants.dart';
import 'package:boilerplate_flutter_admin_page/widgets/button/button.dart';
import 'package:boilerplate_flutter_admin_page/widgets/widgets.dart';

class LogInPage extends StatefulWidget {
  const LogInPage();

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var _email = '';
  var _password = '';
  FocusNode _passwordFocusNode;

  void _login() {
    EventBus().event<AuthenticationBloc>(
      Keys.Blocs.authenticationBloc,
      AuthenticationSignedIn(
        email: _email,
        password: _password,
      ),
    );
  }

  bool get _isValid =>
      _email?.isNotEmpty == true && _password?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                condition: (_, state) => state is AuthSignInSuccess,
                listener: (_, state) {
                  if (state is AuthSignInSuccess) {
                    Navigator.of(context).pushReplacementNamed(Pages.dashboard);
                  }
                },
                child: const SizedBox(),
              ),
              AppImage(
                image: AppImagesAsset.logo,
                width: 230,
                height: 136,
              ),
              ValidatorInput(
                title: 'Email',
                initialValue: _email,
                autofilHints: const [AutofillHints.email],
                onValid: (value) => setState(() => _email = value),
                onFieldSubmitted: (value) {
                  _email = value;

                  _passwordFocusNode.requestFocus();
                },
                autofocus: true,
              ),
              ValidatorInput(
                title: 'Password',
                initialValue: _password,
                autofilHints: const [AutofillHints.password],
                onFocusNode: (focusNode) => _passwordFocusNode = focusNode,
                onValid: (value) => setState(() => _password = value),
                obscureText: true,
                onFieldSubmitted: (value) {
                  _password = value;

                  _login();
                },
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                return Button.pink(
                  title: 'Login',
                  onPressed: _isValid ? _login : null,
                  loading: state is AuthSignInInProgress,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
