import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/button.dart';
import 'package:chatapp/components/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  final void Function()? onTap;
  LoginPage({super.key , required this.onTap});

  void login(BuildContext context) async{
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(emailController.text, pwController.text);

    } catch (e) {
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),),);
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
            Icon(Icons.person,
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
            const SizedBox(height: 25,),
            Button(text: "Login", onTap:() =>  login(context),),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? ", style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                ),),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now!",style: TextStyle(
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
