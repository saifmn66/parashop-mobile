import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/auth_bloc.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/social_auth_buttons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _acceptedTerms = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_acceptedTerms) {
      context.showAppSnackBar(
        'Please accept the Terms & Privacy Policy to continue.',
        isError: true,
      );
      return;
    }
    context.read<AuthBloc>().add(
          AuthSignUpSubmitted(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          if (state.message != null) {
            context.showAppSnackBar(state.message!);
          }
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.main,
            (route) => false,
          );
        } else if (state.status == AuthStatus.failure &&
            state.message != null) {
          context.showAppSnackBar(state.message!, isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(title: ''),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.screenPadding,
                  AppSizes.xs,
                  AppSizes.screenPadding,
                  AppSizes.xl,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthHeaderWidget(
                        title: 'Create account',
                        subtitle:
                            'Join ParaShop for pharmacist advice, loyalty rewards, and fast delivery.',
                        icon: Icons.person_add_alt_1_outlined,
                      ),
                      const SizedBox(height: AppSizes.xl),
                      CustomTextField(
                        controller: _nameController,
                        label: 'Full name',
                        hint: 'Lina Benali',
                        prefixIcon: Icons.person_outline_rounded,
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.fullName,
                      ),
                      const SizedBox(height: AppSizes.md),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email address',
                        hint: 'name@example.com',
                        prefixIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.email,
                      ),
                      const SizedBox(height: AppSizes.md),
                      CustomTextField(
                        controller: _phoneController,
                        label: 'Phone number',
                        hint: '+33 6 42 18 90 12',
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.phone,
                      ),
                      const SizedBox(height: AppSizes.md),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'At least 8 characters',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.password,
                      ),
                      const SizedBox(height: AppSizes.md),
                      CustomTextField(
                        controller: _confirmController,
                        label: 'Confirm password',
                        hint: 'Re-enter your password',
                        prefixIcon: Icons.lock_reset_rounded,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        validator: (v) => AppValidators.confirmPassword(
                          v,
                          _passwordController.text,
                        ),
                        onFieldSubmitted: (_) => _submit(),
                      ),
                      const SizedBox(height: AppSizes.md),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _acceptedTerms,
                              onChanged: (v) =>
                                  setState(() => _acceptedTerms = v ?? false),
                            ),
                          ),
                          const SizedBox(width: AppSizes.xs),
                          Expanded(
                            child: Text(
                              'I agree to the Terms of Service and Privacy Policy.',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.lg),
                      PrimaryButton(
                        label: 'Create Account',
                        isLoading: state.isLoading,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: AppSizes.xl),
                      SocialAuthButtons(
                        isLoading: state.isLoading,
                        onGoogleTap: () => context
                            .read<AuthBloc>()
                            .add(const AuthSocialSignInSubmitted('Google')),
                        onAppleTap: () => context
                            .read<AuthBloc>()
                            .add(const AuthSocialSignInSubmitted('Apple')),
                      ),
                      const SizedBox(height: AppSizes.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
