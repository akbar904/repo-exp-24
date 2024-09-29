
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.flutter_cubit_app/screens/login_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginScreen(),
					),
				),
			);

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginScreen(),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late AuthCubit authCubit;
		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'should emit [LoginLoading, LoginSuccess] when login is successful',
			build: () => authCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future.delayed(Duration(milliseconds: 100));
					cubit.emit(LoginSuccess());
				});
				cubit.login('test@example.com', 'password');
			},
			expect: () => [LoginLoading(), LoginSuccess()],
		);

		blocTest<AuthCubit, AuthState>(
			'should emit [LoginLoading, LoginFailure] when login fails',
			build: () => authCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future.delayed(Duration(milliseconds: 100));
					cubit.emit(LoginFailure('Invalid credentials'));
				});
				cubit.login('test@example.com', 'wrong_password');
			},
			expect: () => [LoginLoading(), LoginFailure('Invalid credentials')],
		);
	});
}
