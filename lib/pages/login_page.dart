import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/blocs/authentication/authentication_bloc.dart';
import 'package:login/models/user.dart';
import 'package:login/pages/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Widget Function(User user) onLoginSuccess;
  final String assetLogoPath;

  const LoginPage(
      {Key key, @required this.onLoginSuccess, @required this.assetLogoPath})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.onLoginSuccess == null)
      assert(widget.onLoginSuccess == null, 'firstPage can\'t be null.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: Image.asset("assets/flutter_logo.png")),
            TextField(
              controller: _emailController,
              onChanged: (String inputValue) {
                _emailController.value.copyWith(text: inputValue);
              },
            ),
            TextField(
              controller: _passwordController,
              onChanged: (String inputValue) {
                _passwordController.value.copyWith(text: inputValue);
              },
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                final user = await AuthenticationBloc.login(
                    _emailController.text, _passwordController.text);

                if (user == null)
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Erro')));

                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => widget.onLoginSuccess(user)));
              },
              child: Text("LOGIN"),
            ),
            OutlinedButton(
              onPressed: () async => await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ForgotPasswordPage())),
              child: Text("Esqueceu sua senha?"),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
