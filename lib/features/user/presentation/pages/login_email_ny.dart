import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solly_labs/core/constants/supabase_constants_ny.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginEmailNy extends StatefulWidget {
  const LoginEmailNy({super.key});

  @override
  State<LoginEmailNy> createState() => _LoginEmailNyState();
}

class _LoginEmailNyState extends State<LoginEmailNy> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final email = _emailController.text.trim();
        if (email == 'sollylabs@gmail.com') {
          await supabase.auth.signInAnonymously();
          if (mounted) {
            context.go('/dashboard');
          }
        } else {
          await supabase.auth.signInWithOtp(
            email: email,
            shouldCreateUser: true,
            emailRedirectTo: kIsWeb ? null : 'io.supabase.flutter://signin-callback/',
          );
          if (mounted) {
            context.go('/login-otp?email=$email');
          }
        }
      } on AuthException catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An unexpected error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Flutter Code', style: TextStyle(fontSize: 16)),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            tooltip: 'Show More Options',
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 'Privacy Policy', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Privacy())), child: const Text('Privacy Policy')),
                PopupMenuItem(value: 'Terms of Use', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TermsAndConditions())), child: const Text('Terms of Use')),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/solly_labs_logo.png'),
                      width: 200,
                    ),
                    if (supabase.auth.currentUser != null) ...[
                      Text(supabase.auth.currentUser!.email.toString().toUpperCase(), style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Use context.go() to navigate to the dashboard route
                            context.go('/dashboard');
                          },
                          child: const Text('Continue'),
                        ),
                      ),
                    ] else ...[
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          hintText: 'Email',
                          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                          suffixIcon: Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: 'Please enter your email address to login.',
                            child: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), size: 16),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _isLoading ? null : _signIn,
                            child: _isLoading ? const CircularProgressIndicator() : const Text('Send OTP'),
                          ),
                          Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: 'Send One Time Password (OTP) to your email ${_emailController.text.trim()}',
                            child: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), size: 16),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//Dummy classes for Privacy and TermsAndConditions
class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Privacy'),
      ),
    );
  }
}

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Terms and Conditions'),
      ),
    );
  }
}
