
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_state.dart';
import 'package:com.example.flutter_cubit_app/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		try {
			emit(AuthLoading());
			
			// Simulated delay for login
			await Future.delayed(Duration(seconds: 2));
			
			if (email == 'test@example.com' && password == 'password') {
				emit(AuthAuthenticated(user: UserModel(id: '1', email: email)));
			} else {
				emit(AuthError(message: 'Invalid credentials'));
			}
		} catch (e) {
			emit(AuthError(message: e.toString()));
		}
	}

	void logout() async {
		try {
			emit(AuthLoading());
			
			// Simulated delay for logout
			await Future.delayed(Duration(seconds: 2));
			
			emit(AuthUnauthenticated());
		} catch (e) {
			emit(AuthError(message: e.toString()));
		}
	}
}
