import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../model/response_message_model/response_message_model.dart';
import '../model/sign_in_with_apple_model/sign_in_with_apple_model.dart';
import '../model/sign_up_with_mail_model/sign_up_with_mail_model.dart';
import 'package:vexana/vexana.dart';

import '../../../../core/base/state/service_helper.dart';
import '../model/sign_in_response_model/sign_in_response_model.dart';
import '../model/sign_in_with_google_model/sign_in_with_google_model.dart';
import 'IAccountpageService.dart';

class AccountpageService extends IAccountpageService with ServiceHelper {
  AccountpageService(super.manager,
      super.scaffoldMessengerKey);

  @override
  Future<SignInResponseModel?> signInWithGoogle(
      SignInWithGoogleModel signInWithGoogleModel) async {
    final response =
        await manager.send<SignInResponseModel, SignInResponseModel>(
      "/user/signin",
      parseModel: SignInResponseModel(),
      method: RequestType.POST,
      data: signInWithGoogleModel,
    );

    if (response.data is SignInResponseModel) {
      return response.data;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<SignInResponseModel?> signUpWithMail(
      SignUpWithMailModel signUpWithMailModel) async {
    final response =
        await manager.send<SignInResponseModel, SignInResponseModel>(
      "/user/signup",
      parseModel: SignInResponseModel(),
      method: RequestType.POST,
      data: signUpWithMailModel,
    );

    if (response.error?.statusCode == 401) {
      return SignInResponseModel(id: "already exists");
    } else if (response.data is SignInResponseModel) {
      return response.data;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<SignInResponseModel?> signInWithMail(
      SignUpWithMailModel signUpWithMailModel) async {
    final response =
        await manager.send<SignInResponseModel, SignInResponseModel>(
      "/user/signin",
      parseModel: SignInResponseModel(),
      method: RequestType.POST,
      data: signUpWithMailModel,
    );
    if (response.error?.statusCode == 401) {
      return SignInResponseModel(id: "incorrect");
    } else if (response.data is SignInResponseModel) {
      return response.data;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<bool?> deleteUser() async {
    final response =
        await manager.send<ResponseMessageModel, ResponseMessageModel>("/user",
            parseModel: ResponseMessageModel(),
            method: RequestType.DELETE,
            options: Options(
              headers: {
                "Content-Type": "application/json",
                'Authorization':
                    'Bearer ${LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN)}'
              },
            ));
    if (response.data is ResponseMessageModel) {
      return true;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return false;
    } else {
      return false;
    }
  }

  @override
  Future<SignInResponseModel?> signInWithApple(
      SignInWithAppleModel signInWithAppleModel) async {
    final response =
        await manager.send<SignInResponseModel, SignInResponseModel>(
      "/user/signin/apple",
      parseModel: SignInResponseModel(),
      method: RequestType.POST,
      data: signInWithAppleModel,
    );

    if (response.data is SignInResponseModel) {
      return response.data;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return null;
    } else {
      return null;
    }
  }
}
