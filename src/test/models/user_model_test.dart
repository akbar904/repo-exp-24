
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_package_name/models/user_model.dart';

void main() {
	group('UserModel', () {
		test('should correctly serialize from JSON', () {
			// Arrange
			final jsonMap = {
				'id': '123',
				'email': 'test@example.com'
			};

			// Act
			final user = UserModel.fromJson(jsonMap);

			// Assert
			expect(user.id, '123');
			expect(user.email, 'test@example.com');
		});

		test('should correctly deserialize to JSON', () {
			// Arrange
			final user = UserModel(id: '123', email: 'test@example.com');

			// Act
			final jsonMap = user.toJson();

			// Assert
			expect(jsonMap['id'], '123');
			expect(jsonMap['email'], 'test@example.com');
		});

		test('should create a UserModel with correct properties', () {
			// Act
			final user = UserModel(id: '123', email: 'test@example.com');

			// Assert
			expect(user.id, '123');
			expect(user.email, 'test@example.com');
		});
	});
}
