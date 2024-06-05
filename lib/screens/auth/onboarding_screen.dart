import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wil_doc/models/user.dart' as model;
import 'package:wil_doc/providers/user_provider.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/widgets/custom_text_field.dart';
import 'package:wil_doc/widgets/custom_dropdown_menu.dart';
import 'package:wil_doc/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _visaStatusController = TextEditingController();
  final TextEditingController _visaExpirationController = TextEditingController();
  final TextEditingController _prefectureController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _japaneseProficiencyController = TextEditingController();
  String? selectedNationality;
  String? selectedVisaStatus;
  DateTime? selectedVisaExpiration;
  String? selectedPrefecture;
  String? selectedWard;
  String? selectedProficiency;

  Future<void> _completeProfile() async {
  if (kDebugMode) {
    print("Complete profile method called");
  }

  // Check if the current user is signed in
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    if (kDebugMode) {
      print("No user is signed in.");
    }
    return;
  }

  // Ensure required fields are not null
  if (selectedNationality == null ||
      selectedVisaStatus == null ||
      selectedPrefecture == null ||
      selectedProficiency == null) {
    if (kDebugMode) {
      print("One or more required fields are not selected.");
    }
    return;
  }

  // Check if the selected prefecture has wards
  final wardList = getWardList(selectedPrefecture!);
  final hasWards = wardList.isNotEmpty;

  // If the prefecture has wards, ensure the ward field is not null
  if (hasWards && selectedWard == null) {
    if (kDebugMode) {
      print("Ward is required for the selected prefecture.");
    }
    return;
  }

  if (kDebugMode) {
    print("Creating user model");
  }
  final user = model.User(
    userId: currentUser.uid,
    email: currentUser.email!,
    password: '',
    fullName: _fullNameController.text,
    nationality: selectedNationality!,
    visaStatus: selectedVisaStatus!,
    durationOfStay: _visaExpirationController.text,
    prefecture: selectedPrefecture!,
    ward: hasWards ? selectedWard! : '',
    japaneseProficiency: selectedProficiency!,
    preferredLanguage: 'en',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

    try {
      if (kDebugMode) {
        print("Attempting to get UserProvider");
      }
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      if (kDebugMode) {
        print("Calling saveUser in UserProvider with user: ${user.toMap()}");
      }
      await userProvider.saveUser(user);

      if (kDebugMode) {
        print("User saved successfully");
      }

      // Navigate to the next screen if the widget is still mounted
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.scanDocument);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving user: $e");
      }
    }
  }

  List<String> getWardList(String prefecture) {
    return wardsMap[prefecture] ?? [];
  }

  Future<void> _selectVisaExpiration(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.input,
      context: context,
      initialDate: selectedVisaExpiration ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedVisaExpiration) {
      setState(() {
        selectedVisaExpiration = picked;
        _visaExpirationController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tell us about yourself', style: theme.textTheme.titleLarge),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FullNameField(controller: _fullNameController),
            const SizedBox(height: 16.0),
            NationalityDropdown(
              controller: _nationalityController,
              selectedNationality: selectedNationality,
              onSelected: (String? nationality) {
                setState(() {
                  selectedNationality = nationality;
                });
              },
            ),
            const SizedBox(height: 16.0),
            VisaStatusDropdown(
              controller: _visaStatusController,
              selectedVisaStatus: selectedVisaStatus,
              onSelected: (String? visaStatus) {
                setState(() {
                  selectedVisaStatus = visaStatus;
                });
              },
            ),
            const SizedBox(height: 16.0),
            VisaExpirationField(
              controller: _visaExpirationController,
              selectVisaExpiration: () => _selectVisaExpiration(context),
            ),
            const SizedBox(height: 16.0),
            PrefectureDropdown(
              controller: _prefectureController,
              selectedPrefecture: selectedPrefecture,
              onSelected: (String? prefecture) {
                setState(() {
                  selectedPrefecture = prefecture;
                  selectedWard = null;
                });
              },
            ),
            const SizedBox(height: 16.0),
            WardDropdown(
              controller: _wardController,
              selectedPrefecture: selectedPrefecture,
              selectedWard: selectedWard,
              onSelected: (String? ward) {
                setState(() {
                  selectedWard = ward;
                });
              },
              getWardList: getWardList,
            ),
            const SizedBox(height: 16.0),
            ProficiencyDropdown(
              controller: _japaneseProficiencyController,
              selectedProficiency: selectedProficiency,
              onSelected: (String? proficiency) {
                setState(() {
                  selectedProficiency = proficiency;
                });
              },
            ),
            const SizedBox(height: 16.0),
            FinishButton(onPressed: _completeProfile),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class FullNameField extends StatelessWidget {
  final TextEditingController controller;

  const FullNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Full Name',
    );
  }
}

class NationalityDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedNationality;
  final ValueChanged<String?> onSelected;

  const NationalityDropdown({
    super.key,
    required this.controller,
    required this.selectedNationality,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu<String>(
      controller: controller,
      labelText: 'Nationality',
      items: nationalityList,
      selectedValue: selectedNationality,
      onSelected: onSelected,
    );
  }
}

class VisaStatusDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedVisaStatus;
  final ValueChanged<String?> onSelected;

  const VisaStatusDropdown({
    super.key,
    required this.controller,
    required this.selectedVisaStatus,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu<String>(
      controller: controller,
      labelText: 'Visa Status',
      items: visaStatusList,
      selectedValue: selectedVisaStatus,
      onSelected: onSelected,
    );
  }
}

class VisaExpirationField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback selectVisaExpiration;

  const VisaExpirationField({
    super.key,
    required this.controller,
    required this.selectVisaExpiration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectVisaExpiration,
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Visa Expiration',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }
}

class PrefectureDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedPrefecture;
  final ValueChanged<String?> onSelected;

  const PrefectureDropdown({
    super.key,
    required this.controller,
    required this.selectedPrefecture,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu<String>(
      controller: controller,
      labelText: 'Prefecture',
      items: prefectureList,
      selectedValue: selectedPrefecture,
      onSelected: onSelected,
    );
  }
}

class WardDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedPrefecture;
  final String? selectedWard;
  final ValueChanged<String?> onSelected;
  final List<String> Function(String) getWardList;

  const WardDropdown({
    super.key,
    required this.controller,
    required this.selectedPrefecture,
    required this.selectedWard,
    required this.onSelected,
    required this.getWardList,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu<String>(
      controller: controller,
      labelText: 'Ward',
      items: selectedPrefecture != null ? getWardList(selectedPrefecture!) : [],
      selectedValue: selectedWard,
      onSelected: onSelected,
      menuHeight: 200.0,
      enabled: selectedPrefecture != null,
    );
  }
}

class ProficiencyDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedProficiency;
  final ValueChanged<String?> onSelected;

  const ProficiencyDropdown({
    super.key,
    required this.controller,
    required this.selectedProficiency,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu<String>(
      controller: controller,
      labelText: 'Japanese Proficiency',
      items: proficiencyList,
      selectedValue: selectedProficiency,
      onSelected: onSelected,
    );
  }
}

class FinishButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FinishButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.done, color: Colors.white),
      label: Text('Finish', style: TextStyle(color: theme.colorScheme.onPrimary)),
    );
  }
}
