import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  void initState() {
    super.initState();
    _registerController.emailController.addListener(_updateEmailError);
    _registerController.usernameController.addListener(_updateUsernameError);
    _registerController.passwordController.addListener(_updatePassError);
    _registerController.copasswordController.addListener(_updatecoPassError);
  }

  @override
  void dispose() {
    _registerController.emailController.removeListener(_updateEmailError);
    _registerController.usernameController.removeListener(_updateUsernameError);
    _registerController.passwordController.removeListener(_updatePassError);
    _registerController.copasswordController.removeListener(_updatecoPassError);
    super.dispose();
  }

  void _updateEmailError() {
    setState(() {
      _registerController.emailError.value =
          !_registerController.isEmailValid();
    });
  }

  void _updateUsernameError() {
    setState(() {
      _registerController.usernameError.value =
          _registerController.usernameController.text.isEmpty;
    });
  }

  void _updatePassError() {
    setState(() {
      _registerController.passwordError.value =
          _registerController.passwordController.text.isEmpty;
    });
  }

  void _updatecoPassError() {
    setState(() {
      _registerController.copasswordError.value =
          _registerController.copasswordController.text !=
              _registerController.passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 1, 64),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Welcome new user, \nPlease create your account here',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 100),
              Obx(
                () => TextField(
                  controller: _registerController.usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: _registerController.usernameError.value
                              ? Colors.red
                              : Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Obx(
                () => TextField(
                  controller: _registerController.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: _registerController.emailError.value
                              ? Colors.red
                              : Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Obx(
                () => TextField(
                  controller: _registerController.passwordController,
                  obscureText: _registerController.obsecuretext.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: _registerController.passwordError.value
                              ? Colors.red
                              : Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _registerController.obsecuretext.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: _registerController.toggleObsecureText,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Obx(
                () => TextField(
                  controller: _registerController.copasswordController,
                  obscureText: _registerController.obsecuretext2.value,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: _registerController.copasswordError.value
                              ? Colors.red
                              : Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _registerController.obsecuretext2.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: _registerController.toggleObsecureText2,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (!_registerController.emailError.value &&
                        !_registerController.usernameError.value &&
                        !_registerController.passwordError.value &&
                        !_registerController.copasswordError.value) {
                      _registerController.registerUser();
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please fix the errors in the form before proceeding',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 34,
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Spacer(),
              TextButton(
                onPressed: () {
                  // Tambahkan logika untuk navigasi ke halaman login
                  Get.toNamed('/login');
                },
                child: Text(
                  'Already Have Account? Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
