import 'package:flutter/material.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/widgets/custom_text_field.dart';
import 'package:wil_doc/widgets/custom_dropdown_menu.dart';

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
    // Logic to save user profile information goes here
    Navigator.pushReplacementNamed(context, AppRoutes.scanDocument);
  }

  List<String> getWardList(String prefecture) {
    // Add logic here to return the list of wards based on the selected prefecture
    if (prefecture == 'Tokyo') {
      return ['Chiyoda', 'Chuo', 'Minato', 'Shinjuku'];
    } else if (prefecture == 'Osaka') {
      return ['Kita', 'Chuo', 'Nishi', 'Yodogawa'];
    }
    // Add other prefectures and their wards as needed
    return [];
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _fullNameController,
              labelText: 'Full Name',
            ),
            const SizedBox(height: 16.0),
            CustomDropdownMenu<String>(
              controller: _nationalityController,
              labelText: 'Nationality',
              items: nationalityList,
              selectedValue: selectedNationality,
              onSelected: (String? nationality) {
                setState(() {
                  selectedNationality = nationality;
                });
              },
            ),
            const SizedBox(height: 16.0),
            CustomDropdownMenu<String>(
              controller: _visaStatusController,
              labelText: 'Visa Status',
              items: visaStatusList,
              selectedValue: selectedVisaStatus,
              onSelected: (String? visaStatus) {
                setState(() {
                  selectedVisaStatus = visaStatus;
                });
              },
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _selectVisaExpiration(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _visaExpirationController,
                  decoration: const InputDecoration(
                    labelText: 'Visa Expiration',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            CustomDropdownMenu<String>(
              controller: _prefectureController,
              labelText: 'Prefecture',
              items: prefectureList,
              selectedValue: selectedPrefecture,
              onSelected: (String? prefecture) {
                setState(() {
                  selectedPrefecture = prefecture;
                  selectedWard = null; // Reset ward when prefecture changes
                });
              },
            ),
            const SizedBox(height: 16.0),
            CustomDropdownMenu<String>(
              controller: _wardController,
              labelText: 'Ward',
              items: selectedPrefecture != null ? getWardList(selectedPrefecture!) : [],
              selectedValue: selectedWard,
              onSelected: (String? ward) {
                setState(() {
                  selectedWard = ward;
                });
              },
              menuHeight: 200.0,
              enabled: selectedPrefecture != null,
            ),
            const SizedBox(height: 16.0),
            CustomDropdownMenu<String>(
              controller: _japaneseProficiencyController,
              labelText: 'Japanese Proficiency',
              items: proficiencyList,
              selectedValue: selectedProficiency,
              onSelected: (String? proficiency) {
                setState(() {
                  selectedProficiency = proficiency;
                });
              },
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _completeProfile,
              icon: const Icon(Icons.done, color: Colors.white),
              label: Text('Finish', style: TextStyle(color: theme.colorScheme.onPrimary)),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

// List of nationalities
const List<String> nationalityList = [
  'American', 'Colombian', 'Indian', 'Nepali'
];

// List of visa statuses
const List<String> visaStatusList = [
  'Student', 'Work', 'Dependent', 'Permanent Resident'
];

// List of prefectures
const List<String> prefectureList = [
  'Hokkaido', 'Aomori', 'Iwate', 'Miyagi', 'Akita', 'Yamagata', 'Fukushima', 'Ibaraki', 'Tochigi', 'Gunma', 'Saitama', 'Chiba', 'Tokyo', 'Kanagawa', 'Niigata', 'Toyama', 'Ishikawa', 'Fukui', 'Yamanashi', 'Nagano', 'Gifu', 'Shizuoka', 'Aichi', 'Mie', 'Shiga', 'Kyoto', 'Osaka', 'Hyogo', 'Nara', 'Wakayama', 'Tottori', 'Shimane', 'Okayama', 'Hiroshima', 'Yamaguchi', 'Tokushima', 'Kagawa', 'Ehime', 'Kochi', 'Fukuoka', 'Saga', 'Nagasaki', 'Kumamoto', 'Oita', 'Miyazaki', 'Kagoshima', 'Okinawa'
];

// List of Japanese proficiency levels
const List<String> proficiencyList = [
  'Beginner', 'Intermediate', 'Advanced', 'Native'
];

