import 'dart:async';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:verve/syndic/pr%C3%A9sentaion/list_reclamation_syndic.dart';

import '../../domain/frezzed_data_class.dart';
import '../services.dart';

class LoginViewModel implements LoginViewModelInputs, LoginViewModelOutput {
  StreamController loginStreamController = StreamController.broadcast();
  StreamController passwordStreamController = StreamController.broadcast();
  StreamController allStreamController = StreamController.broadcast();

  final StreamController isUserLoggedInSeccessFullystreamController =
      StreamController<bool>();

  final StreamController isSyndicLoggedInSeccessFullystreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");

  @override
  Sink get inputAllState => allStreamController.sink;

  @override
  Sink get inputLoginState => loginStreamController.sink;

  @override
  Sink get inputPasswordState => passwordStreamController.sink;

  @override
  login() {
    isUserLoggedInSeccessFullystreamController.add(true);
  }

  @override
  setLogin(String login) {
    inputLoginState.add(login);
    if (_isLoginValid(login)) {
      //  update register view object
      loginObject = loginObject.copyWith(username: login);
    } else {
      // reset username value in register view object
      loginObject = loginObject.copyWith(username: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPasswordState.add(password);
    if (_isPasswordValid(password)) {
      loginObject = loginObject.copyWith(password: password);
    } else {
      loginObject = loginObject.copyWith(password: "");
    }
    validate();
  }

  bool _isLoginValid(String login) {
    return login.length >= 3;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 3;
  }

  @override
  Stream<String?> get outputErrorLogin =>
      outputLogin.map((login) => login ? null : "Login is Invalid");

  @override
  Stream<String?> get outputErrorPassword =>
      outputPassword.map((password) => password ? null : "Password is Invalid");

  @override
  Stream<bool> get outputLogin =>
      loginStreamController.stream.map((login) => _isLoginValid(login));

  @override
  Stream<bool> get outputPassword => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  validate() {
    inputAllState.add(null);
  }

  @override
  // TODO: implement outputAreAllInputsValid
  Stream<bool> get outputAreAllInputsValid =>
      allStreamController.stream.map((_) => areAllValid());

  bool areAllValid() {
    return loginObject.password.isNotEmpty && loginObject.username.isNotEmpty;
  }

  @override
  dispose() {
    loginStreamController.close();
    passwordStreamController.close();
    allStreamController.close();
  }

  @override
  loginSyndic() {
    isSyndicLoggedInSeccessFullystreamController.add(true);
  }
}

abstract class LoginViewModelInputs {
  dispose();

  Sink get inputLoginState;

  Sink get inputPasswordState;

  Sink get inputAllState;

  setLogin(String login);

  setPassword(String password);

  login();

  loginSyndic();
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputLogin;

  Stream<String?> get outputErrorLogin;

  Stream<bool> get outputPassword;

  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputAreAllInputsValid;
}
