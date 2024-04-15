import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';

class AuthBackground extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final List<Widget> children;
  const AuthBackground({super.key, required this.children, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          AppPallete.gradient1,
          AppPallete.gradient2,
          AppPallete.gradient4,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Form(
            key: formKey,
            child: Column(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
