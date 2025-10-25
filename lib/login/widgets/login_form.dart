part of 'login_body.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> loginFormKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function() fnOnPressButton;

  const LoginForm({
    super.key,
    required this.loginFormKey,
    required this.emailController,
    required this.passwordController,
    required this.fnOnPressButton,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginFormKey,
      child: Column(
        spacing: 16.0,
        children: <Widget>[
          TextFormField(
            textCapitalization: TextCapitalization.none,
            controller: widget.emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Ingresa tu correo electrónico',
              prefixIcon: Icon(Icons.person),
            ),
            validator: emailValidator,
          ),
          TextFormField(
            obscureText: _isObscureText,
            controller: widget.passwordController,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Ingresa tu contraseña',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _isObscureText = !_isObscureText);
                },
                icon: Icon(
                  _isObscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            validator: emptyFieldValidator,
          ),
          ElevatedButton(
            onPressed: widget.fnOnPressButton,
            child: Text('Iniciar Sesión'),
          ),
        ],
      ),
    );
  }
}
