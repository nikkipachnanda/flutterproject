import 'package:flutter/material.dart';
import '../theme/app_theme.dart'; // theme tokens (kPrimary, kRadius, etc.)

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _projects = ['Select Project', 'Project A', 'Project B', 'Project C'];
  String _selectedProject = 'Select Project';
  bool _remember = false;
  bool _obscure = true;
  String? _username;
  String? _password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final borderColor = theme.dividerColor;
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),

                  SizedBox(
                    height: 110,
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) =>
                          Icon(Icons.business, size: 84, color: kPrimary.withOpacity(0.28)),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text('Log in', style: textTheme.headlineLarge),

                  const SizedBox(height: 20),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: _showProjectPicker,
                          borderRadius: BorderRadius.circular(kRadius),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(kRadius),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                const Icon(Icons.work_outline, color: kPrimary),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _selectedProject,
                                    style: TextStyle(
                                      color: _selectedProject == 'Select Project'
                                          ? Colors.grey
                                          : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          onSaved: (v) => _username = v,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Please enter username';
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'User Name',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          onSaved: (v) => _password = v,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Please enter password';
                            return null;
                          },
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Checkbox(
                              value: _remember,
                              onChanged: (v) => setState(() => _remember = v ?? false),
                            ),
                            const SizedBox(width: 6),
                            Text('Remember me', style: textTheme.bodyMedium),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Use named route to go to /home
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _onLoginPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadius)),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              elevation: 0,
                            ),
                            child: const Text('Login'),
                          ),
                        ),

                        const SizedBox(height: 28),

                        Column(
                          children: [
                            Text('An Innovation For You', style: textTheme.bodySmall),
                            const SizedBox(height: 6),
                            Text(
                              'App Version: 1.1.5',
                              style: textTheme.titleMedium?.copyWith(color: kPrimary, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),
                      ],
                    ),
                  ),

                  SizedBox(height: media.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // navigate to home route and replace login route
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _showProjectPicker() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(height: 6, width: 60, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4))),
              const SizedBox(height: 12),
              Text('Select Project', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Divider(height: 1, color: Theme.of(context).dividerColor),
              ..._projects.map((p) {
                return ListTile(
                  leading: const Icon(Icons.business_outlined, color: kPrimary),
                  title: Text(p, style: Theme.of(context).textTheme.bodyMedium),
                  onTap: () {
                    setState(() => _selectedProject = p);
                    Navigator.of(ctx).pop();
                  },
                );
              }).toList(),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
