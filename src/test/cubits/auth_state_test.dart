
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthState', () {
		blocTest<AuthCubit, AuthState>(
			'initial state is AuthInitial',
			build: () => AuthCubit(),
			verify: (cubit) => expect(cubit.state, equals(AuthInitial())),
		);

		blocTest<AuthCubit, AuthState>(
			'emit LoginSuccess when login is successful',
			build: () => AuthCubit(),
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [isA<LoginSuccess>()],
		);

		blocTest<AuthCubit, AuthState>(
			'emit LogoutSuccess when logout is called',
			build: () => AuthCubit(),
			act: (cubit) => cubit.logout(),
			expect: () => [isA<LogoutSuccess>()],
		);

		group('AuthState serialization', () {
			test('AuthInitial can be serialized and deserialized', () {
				final initialState = AuthInitial();
				final json = initialState.toJson();
				final newState = AuthState.fromJson(json);
				expect(newState, equals(initialState));
			});

			test('LoginSuccess can be serialized and deserialized', () {
				final loginSuccess = LoginSuccess();
				final json = loginSuccess.toJson();
				final newState = AuthState.fromJson(json);
				expect(newState, equals(loginSuccess));
			});

			test('LogoutSuccess can be serialized and deserialized', () {
				final logoutSuccess = LogoutSuccess();
				final json = logoutSuccess.toJson();
				final newState = AuthState.fromJson(json);
				expect(newState, equals(logoutSuccess));
			});
		});
	});
}
