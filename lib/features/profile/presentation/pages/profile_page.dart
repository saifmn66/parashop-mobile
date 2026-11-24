import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/controllers/auth_bloc.dart';
import '../../../favorites/presentation/controllers/favorites_cubit.dart';
import '../controllers/profile_cubit.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_menu_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  String _themeLabel(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'Light',
        ThemeMode.dark => 'Dark',
        ThemeMode.system => 'System default',
      };

  String _languageLabel(String code) => switch (code) {
        'fr' => 'Français',
        'ar' => 'العربية',
        _ => 'English',
      };

  Future<void> _showThemeSheet(BuildContext context, ThemeMode current) async {
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Appearance', style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: AppSizes.sm),
              for (final mode in ThemeMode.values)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    mode == ThemeMode.light
                        ? Icons.light_mode_outlined
                        : mode == ThemeMode.dark
                            ? Icons.dark_mode_outlined
                            : Icons.brightness_auto_outlined,
                  ),
                  title: Text(_themeLabel(mode)),
                  trailing: mode == current
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: Theme.of(ctx).colorScheme.primary,
                        )
                      : null,
                  onTap: () => Navigator.of(ctx).pop(mode),
                ),
            ],
          ),
        ),
      ),
    );
    if (selected != null && context.mounted) {
      await context.read<ThemeCubit>().setThemeMode(selected);
    }
  }

  Future<void> _showLanguageSheet(BuildContext context, String current) async {
    const languages = [
      ('en', 'English'),
      ('fr', 'Français'),
      ('ar', 'العربية'),
    ];
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Language', style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: AppSizes.sm),
              for (final (code, label) in languages)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(label),
                  trailing: code == current
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: Theme.of(ctx).colorScheme.primary,
                        )
                      : null,
                  onTap: () => Navigator.of(ctx).pop(code),
                ),
            ],
          ),
        ),
      ),
    );
    if (selected != null && context.mounted) {
      await context.read<ProfileCubit>().setLanguage(selected);
    }
  }

  Future<void> _showNotificationsSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final prefs = state.notificationPrefs;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.screenPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification Preferences',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Order updates'),
                    subtitle: const Text('Confirmations & pharmacy packing'),
                    value: prefs['orders'] ?? true,
                    onChanged: (v) => context
                        .read<ProfileCubit>()
                        .toggleNotificationPref('orders', v),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Delivery tracking'),
                    subtitle: const Text('Live courier arrival notifications'),
                    value: prefs['deliveries'] ?? true,
                    onChanged: (v) => context
                        .read<ProfileCubit>()
                        .toggleNotificationPref('deliveries', v),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Promotions & clinical launches'),
                    subtitle: const Text('Exclusive member offers & restocks'),
                    value: prefs['promotions'] ?? true,
                    onChanged: (v) => context
                        .read<ProfileCubit>()
                        .toggleNotificationPref('promotions', v),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final profileState = context.watch<ProfileCubit>().state;
    final themeMode = context.watch<ThemeCubit>().state;
    final favCount = context.watch<FavoritesCubit>().state.favoriteIds.length;
    final user = authState.user;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile', showBack: false),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.screenPadding),
        children: [
          AnimatedFadeSlide(
            child: ProfileHeaderCard(
              user: user,
              onEditTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.editProfile),
              onSignInTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.signIn),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          AnimatedFadeSlide(
            delay: const Duration(milliseconds: 60),
            child: ProfileMenuSection(
              title: 'Account',
              items: [
                ProfileMenuItemData(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  subtitle: user?.phone.isNotEmpty == true
                      ? user!.phone
                      : 'Update name, email & phone',
                  onTap: () => Navigator.of(context).pushNamed(
                    user != null ? AppRoutes.editProfile : AppRoutes.signIn,
                  ),
                ),
                ProfileMenuItemData(
                  icon: Icons.location_on_outlined,
                  title: 'Delivery Addresses',
                  subtitle: profileState.defaultAddress?.formattedLine ??
                      'Add a delivery address',
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.addresses),
                ),
                ProfileMenuItemData(
                  icon: Icons.receipt_long_outlined,
                  title: 'Order History',
                  subtitle: 'Track deliveries & reorder',
                  onTap: () => context.showAppSnackBar(
                    'Orders & tracking coming in next phase.',
                  ),
                ),
                ProfileMenuItemData(
                  icon: Icons.favorite_outline_rounded,
                  title: 'Favorites',
                  subtitle: '$favCount saved products',
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.favorites),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          AnimatedFadeSlide(
            delay: const Duration(milliseconds: 110),
            child: ProfileMenuSection(
              title: 'Preferences',
              items: [
                ProfileMenuItemData(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  subtitle: _themeLabel(themeMode),
                  onTap: () => _showThemeSheet(context, themeMode),
                ),
                ProfileMenuItemData(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: _languageLabel(profileState.languageCode),
                  onTap: () =>
                      _showLanguageSheet(context, profileState.languageCode),
                ),
                ProfileMenuItemData(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notification Settings',
                  subtitle: 'Orders, deliveries & offers',
                  onTap: () => _showNotificationsSheet(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          ProfileMenuSection(
            title: 'Application',
            items: [
              ProfileMenuItemData(
                icon: Icons.info_outline_rounded,
                title: 'About ParaShop',
                subtitle: 'Version 1.0.0 • Licensed Parapharmacy',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.about),
              ),
              if (user != null)
                ProfileMenuItemData(
                  icon: Icons.logout_rounded,
                  title: 'Sign Out',
                  isDestructive: true,
                  onTap: () async {
                    final confirm = await ConfirmationDialog.show(
                      context,
                      title: 'Sign out?',
                      message:
                          'You can sign back in anytime to access your orders and favorites.',
                      confirmLabel: 'Sign Out',
                      isDestructive: true,
                    );
                    if (confirm && context.mounted) {
                      context.read<AuthBloc>().add(const AuthSignOutRequested());
                      context.showAppSnackBar('Signed out successfully');
                    }
                  },
                )
              else
                ProfileMenuItemData(
                  icon: Icons.login_rounded,
                  title: 'Sign In / Create Account',
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.signIn),
                ),
            ],
          ),
          const SizedBox(height: AppSizes.xl),
        ],
      ),
    );
  }
}
