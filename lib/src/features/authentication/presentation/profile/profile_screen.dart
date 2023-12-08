
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/profile/profile_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../../../../common_widgets/my_app_bar.dart';
import '../../../../common_widgets/my_avatar.dart';
import '../../../../common_widgets/my_scaffold.dart';
import '../../../../common_widgets/my_text.dart';
import '../../data/auth_repository.dart';
import 'my_profile_item.dart';

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
          (_, state) => state.showDialogError(context),
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
              Divider(color: GreyScaleColors.grey200,thickness: Sizes.s1.h),
              gapH24,
              MyProfileItem(
                iconPrefix: IconlyLight.profile,
                label: context.loc.editProfile.capitalize(),
                onTap: (){},
              ),
              gapH20,
              MyProfileItem(
                iconPrefix: IconlyLight.shield_done,
                label: context.loc.security.capitalize(),
                onTap: (){},
              ),
              gapH20,
              MyProfileItem(
                iconPrefix: IconlyLight.discovery,
                label: context.loc.language.capitalize(),
                onTap: (){},
              ),
              gapH20,
              MyProfileItem(
                iconPrefix: IconlyLight.user_1,
                label: context.loc.inviteFriends.capitalize(),
                onTap: (){},
              ),
              gapH20,
              MyProfileItem(
                color: OtherColors.red,
                iconPrefix: IconlyLight.logout,
                label: context.loc.logout.capitalize(),
                onTap: () async{
                  await ref.read(profileScreenControllerProvider.notifier).signOut();
                },
              ),
            ],
          )
      ),
    );
  }
}