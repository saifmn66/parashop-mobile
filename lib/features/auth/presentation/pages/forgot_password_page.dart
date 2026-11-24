import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../controllers/auth_bloc.dart';
import '../widgets/auth_header_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context
        .read<AuthBloc>()
        .add(AuthForgotPasswordSubmitted(_emailController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.passwordResetSent) {
          setState(() => _sent = true);
          if (state.message != null) {
            context.showAppSnackBar(state.message!);
          }
        } else if (state.status == AuthStatus.failure &&
            state.message != null) {
          context.showAppSnackBar(state.message!, isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(title: ''),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.screenPadding,
                AppSizes.sm,
                AppSizes.screenPadding,
                AppSizes.xl,
              ),
              child: AnimatedSwitcher(
                duration: AppMotion.normal,
                child: _sent
                    ? Column(
                        key: const ValueKey('sent'),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.success.withValues(alpha: 0.14),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mark_email_read_outlined,
                              color: AppColors.success,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: AppSizes.lg),
                          Text(
                            'Check your inbox',
                            style: theme.textTheme.headlineLarge,
                          ),
                          const SizedBox(height: AppSizes.xs),
                          Text(
                            'We sent a password reset link to ${_emailController.text.trim()}. Follow the instructions to set a new password.',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: AppSizes.xl),
                          PrimaryButton(
                            label: 'Back to Sign In',
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(height: AppSizes.sm),
                          SecondaryButton(
                            label: 'Resend email',
                            onPressed: () => setState(() => _sent = false),
                          ),
                        ],
                      )
                    : Form(
                        key: _formKey,
                        child: Column(
                          key: const ValueKey('form'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AuthHeaderWidget(
                              title: 'Reset password',
                              subtitle:
                                  'Enter the email linked to your account and we will send you a secure reset link.',
                              icon: Icons.lock_reset_rounded,
                            ),
                            const SizedBox(height: AppSizes.xl),
                            CustomTextField(
                              controller: _emailController,
                              label: 'Email address',
                              hint: 'name@example.com',
                              prefixIcon: Icons.mail_outline_rounded,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              validator: AppValidators.email,
                              onFieldSubmitted: (_) => _submit(),
                            ),
                            const SizedBox(height: AppSizes.lg),
                            PrimaryButton(
                              label: 'Send Reset Link',
                              isLoading: state.isLoading,
                              onPressed: _submit,
                            ),
                            const SizedBox(height: AppSizes.md),
                            Center(
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'Remembered your password? Sign In',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: scheme.primary,
                                  ),
                                ),
                              ),
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
