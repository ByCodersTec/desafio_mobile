import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/signin_bloc.dart';
import '../bloc/signin_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SigninBloc>();
    return Scaffold(
      body: BlocBuilder<SigninBloc, SigninState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is SigninStateAuthFinished) {
              print(state.user.email);
            }
            return ListView(children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<FirebaseCrashlytics>().crash();
                  },
                  child: const Text('Forcing a crash'))
            ]);
          }),
    );
  }
}
