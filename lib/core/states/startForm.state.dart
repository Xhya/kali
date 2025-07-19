import 'package:flutter/material.dart';
import 'package:kali/client/widgets/CustomSelect.widget.dart';

var startFormState = StartFormState();

class StartFormState extends ChangeNotifier {
  final controller = ValueNotifier<PageController>(PageController());

  final currentPage = ValueNotifier<int>(0);

  final size = ValueNotifier<String>("");
  final weight = ValueNotifier<String>("");
  final age = ValueNotifier<String>("");
  final isLoading = ValueNotifier<bool>(false);
  bool get isSubmitButtonDisabled =>
      size.value.isEmpty || weight.value.isEmpty || age.value.isEmpty;
  final genderOption = ValueNotifier<SelectOption?>(null);
  final objectiveOption = ValueNotifier<SelectOption?>(null);

  StartFormState() {
    size.addListener(notifyListeners);
    weight.addListener(notifyListeners);
    age.addListener(notifyListeners);
    isLoading.addListener(notifyListeners);
    currentPage.addListener(notifyListeners);
    genderOption.addListener(notifyListeners);
    objectiveOption.addListener(notifyListeners);
  }

  @override
  void dispose() {
    size.dispose();
    weight.dispose();
    age.dispose();
    isLoading.dispose();
    currentPage.dispose();
    genderOption.dispose();
    objectiveOption.dispose();
    super.dispose();
  }
}
