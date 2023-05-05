import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawyers_list/controller/sign_in_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
          child: Card(
        elevation: 8,
        color: Colors.white,
        child: SizedBox(
          height: size.height * 0.4,
          width: size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<SignInProvider>(builder: (context, value, _) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    SizedBox(
                        // color: Colors.amber,
                        width: size.width * 0.8,
                        height: size.width * 0.37,
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextFormField(
                                controller: value.phoneConroller,
                                validator: (number) =>
                                    number != null && number.length < 10
                                        ? 'Enter valid number'
                                        : null,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                    ),
                                    labelText: 'phone',
                                    labelStyle: GoogleFonts.poppins(
                                        color: Colors.black),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 2,
                                        ))),
                              ),
                              TextFormField(
                                controller: value.passwordController,
                                validator: (value) =>
                                    value != null && value.length < 6
                                        ? 'Enter min 6 character'
                                        : null,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      CupertinoIcons.padlock,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Password',
                                    labelStyle: GoogleFonts.poppins(
                                        color: Colors.black),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 5),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 2,
                                        ))),
                              ),
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    value.isNotUser == true
                                        ? Colors.red
                                        : Colors.blueGrey)),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              value.signIn(context);
                            },
                            child: value.isLoading == true
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  )
                                : Text(
                                    'login',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                      ),
                    )
                  ]);
            }),
          ),
        ),
      )),
    );
  }
}
