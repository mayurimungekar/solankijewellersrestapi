import 'package:flutter/material.dart';
import 'package:solanki/api_service.dart';
import 'package:solanki/utils/ProgressHUD.dart';
import 'package:solanki/utils/form_helper.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late String username;
  late String password;
  late APIService apiService;

  @override
  void initState() {
    apiService = new APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ProgressHUD(
      inAsyncCall: isApiCallProcess,
    opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: const EdgeInsets.symmetric( vertical: 85, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      offset: const Offset(0,10),
                      blurRadius: 20,
                    )
                  ]
                ),
                child: Form(
                  key: globalKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text('Login',
                        style: Theme.of(context).textTheme.displayMedium,),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) =>username = input!,
                          validator: (input) => !input!.contains('@')
                            ? "Email Id Should be valid"
                              : null,
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).colorScheme.secondary,
                            )
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => password = input!,
                          validator: (input) => input!.length < 3
                          ? "Password Should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor.withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            )),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  hidePassword= !hidePassword;
                                });
                              },
                              color: Theme.of(context).primaryColor.withOpacity(0.4),
                             icon: Icon(hidePassword ?
                             Icons.visibility_off
                             : Icons.visibility),)
                          ),
                        ),
                        const SizedBox(height: 30,),
                        TextButton(
                    onPressed: (){
                      if(validateAndSave()){
                        setState(() {
                          isApiCallProcess = true;
                        });

                        apiService
                            .loginCustomer(username, password).then((ret) =>
                        {
                          if(ret != null){
                            print(ret.data.token),
                            print(ret.data.toJson()),
                            setState(() {
                              isApiCallProcess =false;
                            }),

                            FormHelper.showMessage(context,
                                "Woocommoerce App",
                                "Login Successfully",
                                "Ok",
                                    (){}
                            )
                          } else {
                            FormHelper.showMessage(context,
                                "Woocommoerce App",
                                "Invalid Login",
                                "Ok",
                                    (){}
                            )
                          }
                        });
                      }
                    },
                            child: const Text("Login", style: TextStyle(color: Colors.white)
                            ),
                        ), const SizedBox(height: 15,)
                      ],
                    ) ),
              ),
              ]
            )
          ],
        ),
      ),
    );
  }
  bool validateAndSave(){
    final form = globalKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }
}
