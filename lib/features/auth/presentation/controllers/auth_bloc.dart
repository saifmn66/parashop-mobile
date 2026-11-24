import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecases.dart';

// Events
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

final class AuthSignInSubmitted extends AuthEvent {
  const AuthSignInSubmitted({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  final String email;
  final String password;
  final bool rememberMe;

  @override
  List<Object?> get props => [email, password, rememberMe];
}

final class AuthSignUpSubmitted extends AuthEvent {
  const AuthSignUpSubmitted({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;

  @override
  List<Object?> get props => [fullName, email, phone, password];
}

final class AuthSocialSignInSubmitted extends AuthEvent {
  const AuthSocialSignInSubmitted(this.provider);

  final String provider;

  @override
  List<Object?> get props => [provider];
}

final class AuthForgotPasswordSubmitted extends AuthEvent {
  const AuthForgotPasswordSubmitted(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class AuthProfileUpdated extends AuthEvent {
  const AuthProfileUpdated({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  final String fullName;
  final String email;
  final String phone;

  @override
  List<Object?> get props => [fullName, email, phone];
}

final class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

// State
enum AuthStatus { initial, loading, authenticated, unauthenticated, passwordResetSent, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.message,
  });

  final AuthStatus status;
  final UserEntity? user;
  final String? message;

  bool get isAuthenticated => user != null;
  bool get isLoading => status == AuthStatus.loading;

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    bool clearUser = false,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.getCurrentUser,
    required this.signIn,
    required this.signUp,
    required this.socialSignIn,
    required this.forgotPassword,
    required this.updateProfile,
    required this.signOut,
  }) : super(const AuthState()) {
    on<AuthCheckRequested>(_onCheck);
    on<AuthSignInSubmitted>(_onSignIn);
    on<AuthSignUpSubmitted>(_onSignUp);
    on<AuthSocialSignInSubmitted>(_onSocialSignIn);
    on<AuthForgotPasswordSubmitted>(_onForgotPassword);
    on<AuthProfileUpdated>(_onUpdateProfile);
    on<AuthSignOutRequested>(_onSignOut);
  }

  final GetCurrentUserUseCase getCurrentUser;
  final SignInUseCase signIn;
  final SignUpUseCase signUp;
  final SocialSignInUseCase socialSignIn;
  final ForgotPasswordUseCase forgotPassword;
  final UpdateProfileUseCase updateProfile;
  final SignOutUseCase signOut;

  void _onCheck(AuthCheckRequested event, Emitter<AuthState> emit) {
    final user = getCurrentUser();
    if (user != null) {
      emit(AuthState(status: AuthStatus.authenticated, user: user));
    } else {
      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> _onSignIn(
    AuthSignInSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      final user = await signIn(
        email: event.email,
        password: event.password,
        rememberMe: event.rememberMe,
      );
      emit(AuthState(
        status: AuthStatus.authenticated,
        user: user,
        message: 'Welcome back, ${user.firstName}',
      ));
    } on ServerException catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Unable to sign in right now. Please try again.',
      ));
    }
  }

  Future<void> _onSignUp(
    AuthSignUpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      final user = await signUp(
        fullName: event.fullName,
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      emit(AuthState(
        status: AuthStatus.authenticated,
        user: user,
        message: 'Account created! Welcome to ParaShop, ${user.firstName}.',
      ));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Unable to create your account right now.',
      ));
    }
  }

  Future<void> _onSocialSignIn(
    AuthSocialSignInSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      final user = await socialSignIn(event.provider);
      emit(AuthState(
        status: AuthStatus.authenticated,
        user: user,
        message: 'Signed in with ${event.provider}',
      ));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Social sign-in failed. Please try again.',
      ));
    }
  }

  Future<void> _onForgotPassword(
    AuthForgotPasswordSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      await forgotPassword(event.email);
      emit(state.copyWith(
        status: AuthStatus.passwordResetSent,
        message: 'Password reset instructions sent to ${event.email}.',
      ));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Could not send reset email. Please try again.',
      ));
    }
  }

  Future<void> _onUpdateProfile(
    AuthProfileUpdated event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, message: null));
    try {
      final updated = await updateProfile(
        fullName: event.fullName,
        email: event.email,
        phone: event.phone,
      );
      emit(AuthState(
        status: AuthStatus.authenticated,
        user: updated,
        message: 'Profile updated successfully.',
      ));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Could not update profile.',
      ));
    }
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await signOut();
    emit(const AuthState(
      status: AuthStatus.unauthenticated,
      message: 'Signed out safely.',
    ));
  }
}
