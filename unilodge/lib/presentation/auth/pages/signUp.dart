import 'package:dlibphonenumber/phone_number_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:unilodge/core/configs/theme/app_colors.dart';
import 'package:unilodge/core/configs/theme/app_theme.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  DateTime? _selectedDate;
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');
  PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;

  void _nextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ??
          DateTime(
            now.year - 18,
            now.month,
            now.day,
          ),
      firstDate: DateTime(1900),
      lastDate: DateTime(
        now.year - 18,
        now.month,
        now.day,
      ),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff83a2ac),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
            stops: [0.00, 0.18, 0.90],
          ),
        ),
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    const Text(
                      'UniLodge',
                      style: TextStyle(
                        fontFamily: AppTheme.logoFont,
                        fontSize: 36,
                        color: AppColors.lightBlueTextColor,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: [
                          _buildPersonalInfoPage(context, screenHeight),
                          _buildAccountInfoPage(context, screenHeight),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.go("/account-selection-signup");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoPage(BuildContext context, double screenHeight) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          _buildTextField("Email", "Enter email"),
          const SizedBox(height: 20.0),
          _buildTextField("First Name", "Enter first name"),
          const SizedBox(height: 20.0),
          _buildTextField("Middle Name", "Enter middle name"),
          const SizedBox(height: 20.0),
          _buildTextField("Last Name", "Enter last name"),
          const SizedBox(height: 20.0),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              _phoneNumber = number;
              print('Phone number: ${number.phoneNumber}');
              bool isValid = phoneUtil.isValidNumber(
                  phoneUtil.parse(number.phoneNumber, number.isoCode));
              print('is it valid: $isValid');
            },
            onInputValidated: (bool isValid) {},
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _phoneNumber,
            formatInput: true,
            keyboardType: TextInputType.phone,
            inputDecoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Phone Number',
              hintText: 'Enter phone number',
            ),
          ),
          SizedBox(height: screenHeight * 0.10),
          _buildPageIndicator(),
          const SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: _nextPage,
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildLoginText(context),
        ],
      ),
    );
  }

  Widget _buildAccountInfoPage(BuildContext context, double screenHeight) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          _buildTextField("Username", "Enter username"),
          const SizedBox(height: 20.0),
          InkWell(
            onTap: () => _selectDate(context),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: _selectedDate != null ? "Birthdate" : null,
                filled: true,
                fillColor: AppColors.blueTextColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
              ),
              child: Text(
                _selectedDate == null
                    ? 'Select birthdate'
                    : DateFormat.yMMMd().format(_selectedDate!),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          _buildTextField("Password", "Enter password", obscureText: true),
          const SizedBox(height: 20.0),
          _buildTextField("Confirm Password", "Enter confirm password",
              obscureText: true),
          SizedBox(height: screenHeight * 0.17),
          _buildPageIndicator(),
          const SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () {
              context.go('/home');
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildLoginText(context),
          TextButton(
            onPressed: _previousPage,
            child: const Text(
              'Back',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, String hintText,
      {bool obscureText = false}) {
    return TextField(
      keyboardType:
          obscureText ? TextInputType.visiblePassword : TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.blueTextColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          height: 1.3,
        ),
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        InkWell(
          onTap: () {
            context.go('/login');
          },
          child: const Text(
            "Log in",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(0),
        const SizedBox(width: 8),
        _buildDot(1),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? AppColors.primary : Colors.grey.shade300,
      ),
    );
  }
}
