import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/button.dart';
import 'package:chatapp/components/textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmedPwController = TextEditingController();


  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final auth = AuthService();
    if(pwController.text == confirmedPwController.text) {
      try {
        auth.signUpWithEmailPassword(emailController.text, pwController.text);
      } catch (e) {
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),);
      }
    } else {
      showDialog(context: context, builder: (context) => const AlertDialog(
        title: Text("Passwords don't match!"),
      ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceTint,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add_alt_1,
              size: 100,
              color: Theme.of(context).colorScheme.primary,),
            const SizedBox(
              height: 30,
            ),
            Text("Welcome back to ChatApp!", style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),),
            const SizedBox(
              height: 20,
            ),
            TextFields(
              hintText: "E-Mail",
              controller: emailController,),
            const SizedBox(height: 15,),
            TextFields(
              hintText: "Password",
              obscureText: true,
              controller: pwController,),
            const SizedBox(height: 15,),
            TextFields(
              hintText: "Confirm Password",
              obscureText: true,
              controller: confirmedPwController,),
            const SizedBox(height: 25,),
            Button(text: "Register", onTap: () => register(context),),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ", style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                ),),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now!",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                  ),),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
