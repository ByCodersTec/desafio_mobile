import 'package:desafio_mobile/app/common/widgets/custom_button.dart';
import 'package:desafio_mobile/app/common/widgets/custom_progress_indicator.dart';
import 'package:desafio_mobile/app/login/ui/controller/login_controller.dart';
import 'package:desafio_mobile/config/ui/theme/fonts.dart';
import 'package:desafio_mobile/core/common/injected/module.dart';
import 'package:flutter/material.dart';
import 'package:desafio_mobile/app/login/ui/widgets/custom_input_text.dart';
import 'package:desafio_mobile/core/common/utils/screen_utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = getIt<LoginController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) => _buildBody(context),
        ),
      ),
    );
  }

  _fontDescriptionStyle({required Color color}) => TextStyle(
        fontSize: AppFonts.textBiggerSize,
        color: color,
        fontWeight: FontWeight.w900,
        fontFamily: AppFonts.family,
      );

  Widget _buildBody(BuildContext context) {
    if (controller.isLoading) {
      return _buildProgressIndicator();
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 250.h,
          ),
          child: Column(
            children: [
              Text(
                "Seja bem vindo!",
                textAlign: TextAlign.left,
                style: _fontDescriptionStyle(
                  color: Color.fromRGBO(38, 38, 38, 0.86),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomFieldText(
                label: 'Email',
                controller: _emailController,
                isEmail: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomFieldText(
                label: 'Senha',
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomButton(
                height: 50.h,
                title: 'Entrar',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    _signInWithEmailAndPassword();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    if (await controller.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    )) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      controller.isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email ou senha inválidos',
            style: _fontDescriptionStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Widget _buildProgressIndicator() => buildProgressIndicator(
        containerHeight: MediaQuery.of(
              context,
            ).size.height /
            2,
      );
}
