
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_cubit.dart';
import 'package:com.example.flutter_cubit_app/screens/login_screen.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main app', () {
		testWidgets('renders LoginScreen initially', (tester) async {
			await tester.pumpWidget(MainApp());
			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('navigates to HomeScreen on successful login', (tester) async {
			final mockAuthCubit = MockAuthCubit();
			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthInitial(), AuthLoginSuccess()]),
				initialState: AuthInitial(),
			);

			await tester.pumpWidget(
				BlocProvider.value(
					value: mockAuthCubit,
					child: MainApp(),
				),
			);

			await tester.pumpAndSettle();
			expect(find.byType(HomeScreen), findsOneWidget);
		});

		testWidgets('navigates back to LoginScreen on logout', (tester) async {
			final mockAuthCubit = MockAuthCubit();
			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthInitial(), AuthLoginSuccess(), AuthLogoutSuccess()]),
				initialState: AuthInitial(),
			);

			await tester.pumpWidget(
				BlocProvider.value(
					value: mockAuthCubit,
					child: MainApp(),
				),
			);

			await tester.pumpAndSettle();
			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});
}
