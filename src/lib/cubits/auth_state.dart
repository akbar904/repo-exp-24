
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Abstract base class for all authentication states
abstract class AuthState extends Equatable {
	const AuthState();
	
	Map<String, dynamic> toJson();
	
	static AuthState fromJson(Map<String, dynamic> json) {
		switch (json['type']) {
			case 'AuthInitial':
				return AuthInitial();
			case 'LoginSuccess':
				return LoginSuccess();
			case 'LogoutSuccess':
				return LogoutSuccess();
			default:
				throw Exception('Unknown AuthState type');
		}
	}
}

// Initial state of the authentication
class AuthInitial extends AuthState {
	const AuthInitial();
	
	@override
	List<Object> get props => [];
	
	@override
	Map<String, dynamic> toJson() => {'type': 'AuthInitial'};
}

// State when login is successful
class LoginSuccess extends AuthState {
	const LoginSuccess();
	
	@override
	List<Object> get props => [];
	
	@override
	Map<String, dynamic> toJson() => {'type': 'LoginSuccess'};
}

// State when logout is successful
class LogoutSuccess extends AuthState {
	const LogoutSuccess();
	
	@override
	List<Object> get props => [];
	
	@override
	Map<String, dynamic> toJson() => {'type': 'LogoutSuccess'};
}

// Cubit for handling authentication logic
class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(const AuthInitial());
	
	void login(String email, String password) {
		// In a real app, you would have some authentication logic here
		emit(const LoginSuccess());
	}
	
	void logout() {
		// In a real app, you would have some logout logic here
		emit(const LogoutSuccess());
	}
}
