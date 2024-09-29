
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/auth_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MainApp());
}

class MainApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (_) => AuthCubit(),
			child: MaterialApp(
				title: 'Flutter Cubit App',
				theme: ThemeData(
					primarySwatch: Colors.blue,
				),
				home: AppNavigator(),
			),
		);
	}
}

class AppNavigator extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AuthCubit, AuthState>(
			builder: (context, state) {
				if (state is AuthLoginSuccess) {
					return HomeScreen();
				} else {
					return LoginScreen();
				}
			},
		);
	}
}
