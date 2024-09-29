
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('renders HomeScreen with LogoutButton', (tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: authCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.byType(HomeScreen), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('LogoutButton triggers logout action', (tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: authCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => authCubit.logout()).called(1);
		});
	});
}
