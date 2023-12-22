
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_avatar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_bottom_modal.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_divider.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/profile/profile_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'profile_card.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      profileScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(profileScreenControllerProvider);
    return MyScaffold(
      state: state,
      appBar: MyAppBar(
        title: context.loc.profile.capitalize(),
        leading: SvgPicture.asset(
          'images/main/logo_medica.svg',
        ),
        leadingWidth: Sizes.s28,
        titleSpacing: Sizes.s16,
        actions: [
          /*value.when(
            data: (items) => GestureDetector(
              child: Icon(IconlyLight.more_circle,size: Sizes.s24.w),
              onTap: () {
                context.showBottomModal(
                  context: context,
                  content: MyBottomModal(
                    title: 'Alterar cargo',
                    content: ChangeRoleListScreen(items: items),
                    negativeButtonTitle: 'Voltar',
                    negativeButtonOnPressed: () {
                      context.pop();
                      ref.read(profileScreenControllerProvider.notifier).resetUserRoleCompany(ref);
                    },
                    positiveButtonTitle: 'Alterar',
                    positiveButtonOnPressed: () async {
                      final newRole = ref.read(tempUserRoleCompanyProvider);
                      if(newRole != null){
                        context.pop();
                        await ref.read(profileScreenControllerProvider.notifier).setUserRoleCompany(ref,newRole);
                      }
                    },
                  ),
                  action: () {
                    ref.read(profileScreenControllerProvider.notifier).resetUserRoleCompany(ref);
                  }
                );
              },
            ),
            error: (e, st) => const SizedBox(),
            loading: () => const SizedBox()
          )*/
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gapH24,
              MyAvatar(
                file: /*state.hasValue ? state.value : */null,
                pictureSize: Sizes.s140,
                editSize: Sizes.s30,
                iconSize: Sizes.s17,
                onTap: () async {
                  //await ref.read(personalDataScreenControllerProvider.notifier).chooseProfilePicture();
                },
              ),
              gapH12,
              MyText(
                type: TextTypes.h4,
                text: 'Andrew Ainsley',
              ),
              gapH8,
              MyText(
                type: TextTypes.bodyMedium,
                fontWeight: FontWeights.semiBold,
                text: '+1 111 467 378 399',
              ),
              gapH24,
              MyDivider(),
              gapH24,
              ProfileCard(
                iconPrefix: IconlyLight.profile,
                label: context.loc.editProfile.capitalize(),
                onTap: (){},
              ),
              gapH20,
              ProfileCard(
                iconPrefix: IconlyLight.shield_done,
                label: context.loc.security.capitalize(),
                onTap: (){},
              ),
              gapH20,
              ProfileCard(
                iconPrefix: IconlyLight.discovery,
                label: context.loc.language.capitalize(),
                onTap: (){
                  context.pushNamed(AppRoute.changeLanguage.name);
                },
              ),
              gapH20,
              ProfileCard(
                iconPrefix: IconlyLight.swap,
                label: 'Alterar cargo',
                onTap: (){
                 context.pushNamed(AppRoute.changeRole.name);
                },
              ),
              gapH20,
              /*ProfileCard(
                iconPrefix: IconlyLight.user_1,
                label: context.loc.inviteFriends.capitalize(),
                onTap: (){},
              ),
              gapH20,*/
              ProfileCard(
                color: OtherColors.red,
                iconPrefix: IconlyLight.logout,
                label: context.loc.logout.capitalize(),
                onTap: () async {
                  context.showBottomModal(
                    context: context,
                    content: MyBottomModal(
                      title: 'Sair',
                      titleColor: OtherColors.red,
                      content: Column(
                        children: [
                          MyText(
                            type: TextTypes.h5,
                            text: context.loc.areYouSureYouWantToLogout.capitalize(),
                            color: GreyScaleColors.grey900,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      negativeButtonTitle: 'Voltar',
                      negativeButtonOnPressed: () {
                        context.pop();
                      },
                      positiveButtonTitle: 'Sair',
                      positiveButtonOnPressed: () async {
                        await ref.read(profileScreenControllerProvider.notifier).signOut(ref);
                      },
                    )
                  );
                },
              ),
            ],
          )
      ),
    );
  }
}