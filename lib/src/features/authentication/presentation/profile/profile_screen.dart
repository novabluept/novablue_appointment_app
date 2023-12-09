
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_bottom_modal.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/profile/profile_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../../../../common_widgets/my_app_bar.dart';
import '../../../../common_widgets/my_avatar.dart';
import '../../../../common_widgets/my_button.dart';
import '../../../../common_widgets/my_divider.dart';
import '../../../../common_widgets/my_scaffold.dart';
import '../../../../common_widgets/my_text.dart';
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
          GestureDetector(
            child: Icon(IconlyLight.more_circle,size: Sizes.s24.w),
            onTap: (){
              context.showBottomModal(
                context: context,
                content: MyBottomModal(
                  content: Container(),
                )
              );
            },
          )
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
                  context.showBottomModal(
                    context: context,
                    content: MyBottomModal(
                      content: Column(
                        children: [
                          MyText(
                            type: TextTypes.h4,
                            text: context.loc.logout.capitalize(),
                            color: OtherColors.red,
                          ),
                          gapH24,
                          MyDivider(),
                          gapH24,
                          MyText(
                            type: TextTypes.h5,
                            text: context.loc.areYouSureYouWantToLogout.capitalize(),
                            color: GreyScaleColors.grey900,
                            textAlign: TextAlign.center,
                          ),
                          gapH24,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MyButton(
                                  type: ButtonTypes.filledFullyRounded,
                                  backgroundColor: BackgroundColors.blue,
                                  foregroundColor: MainColors.primary,
                                  text: context.loc.back.capitalize(),
                                  onPressed: (){
                                    context.pop();
                                  }
                                ),
                              ),
                              gapW12,
                              Expanded(
                                child: MyButton(
                                  type: ButtonTypes.filledFullyRounded,
                                  text: context.loc.logout.capitalize(),
                                  onPressed: () async{
                                    await ref.read(profileScreenControllerProvider.notifier).signOut();
                                  }
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
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