import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/models/basic_account.dart';
import 'package:tsport_mobile_app/models/update_account_request.dart';
import 'package:tsport_mobile_app/services/account_service.dart';
import 'package:tsport_mobile_app/widgets/custom_text_field.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  BasicAccount? _account;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin cơ bản',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: bodyContent(),
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    var account = await AccountService().fetchBasicAccountInfo();

    if (_account != null) {
      setState(() {
        _account = account;
        // firstNameController.text = _account?.firstName ?? '';
        // lastNameController.text = _account?.lastName ?? '';
        // addressController.text = _account?.address ?? '';
        // phoneController.text = _account?.phone ?? '';
        // _selectedGender = _account?.gender;
      });
    }
  }

  String? validateAddress(String? value) {
    if (value != null && value.length > 255) {
      return 'Địa chỉ quá dài';
    }

    return null;
  }

  String? validatePhone(String? value) {
    if (value != null && value.length > 15) {
      return 'Số điện thoại quá dài';
    }

    return null;
  }

  Widget bodyContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                textController: firstNameController,
                labelText: 'Họ',
                validator: null,

              ),
              const SizedBox(height: 10),
              CustomTextField(
                textController: lastNameController,
                labelText: 'Tên',
                validator: null,

              ),
              const SizedBox(height: 10),
              CustomTextField(
                textController: addressController,
                labelText: 'Địa chỉ',
                validator: null,

              ),
              const SizedBox(height: 10),
              CustomTextField(
                textController: phoneController,
                labelText: 'Số điện thoại',
                validator: null,
              ),
              const SizedBox(height: 10),
              genderSelect(),
              const SizedBox(height: 20),
              saveButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget genderSelect() {
    return Column(children: [
      const SizedBox(height: 10),
      const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Giới tính',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      const SizedBox(height: 3),
      ListTile(
        title: const Text('Nam'), // 'Nam' is 'Male' in Vietnamese
        leading: Radio<String>(
          value: "Male",
          groupValue: _selectedGender,
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Nữ'), // 'Nữ' is 'Female' in Vietnamese
        leading: Radio<String>(
          value: "Female",
          groupValue: _selectedGender,
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Khác'), // 'Khác' is 'Other' in Vietnamese
        leading: Radio<String>(
          value: "Khác",
          groupValue: _selectedGender,
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ),
    ]);
  }

  Future handleSubmission() async {
    // Unfocus all text fields to hide the keyboard
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      var request = UpdateAccountRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: _selectedGender,
        address: addressController.text,
        phone: phoneController.text,
      );

      // Use a local variable to store the current context
      final BuildContext dialogContext = context;

      final bool? confirmed = await showDialog<bool>(
        context: dialogContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Xác nhận'),
            content: const Text('Lưu thông tin?'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), // User presses "No"
                child: const Text('Không'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // User presses "Yes"
                child: const Text('Có'),
              ),
            ],
          );
        },
      );

      if (confirmed != null && confirmed) {
        final response = await AccountService().updateCustomerInfo(request);
        if (response.statusCode == 204) {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Thành công!'),
                content: const Text('Lưu thông tin thành công!'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss the dialog
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  Widget saveButton() {
    return ElevatedButton(
        onPressed: () async {
          await handleSubmission();
        },
        child: const Text('Lưu'));
  }
}
