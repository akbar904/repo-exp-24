
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/widgets/logout_button.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_cubit.dart';

// Mock AuthCubit class for testing
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('LogoutButton is displayed with correct text', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => authCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		testWidgets('LogoutButton triggers logout on tap', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => authCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			await tester.pumpAndSettle();

			verify(() => authCubit.logout()).called(1);
		});
	});
}
