// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/hive_services.dart';
import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';
import '../../data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  final LoginRepo loginRepo;

  //-------------------SignIn----------------------
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  var loginEmail = TextEditingController();
  var loginPassword = TextEditingController();
  bool signInTextObscure = false;
  static List<LoginModel> loginData = [];
  static bool firstLogin = true;
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  void changeSignInTextObscure() {
    signInTextObscure = !signInTextObscure;
    emit(ChangeLoginObscureText());
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(LoginLoading());
    var loginData = await loginRepo.signIn(
      email: loginEmail.text,
      password: loginPassword.text,
    );
    loginData.fold((l) {
      log("Error : ${l.errMessage}");
      emit(LoginFailure(error: l.errMessage));
    }, (r) {
      if (r.status) {
        loginEmail.clear();
        loginPassword.clear();
        emit(LoginSuccess(loginData: r));
        if (firstLogin) {
          addHiveLoginData(r);
        } else {
          updateHiveLoginData(r);
        }
      } else {
        emit(LoginWarning(loginData: r));
      }
    });
  }

  void signInOnPressed() {
    if (signInFormKey.currentState!.validate()) {
      signIn(email: loginEmail.text, password: loginPassword.text);
    } else {
      autoValidate = AutovalidateMode.always;
      emit(ChangeLoginAutoValidate());
    }
  }

  Future<void> autoSignIn() async {
    emit(AutoLoginLoading());
    HiveServices()
        .fetchHiveLoginData()
        .then((onValue) async {
          log("Token : ${onValue.first.data.token}");
          if (onValue.isEmpty) {
            emit(AutoLoginFailure(error: "error"));
          } else {
            var loginData = await loginRepo.signIn(
              email: onValue.first.data.email,
              password: onValue.first.data.password,
            );
            loginData.fold((l) => emit(AutoLoginFailure(error: l.errMessage)),
             (r) {
              if (r.status) {
                emit(AutoLoginSuccess(loginData: onValue.first));
              } else {
                emit(AutoLoginFailure(error: r.message));
              }
            });
          }
        })
        .catchError((onError) {
          emit(AutoLoginFailure(error: onError.toString()));
        });
  }

  Future<void> fetchHiveLoginData() async {
    emit(FetchHiveLoginDataLoading());
    var result = await loginRepo.fetchHiveLoginData();
    result.fold(
      (l) {
        emit(FetchHiveLoginDataFailure(error: l.errMessage));
      },
      (r) {
        emit(FetchHiveLoginDataSuccess(loginModel: r.first));
      },
    );
  }

  Future<void> addHiveLoginData(LoginModel model) async {
    emit(AddHiveLoginDataLoading());
    var result = await loginRepo.addHiveLoginData(model);
    result.fold(
      (l) {
        emit(AddHiveLoginDataFailure(error: l.errMessage.toString()));
      },
      (r) {
        emit(AddHiveLoginDataSuccess(loginModel: r.first));
        loginData.clear();
        loginData.add(model);
        fetchHiveLoginData();
      },
    );
  }

  updateHiveLoginData(LoginModel model) async {
    emit(UpdateHiveLoginDataLoading());
    var result = await loginRepo.updateHiveLoginData(model);
    result.fold(
      (l) {
        emit(UpdateHiveLoginDataFailure(error: l.errMessage.toString()));
      },
      (r) {
        emit(UpdateHiveLoginDataSuccess(loginModel: r.first));
        loginData.clear();
        loginData.add(model);
        fetchHiveLoginData();
      },
    );
  }

  //-------------------Register----------------------
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  var registerUserName = TextEditingController();
  var registerEmail = TextEditingController();
  var registerPhone = TextEditingController();
  var registerPassword = TextEditingController();
  String registerImage =
      "data:image/png;base64,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";
  bool registerTextObscure = false;
  AutovalidateMode registerAutoValidate = AutovalidateMode.disabled;
  void changeRegisterTextObscure() {
    registerTextObscure = !registerTextObscure;
    emit(ChangeRegisterObscureText());
  }

  Future<void> register({
    required String userName,
    required String email,
    required String password,
    required String phone,
  }) async {
    var loginData = await loginRepo.register(
      email: email,
      password: password,
      userName: userName,
      phone: phone,
      image: registerImage,
    );
    loginData.fold(
      (l) {
        log("Register Failure : ${l.errMessage.toString()}");
        emit(RegisterFailure(error: l.errMessage));
      },
      (r) {
        if (r.status) {
          registerUserName.clear();
          registerPhone.clear();
          registerEmail.clear();
          registerPassword.clear();
          emit(RegisterSuccess(model: r));
        } else {
          emit(RegisterWarning(model: r));
        }
      },
    );
  }

  void registerOnPressed() {
    if (registerFormKey.currentState!.validate()) {
      register(
        email: registerEmail.text,
        password: registerPassword.text,
        userName: registerUserName.text,
        phone: registerPhone.text,
      );
    } else {
      autoValidate = AutovalidateMode.always;
      emit(ChangeRegisterAutoValidate());
    }
  }

  //-------------------Forget Password----------------------
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  var forgetPasswordEmail = TextEditingController();
  AutovalidateMode forgetPasswordAutoValidate = AutovalidateMode.disabled;
}
