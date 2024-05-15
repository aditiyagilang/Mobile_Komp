import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _loginController = Get.put(LoginController());
  bool emailError = false;
  bool passError = false;

  @override
  void initState() {
    super.initState();
    _loginController.emailController.addListener(_updateEmailError);
    _loginController.passwordController.addListener(_updatePassError);
  }

  @override
  void dispose() {
    _loginController.emailController.removeListener(_updateEmailError);
    _loginController.passwordController.removeListener(_updatePassError);
    super.dispose();
  }

  void _updateEmailError() {
    setState(() {
      emailError = !_loginController.isEmailValid();
    });
  }

  void _updatePassError() {
    setState(() {
      passError = _loginController.passwordController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 1, 64),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Welcome back, \nPlease login to enter your account',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 100),
              TextField(
                controller: _loginController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: emailError ? Colors.red : Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorText: emailError ? 'Email tidak valid' : null,
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: _loginController.passwordController,
                  obscureText: _loginController.obsecuretext.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: passError ? Colors.red : Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorText: passError ? 'Password tidak boleh kosong' : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _loginController.obsecuretext.value ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _loginController.toggleObsecureText,
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    _loginController.signInWithEmailAndPassword();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(width: 20),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
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
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot the password?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Get.offNamed(Routes.REGISTER);
                },
                child: const Text(
                  'Dont Have Account? Register',
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
