import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomIcon.widget.dart';
import 'package:kali/client/widgets/EmailInput.widget.dart';
import 'package:kali/client/widgets/MacroElementRow.widget.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/client/widgets/UpdatePassword.widget.dart';
import 'package:kali/client/widgets/WelcomeBottomSheet.widget.dart';
import 'package:kali/core/models/EditUser.formdata.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/states/Input.state.dart';
import 'package:kali/core/states/editProfile.state.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/MaxCharactersCountFormatter.utils.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';

Future<void> onClickSave() async {
  try {
    editProfileState.isLoading.value = true;
    final user = await UserService().saveProfile(
      EditUserFormData(
        userName: editProfileState.userName.value,
        leitmotiv: editProfileState.leitmotiv.value,
        calories: editProfileState.editingCalories.value.toString(),
        proteins: editProfileState.editingProteins.value.toString(),
        glucids: editProfileState.editingGlucids.value.toString(),
        lipids: editProfileState.editingLipids.value.toString(),
        email: inputState.email.value,
      ),
    );
    userState.user.value = user;
    navigationService.navigateBack();
  } catch (e, stack) {
    errorService.notifyError(e: e, stack: stack);
  } finally {
    editProfileState.isLoading.value = false;
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    editProfileState.isLoading.value = false;

    inputState.email.value = userState.user.value?.email ?? "";
    editProfileState.leitmotiv.value = userState.user.value?.leitmotiv ?? "";
    editProfileState.userName.value = userState.user.value?.username ?? "";
    editProfileState.editingCalories.value =
        userState.personalNutriscore?.caloryAmount.toString() ?? "";
    editProfileState.editingProteins.value =
        userState.personalNutriscore?.proteinAmount.toString() ?? "";
    editProfileState.editingGlucids.value =
        userState.personalNutriscore?.glucidAmount.toString() ?? "";
    editProfileState.editingLipids.value =
        userState.personalNutriscore?.lipidAmount.toString() ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editingCalories = context.select(
      (EditProfileState s) => s.editingCalories.value,
    );
    final editingProteins = context.select(
      (EditProfileState s) => s.editingProteins.value,
    );
    final editingGlucids = context.select(
      (EditProfileState s) => s.editingGlucids.value,
    );
    final editingLipids = context.select(
      (EditProfileState s) => s.editingLipids.value,
    );
    String userName = context.select((EditProfileState s) => s.userName.value);
    String leitmotiv = context.select(
      (EditProfileState s) => s.leitmotiv.value,
    );
    bool isLoading = context.select((EditProfileState s) => s.isLoading.value);
    bool canSave = context.select((EditProfileState s) => s.canSave);

    return BaseScaffold(
      backButton: true,
      child: Scaffold(
        backgroundColor: style.background.greenTransparent.color,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomInput(
                        content: userName,
                        title: "Ton nom d'utilisateur",
                        onChanged: (value) {
                          editProfileState.userName.value = value;
                        },
                        customIcon: CustomIconWidget(
                          format: CustomIconFormat.svg,
                          icon: "assets/icons/user.svg",
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      if (userState.user.value?.emailVerifiedAt != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 32),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Ton email",
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            EmailInputWidget(),
                          ],
                        ),
  
                      if (userState.user.value?.emailVerifiedAt != null)
                        SizedBox(height: 8),

                      if (userState.user.value?.emailVerifiedAt != null)
                        GestureDetector(
                          onTap: () async {
                            navigationService.context = context;
                            navigationService.openBottomSheet(
                              widget: WelcomeBottomSheet(
                                child: UpdatePasswordWidget(),
                              ),
                            );
                          },
                          child: Text(
                            "Changer mon mot de passe",
                            style: style.fontsize.sm
                                .merge(style.text.neutral)
                                .merge(
                                  TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: style.text.neutral.color,
                                  ),
                                ),
                          ),
                        ),

                      SizedBox(height: 32),
                      CustomInput(
                        content: leitmotiv,
                        title: "Ton leitmotiv",
                        onChanged: (value) {
                          editProfileState.leitmotiv.value = value;
                        },
                        customIcon: CustomIconWidget(
                          format: CustomIconFormat.svg,
                          icon: "assets/icons/stylo.svg",
                        ),
                        maxLines: 4,
                        inputFormatters: [
                          MaxCharactersCountFormatter(maxLength: 120),
                        ],
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      SizedBox(height: 32),
                      Text(
                        "Ton plan personnalisé",
                        style: style.text.neutral.merge(style.fontsize.sm),
                      ),
                      SizedBox(height: 4),
                      MacroElementRow(
                        text: "calories",
                        icon: caloryIcon,
                        amount: editingCalories,
                        onUpdate: (String value) {
                          editProfileState.editingCalories.value = value;
                        },
                      ),
                      SizedBox(height: 4),
                      MacroElementRow(
                        text: "protéines",
                        icon: proteinIcon,
                        amount: editingProteins,
                        onUpdate: (String value) {
                          editProfileState.editingProteins.value = value;
                        },
                      ),
                      SizedBox(height: 4),
                      MacroElementRow(
                        text: "glucides",
                        icon: glucidIcon,
                        amount: editingGlucids,
                        onUpdate: (String value) {
                          editProfileState.editingGlucids.value = value;
                        },
                      ),
                      SizedBox(height: 4),
                      MacroElementRow(
                        text: "lipides",
                        icon: lipidIcon,
                        amount: editingLipids,
                        onUpdate: (String value) {
                          editProfileState.editingLipids.value = value;
                        },
                      ),
                      SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: MainButtonWidget(
          onClick: () {
            navigationService.context = context;
            onClickSave();
          },
          text: "Enregistrer",
          isLoading: isLoading,
          disabled: !canSave,
        ),
      ),
    );
  }
}
