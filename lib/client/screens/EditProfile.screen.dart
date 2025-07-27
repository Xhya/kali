import 'package:flutter/material.dart';
import 'package:kali/client/Utils/Input.decoration.dart';
import 'package:kali/client/widgets/MainButton.widget.dart';
import 'package:kali/core/models/EditUser.formdata.dart';
import 'package:kali/core/services/Error.service.dart';
import 'package:kali/core/services/Navigation.service.dart';
import 'package:kali/core/services/User.service.dart';
import 'package:kali/core/states/editProfile.state.dart';
import 'package:kali/core/states/nutriScore.state.dart';
import 'package:kali/core/states/user.state.dart';
import 'package:provider/provider.dart';
import 'package:kali/client/Style.service.dart';
import 'package:kali/client/Utils/MaxCharactersCountFormatter.utils.dart';
import 'package:kali/client/layout/Base.scaffold.dart';
import 'package:kali/client/widgets/CustomCard.widget.dart';
import 'package:kali/client/widgets/CustomInput.dart';
import 'package:kali/core/utils/macroIcon.utils.dart';

onClickSave() async {
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
    String calories = context.select(
      (EditProfileState s) => s.editingCalories.value,
    );
    String proteins = context.select(
      (EditProfileState s) => s.editingProteins.value,
    );
    String glucids = context.select(
      (EditProfileState s) => s.editingGlucids.value,
    );
    String lipids = context.select(
      (EditProfileState s) => s.editingLipids.value,
    );
    String userName = context.select((EditProfileState s) => s.userName.value);
    String leitmotiv = context.select(
      (EditProfileState s) => s.leitmotiv.value,
    );
    bool isLoading = context.select((EditProfileState s) => s.isLoading.value);

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
                        title: "Ton num d'utilisateur",
                        onChanged: (value) {
                          editProfileState.userName.value = value;
                        },
                        suffixIcon: Icon(Icons.ac_unit_outlined),
                      ),
                      SizedBox(height: 32),
                      CustomInput(
                        content: leitmotiv,
                        title: "Ton leitmotiv",
                        onChanged: (value) {
                          editProfileState.leitmotiv.value = value;
                        },
                        suffixIcon: Icon(Icons.ac_unit_outlined),
                        maxLines: 4,
                        inputFormatters: [
                          MaxCharactersCountFormatter(maxLength: 120),
                        ],
                      ),
                      SizedBox(height: 32),
                      Text(
                        "Ton plan personnalisé",
                        style: style.text.neutral.merge(style.fontsize.sm),
                      ),
                      SizedBox(height: 4),
                      CustomCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          spacing: 12,
                          children: [
                            Text(
                              "⚖️",
                              textAlign: TextAlign.start,
                              style: style.text.green
                                  .merge(style.fontsize.md)
                                  .merge(style.fontweight.bold),
                            ),

                            Expanded(
                              child: Text(
                                "calories",
                                textAlign: TextAlign.start,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                  text: calories,
                                ),
                                textAlign: TextAlign.end,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                                decoration: inputDecoration,
                                onChanged: (value) {
                                  editProfileState.editingCalories.value =
                                      value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          spacing: 12,
                          children: [
                            Text(
                              proteinIcon,
                              textAlign: TextAlign.start,
                              style: style.text.green
                                  .merge(style.fontsize.md)
                                  .merge(style.fontweight.bold),
                            ),

                            Expanded(
                              child: Text(
                                "protéines",
                                textAlign: TextAlign.start,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                  text: proteins,
                                ),
                                textAlign: TextAlign.end,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                                decoration: inputDecoration,
                                onChanged: (value) {
                                  editProfileState.editingProteins.value =
                                      value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          spacing: 12,
                          children: [
                            Text(
                              glucidIcon,
                              textAlign: TextAlign.start,
                              style: style.text.green
                                  .merge(style.fontsize.md)
                                  .merge(style.fontweight.bold),
                            ),

                            Expanded(
                              child: Text(
                                "glucides",
                                textAlign: TextAlign.start,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                  text: glucids,
                                ),
                                textAlign: TextAlign.end,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                                decoration: inputDecoration,
                                onChanged: (value) {
                                  editProfileState.editingGlucids.value = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          spacing: 12,
                          children: [
                            Text(
                              lipidIcon,
                              textAlign: TextAlign.start,
                              style: style.text.green
                                  .merge(style.fontsize.md)
                                  .merge(style.fontweight.bold),
                            ),

                            Expanded(
                              child: Text(
                                "lipides",
                                textAlign: TextAlign.start,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(text: lipids),
                                onChanged: (value) {
                                  editProfileState.editingLipids.value = value;
                                },
                                textAlign: TextAlign.end,
                                style: style.text.neutral.merge(
                                  style.fontsize.sm,
                                ),
                                decoration: inputDecoration,
                              ),
                            ),
                          ],
                        ),
                      ),
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
        ),
      ),
    );
  }
}
