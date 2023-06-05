import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jadwal_sholat/navbar.dart';
import 'package:jadwal_sholat/page/register.dart';
import 'package:jadwal_sholat/widget/encryption.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _usernameField(),
                    const SizedBox(height: 20),
                    _passwordField(),
                    const SizedBox(height: 20),
                    _loginButton(),
                    const SizedBox(height: 20),
                    _changeButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        labelText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "********",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (Hive.isBoxOpen('users')) {
            bool isUserExist = await checkUser(
                usernameController.text, passwordController.text);

            if (isUserExist == true && context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Navbar(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Either your Email or Password is incorrect!'),
                ),
              );
            }
          } else {
            await Hive.openBox('users');

            bool isUserExist = await checkUser(
                usernameController.text, passwordController.text);

            if (isUserExist == true && context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Navbar(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Either your Email or Password is incorrect!'),
                ),
              );
            }
          }
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child: const Text("Login"),
      ),
    );
  }

  Future<void> deleteHiveDatabase() async {
    await Hive.openBox('users');
    // Get the application documents directory
    var user = Hive.box('users');

    await user.clear();
  }

  Future<bool> checkUser(String mail, String pass) async {
    var user = Hive.box('users');
    final email = mail;
    final password = pass;

    // Fetch all users from the box
    final allUsers = user.values.toList();
    print("alluser : $allUsers");

    String encryptedPassword = CustomEncryption.enrcyptAES(password).toString();
    print("encrypted login : $encryptedPassword");

    // Check if there are matching email and password in the list of users
    final matchingUser = allUsers.any(
      (user) => user.email == email && user.password == encryptedPassword,
    );

    print("matching user $matchingUser");

    if (matchingUser == true) {
      return true;
    } else {
      return false;
    }
  }

  Widget _changeButton() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Belum punya akun?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Register(),
                ),
              );
            },
            child: const Text(
              'Daftar',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
