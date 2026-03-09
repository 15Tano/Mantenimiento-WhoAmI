// lib/src/ui/screens/register_password_page.dart
import 'package:flutter/material.dart';
import '../brand_logo.dart';
import '../theme.dart';
import 'register_role_page.dart';

class RegisterPasswordPage extends StatefulWidget {
  const RegisterPasswordPage({super.key});
  static const route = '/register/password';

  @override
  State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _pass2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscure1 = true;
  bool _obscure2 = true;

  int _passScore = 0;
  String _passLabel = 'Vacía';
  Color _passColor = Colors.grey;

  String? _emailRule(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Requerido';
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s);
    return ok ? null : 'Ingresa un correo válido';
  }

  String? _passRule(String? v) {
    final s = v ?? '';
    if (s.isEmpty) return 'Requerido';
    if (s.length < 8) return 'Debe tener mínimo 8 caracteres';
    if (!RegExp(r'[A-Z]').hasMatch(s)) return 'Debe incluir al menos una mayúscula';
    if (!RegExp(r'[a-z]').hasMatch(s)) return 'Debe incluir al menos una letra minúscula';
    if (!RegExp(r'[0-9]').hasMatch(s)) return 'Debe incluir al menos un número';
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(s)) {
      return 'Debe incluir al menos un símbolo o carácter especial';
    }
    return null;
  }

  void _updatePasswordStrength(String s) {
    final score = _passwordScore(s);
    setState(() {
      _passScore = score;
      _passLabel = _passwordLabel(score);
      _passColor = _passwordColor(score);
    });
  }

  int _passwordScore(String s) {
    if (s.isEmpty) return 0;
    int score = 0;
    if (RegExp(r'[A-Z]').hasMatch(s)) score++;
    if (RegExp(r'[a-z]').hasMatch(s)) score++;
    if (RegExp(r'[0-9]').hasMatch(s)) score++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(s)) score++;
    if (s.length >= 12) score++;
    return score;
  }

  String _passwordLabel(int score) {
    switch (score) {
      case 0:
        return 'Vacía';
      case 1:
        return 'Débil';
      case 2:
        return 'Media';
      case 3:
        return 'Fuerte';
      case 4:
        return 'Muy fuerte';
      case 5:
        return 'Excelente';
      default:
        return 'Vacía';
    }
  }

  Color _passwordColor(int score) {
    switch (score) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final prev = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kInk),
            onPressed: () => Navigator.maybePop(context),
          ),
          centerTitle: true,
          title: const Text(
            'Regístrate',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kInk,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      const Align(child: BrandLogo(size: 170)),
                      const SizedBox(height: 22),

                      const _FieldLabel('Correo electrónico'),
                      const SizedBox(height: 6),
                      _FieldBox(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: _emailRule,
                      ),

                      const SizedBox(height: 14),
                      const _FieldLabel('Crea una contraseña'),
                      const SizedBox(height: 6),
                      _FieldBox(
                        controller: _pass,
                        obscure: _obscure1,
                        textInputAction: TextInputAction.next,
                        validator: _passRule,
                        onChanged: _updatePasswordStrength,
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure1 = !_obscure1),
                          icon: Icon(_obscure1 ? Icons.visibility_off : Icons.visibility),
                          tooltip: _obscure1 ? 'Mostrar' : 'Ocultar',
                        ),
                      ),

                      const SizedBox(height: 10),
                      _PasswordStrengthBar(
                        score: _passScore,
                        color: _passColor,
                        label: _passLabel,
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        'Debe tener al menos 8 caracteres, incluir letras, una mayúscula, números y un símbolo.',
                        style: TextStyle(fontSize: 12, color: kGrey1),
                        textAlign: TextAlign.left,
                      ),

                      const SizedBox(height: 10),
                      const _FieldLabel('Confirmar contraseña'),
                      const SizedBox(height: 6),
                      _FieldBox(
                        controller: _pass2,
                        obscure: _obscure2,
                        textInputAction: TextInputAction.done,
                        validator: (v) {
                          if ((v ?? '').isEmpty) return 'Requerido';
                          if (v != _pass.text) return 'No coincide';
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure2 = !_obscure2),
                          icon: Icon(_obscure2 ? Icons.visibility_off : Icons.visibility),
                          tooltip: _obscure2 ? 'Mostrar' : 'Ocultar',
                        ),
                      ),

                      const SizedBox(height: 28),
                      Align(
                        child: SizedBox(
                          width: 296,
                          height: 56,
                          child: FilledButton(
                            style: pillBlue(),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              Navigator.pushNamed(
                                context,
                                RegisterRolePage.route,
                                arguments: {
                                  ...prev,
                                  'email': _email.text.trim().toLowerCase(),
                                  'password': _pass.text,
                                },
                              );
                            },
                            child: const Text('Siguiente'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kInk,
        ),
      );
}

class _FieldBox extends StatelessWidget {
  const _FieldBox({
    required this.controller,
    this.obscure = false,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final bool obscure;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autocorrect: false,
      enableSuggestions: !obscure,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: '',
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(fontSize: 16, color: kInk),
    );
  }
}

// ====== Barra de fuerza de contraseña ======
class _PasswordStrengthBar extends StatelessWidget {
  const _PasswordStrengthBar({
    required this.score,
    required this.color,
    required this.label,
  });

  final int score;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final value = (score.clamp(0, 5)) / 5.0;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: value == 0 ? 0.02 : value,
              minHeight: 10,
              backgroundColor: const Color(0xFFEAEAEA),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}
