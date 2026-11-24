import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/address_entity.dart';
import '../controllers/profile_cubit.dart';

class ManageAddressesPage extends StatelessWidget {
  const ManageAddressesPage({super.key});

  Future<void> _showAddAddressSheet(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final labelCtrl = TextEditingController(text: 'Home');
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final streetCtrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final postalCtrl = TextEditingController();

    final created = await showModalBottomSheet<AddressEntity>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.screenPadding,
          AppSizes.sm,
          AppSizes.screenPadding,
          MediaQuery.viewInsetsOf(ctx).bottom + AppSizes.lg,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Delivery Address',
                  style: Theme.of(ctx).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSizes.md),
                CustomTextField(
                  controller: labelCtrl,
                  label: 'Label (e.g. Home, Office)',
                  validator: (v) =>
                      AppValidators.requiredField(v, label: 'Label'),
                ),
                const SizedBox(height: AppSizes.sm),
                CustomTextField(
                  controller: nameCtrl,
                  label: 'Recipient Name',
                  validator: AppValidators.fullName,
                ),
                const SizedBox(height: AppSizes.sm),
                CustomTextField(
                  controller: phoneCtrl,
                  label: 'Phone',
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.phone,
                ),
                const SizedBox(height: AppSizes.sm),
                CustomTextField(
                  controller: streetCtrl,
                  label: 'Street Address',
                  validator: (v) =>
                      AppValidators.requiredField(v, label: 'Street'),
                ),
                const SizedBox(height: AppSizes.sm),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: postalCtrl,
                        label: 'Postal Code',
                        validator: (v) => AppValidators.requiredField(
                          v,
                          label: 'Postal code',
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        controller: cityCtrl,
                        label: 'City',
                        validator: (v) =>
                            AppValidators.requiredField(v, label: 'City'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.lg),
                PrimaryButton(
                  label: 'Save Address',
                  onPressed: () {
                    if (!(formKey.currentState?.validate() ?? false)) return;
                    Navigator.of(ctx).pop(
                      AddressEntity(
                        id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
                        label: labelCtrl.text.trim(),
                        recipientName: nameCtrl.text.trim(),
                        phone: phoneCtrl.text.trim(),
                        street: streetCtrl.text.trim(),
                        city: cityCtrl.text.trim(),
                        postalCode: postalCtrl.text.trim(),
                        isDefault: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (created != null && context.mounted) {
      await context.read<ProfileCubit>().addAddress(created);
      if (context.mounted) {
        context.showAppSnackBar('Address saved');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Delivery Addresses'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAddressSheet(context),
        icon: const Icon(Icons.add_location_alt_outlined),
        label: const Text('Add Address'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.addresses.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.location_off_outlined,
              title: 'No addresses saved',
              description:
                  'Add a home or office address for faster parapharmacy checkout.',
              actionLabel: 'Add Address',
              onActionTap: () => _showAddAddressSheet(context),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.screenPadding,
              AppSizes.md,
              AppSizes.screenPadding,
              100,
            ),
            itemCount: state.addresses.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSizes.sm),
            itemBuilder: (context, index) {
              final address = state.addresses[index];
              return Container(
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: AppSizes.rMd,
                  border: Border.all(
                    color: address.isDefault ? scheme.primary : scheme.outline,
                    width: address.isDefault ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(address.label, style: theme.textTheme.titleMedium),
                        if (address.isDefault) ...[
                          const SizedBox(width: AppSizes.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.secondaryContainer,
                              borderRadius: AppSizes.rPill,
                            ),
                            child: Text(
                              'Default',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: scheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        if (!address.isDefault)
                          TextButton(
                            onPressed: () => context
                                .read<ProfileCubit>()
                                .setDefaultAddress(address.id),
                            child: const Text('Set default'),
                          ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            size: 19,
                          ),
                          onPressed: () => context
                              .read<ProfileCubit>()
                              .removeAddress(address.id),
                        ),
                      ],
                    ),
                    Text(
                      address.recipientName,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      address.formattedLine,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(address.phone, style: theme.textTheme.bodySmall),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
