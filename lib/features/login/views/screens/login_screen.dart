import 'package:boilerplate/core/extensions/image_path.dart';
import 'package:boilerplate/core/routes/routes.dart';
import 'package:boilerplate/shared/utils/dimensions.dart';
import 'package:boilerplate/shared/utils/styles.dart';
import 'package:boilerplate/shared/widgets/custom_button.dart';
import 'package:boilerplate/shared/widgets/custom_image.dart';
import 'package:boilerplate/shared/widgets/custom_snackbar.dart';
import 'package:boilerplate/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate/features/login/controllers/login_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loginState = ref.read(loginProvider);
      emailController.text = loginState.email;
      passwordController.text = loginState.password;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        // Top Images
                        CustomImage(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          imagePath: Images.bubbleImage,
                        ),
                        Stack(
                          children: [
                            CustomImage(
                              fit: BoxFit.fitWidth,
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              imagePath: Images.bubble1Image,
                            ),
                            Positioned(
                              bottom: -40,
                              left: -5,
                              right: -5,
                              child: CustomImage(
                                width: MediaQuery.of(context).size.width,
                                height: 132,
                                imagePath: Images.barImage,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                        // Login Form
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldWithLabel(
                                  label: 'Email',
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  nextFocusNode: passwordFocusNode,
                                  inputType: TextInputType.emailAddress,
                                  validator: (value) =>
                                      value!.isEmpty ? 'Please enter your email' : null,
                                ),
                                const SizedBox(height: Dimensions.paddingSizeDefault),
                                TextFieldWithLabel(
                                  label: 'Password',
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  isPassword: true,
                                  validator: (value) =>
                                      value!.isEmpty ? 'Please enter your password' : null,
                                ),
                                const SizedBox(height: Dimensions.paddingSizeSmall),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: loginState.rememberMe,
                                      onChanged: (value) {
                                        loginNotifier.setRememberMe(value!);
                                      },
                                    ),
                                    Text('Remember me'),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.paddingSizeLarge),
                                CustomButtonWidget(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      final email = emailController.text.trim();
                                      final password = passwordController.text.trim();
                                      final response = await loginNotifier.login(email, password);
                                      if (response.isSuccess) {
                                        if(mounted) {
                                          showCustomSnackbar(
                                            context: context, message: response.message);
                                        }
                                        GoRouter.of(context).go(Routes.newsfeed);
                                      } else {

                                        showCustomSnackbar(
                                            context: context,
                            
                                            message: response.message,
                                            isError: true);
                                      }
                                    }
                                  },
                                  isLoading: loginState.isLoading,
                                  textColor: Theme.of(context).textTheme.bodyLarge!.color,
                                  buttonText: 'Login',
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 100,
                      left: 50,
                      right: 50,
                      child: CustomImage(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 132,
                        imagePath: Images.nameTitleImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;

  const TextFieldWithLabel({
    required this.label,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.inputType,
    this.isPassword = false,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: fontMedium.copyWith(fontSize: 16, color: Theme.of(context).highlightColor)),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        CustomTextFieldWidget(
          controller: controller,
          focusNode: focusNode,
          nextFocus: nextFocusNode,
          inputType: inputType ?? TextInputType.text,
          isPassword: isPassword,
          validator: validator,
          hintText: 'Enter your $label',
        ),
      ],
    );
  }
}
