
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/widgets/login_form.dart';

// Mock Cubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('renders email and password fields and login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		testWidgets('calls login on AuthCubit when form is submitted', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			final emailField = find.byType(TextFormField).first;
			final passwordField = find.byType(TextFormField).last;
			final loginButton = find.byType(ElevatedButton);

			await tester.enterText(emailField, 'test@example.com');
			await tester.enterText(passwordField, 'password');
			await tester.tap(loginButton);

			verify(() => mockAuthCubit.login('test@example.com', 'password')).called(1);
		});
	});
}
