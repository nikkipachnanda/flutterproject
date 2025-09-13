import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // ensure flutter_svg is in pubspec.yaml
import '../theme/app_theme.dart'; // theme tokens (kPrimary, kRadius, etc.)
import 'home_page.dart' as home_page; // import with prefix to avoid symbol conflicts

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  final List<String> _projects = ['Select Project', 'Project A', 'Project B', 'Project C'];
  String _selectedProject = 'Select Project';
  bool _remember = false;
  bool _obscure = true;
  String? _username;
  String? _password;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _username = _usernameController.text;

      // Navigate to HomePage and replace the current route so user can't go back to login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const home_page.HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final borderColor = theme.dividerColor;
    final media = MediaQuery.of(context).size;

    // Common InputDecoration settings helper
    OutlineInputBorder _outline(double radius) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadius),
          borderSide: BorderSide(color: borderColor),
        );

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

                  // Top logo (SVG)
                  SizedBox(
                    height: 70,
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      fit: BoxFit.contain,
                      semanticsLabel: 'App Logo',
                      placeholderBuilder: (context) => Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Icon(Icons.business, size: 84, color: kPrimary.withOpacity(0.28)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Param card (reduced logo size)
                  _buildBrandCard(context),

                  // increased gap above "Log in"
                  const SizedBox(height: 38),

                  Text('Log in', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 26)),

                  const SizedBox(height: 20),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),

                        // Username with SVG icon + refresh suffix (smaller icon area)
                        TextFormField(
                          controller: _usernameController,
                          onSaved: (v) => _username = _usernameController.text,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Please enter username';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/user.svg',
                                    width: 18,
                                    height: 18,
                                    fit: BoxFit.scaleDown,
                                    placeholderBuilder: (ctx) => const SizedBox(width: 18, height: 18),
                                  ),
                                ),
                              ),
                            ),
                            suffixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            suffixIcon: IconButton(
                              splashRadius: 20,
                              padding: const EdgeInsets.only(right: 8.0),
                              onPressed: () {
                                _usernameController.clear();
                                setState(() => _username = null);
                              },
                              icon: SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset(
                                  'assets/images/refresh.svg',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.scaleDown,
                                  placeholderBuilder: (ctx) => const Icon(Icons.refresh, size: 20),
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: _outline(kRadius),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius),
                              borderSide: BorderSide(color: kPrimary),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Password (SVG lock icon) with smaller icon area
                        TextFormField(
                          onSaved: (v) => _password = v,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Please enter password';
                            return null;
                          },
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/lock.svg',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.scaleDown,
                                    placeholderBuilder: (ctx) => const SizedBox(width: 20, height: 20),
                                  ),
                                ),
                              ),
                            ),
                            suffixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: _outline(kRadius),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius),
                              borderSide: BorderSide(color: kPrimary),
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

                        // Login button
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

  Widget _buildBrandCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      // increased vertical padding for more top & bottom space
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // reduced logo container and icon size
          Container(
            height: 36, // reduced from 46
            width: 36, // reduced from 46
            decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/home.svg',
                width: 16, // reduced from 22
                height: 16, // reduced from 22
                fit: BoxFit.scaleDown,
                placeholderBuilder: (ctx) => Icon(Icons.home, color: Colors.white, size: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // added margin-top before the Param title
                const SizedBox(height: 6),
                Text('Param', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kPrimary)),
                const SizedBox(height: 4),
                Text('Quality Excellence Portal', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                Container(height: 3, width: 86, decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(4))),
              ],
            ),
          ),
        ],
      ),
    );
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
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'assets/images/business.svg',
                      width: 22,
                      height: 22,
                      fit: BoxFit.scaleDown,
                      placeholderBuilder: (ctx) => const Icon(Icons.business_outlined),
                    ),
                  ),
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
