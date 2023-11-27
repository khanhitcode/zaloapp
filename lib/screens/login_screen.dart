import 'package:flutter/material.dart';
import 'package:zalo_app/resources/auth_methods.dart';
import 'package:zalo_app/responsive/mobile_screen_layout.dart';
import 'package:zalo_app/responsive/responsive_layout.dart';
import 'package:zalo_app/responsive/web_screen_layout.dart';
import 'package:zalo_app/untils/colors.dart';
import 'package:zalo_app/untils/global_variable.dart';
import 'package:zalo_app/untils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        phone: _phoneController.text, password: _passwordController.text);
    if (res == 'success') {
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              ),
            ),
            (route) => false);

        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Đăng nhập",
          style: TextStyle(color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _phoneController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Số điện thoại",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    TextField(
                      obscureText: _isLoading,
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: "Mật khẩu",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoading = !_isLoading;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          _isLoading ? "HIỆN" : "ẨN",
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Đăng Nhập',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
