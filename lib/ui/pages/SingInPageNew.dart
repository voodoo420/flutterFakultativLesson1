import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/auth/bloc.dart';
import 'package:flutterapp/ui/pages/UserPage.dart';

class SingInPageNew extends StatelessWidget {
  final TextEditingController controllerPhoneNumber = TextEditingController();
  final TextEditingController controllerCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is NumberCheckAuthState) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(40),
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  controller: controllerPhoneNumber,
                  decoration: InputDecoration(
                      labelText: "Номер телефона", hintText: ""),
                ),
                FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                        AuthNumberEntered(number: controllerPhoneNumber.text));
                  },
                  child: Text(
                    "Получить смс с кодом",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ),
        );
      }
      if (state is SmsCheckAuthState) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(40),
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  controller: controllerCode,
                  decoration: InputDecoration(
                      labelText: "Код из СМС", hintText: "код из смс"),
                ),
                FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                        AuthSmsCodeEntered(code: controllerCode.text));
                  },
                  child: Text(
                    "Проверить код",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ),
        );
      }
      if (state is SuccessAuthState) {
        return UserPage();
      }
      return Container();
    }));
  }
}
