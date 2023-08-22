
import 'package:flutter/material.dart';
import 'package:solanki/api_service.dart';
import 'package:solanki/models/customer.dart';
import 'package:solanki/utils/ProgressHUD.dart';
import 'package:solanki/utils/form_helper.dart';
import 'package:solanki/utils/validator_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late APIService apiService;
  late CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService =  APIService();
    model =  CustomerModel(firstName: '',
        email: '',
        lastName: '',
        password: ''
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          automaticallyImplyLeading: true,
          title: const Text("Sign Up"),
        ),
        body: ProgressHUD(
          child: new Form(
            key: globalKey,
            child:  _formUI(),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
        ));
  }

  Widget _formUI() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormHelper.fieldLabel("First Name"),
                          FormHelper.textInput(
                              context,
                              model.firstName,
                                  (value) {
                                setState(() {
                                  model.firstName = value;
                                });
                              },
                              onValidate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter First Name. ';
                            }
                            return null;
                          }),

                          FormHelper.fieldLabel("Last Name"),
                          FormHelper.textInput(
                              context,
                              model.lastName,
                                  (value) {
                                setState(() {
                                  model.lastName = value;
                                });
                              },
                              onValidate: (value) {
                                if (value.toString().isEmpty) {
                                  return 'Please enter last Name. ';
                                }
                                return null;
                              }),

                          FormHelper.fieldLabel("Email Id"),
                          FormHelper.textInput(
                              context,
                              model.email,
                                  (value) {
                                  setState((){
                                model.email = value;
                                  });
                                  },
                                onValidate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter Email Id. ';
                            }
                            if (value.isNotEmpty &&
                                !value.toString().isValidEmail()) {
                              return 'Please enter valid Email Id. ';
                            }
                            return null;
                          }),
                          FormHelper.fieldLabel("Password"),
                          FormHelper.textInput(
                              context,
                              model.password ,
                                  (value) {
                                 setState((){
                                model.password = value;
                                 });
                                  },
                              obscureText: hidePassword,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                  icon: Icon(
                                    hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  )), onValidate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter Password ';
                            }
                            return null;
                          }),
                          SizedBox(
                            height: 20,
                          ),

                          Center(
                            child: FormHelper.saveButton(
                                "Register",
                                    () {
                              if (validateAndSave()) {
                                print(model.toJson());
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                apiService.createCustomer(model).then(
                                        (ret) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  if (ret) {
                                    FormHelper.showMessage(
                                        context,
                                        'WooCommerce App',
                                        'Registration Successful',
                                        'Ok', () {
                                      Navigator.of(context).pop();
                                    });
                                  } else {
                                    FormHelper.showMessage(
                                        context,
                                        'WooCommerce App',
                                        'Registration Successful',
                                        'ok',
                                            () {
                                      Navigator.of(context).pop();
                                    });
                                  }
                                },);
                              }
                            },),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
