import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/supabase_constants_ny.dart';

class LoginOtpNy extends StatefulWidget {
  const LoginOtpNy({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<LoginOtpNy> createState() => _LoginOtpNyState();
}

class _LoginOtpNyState extends State<LoginOtpNy> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await supabase.auth.verifyOTP(
          email: widget.email,
          token: _otpController.text.trim(),
          type: OtpType.magiclink,
        );

        if (mounted) {
          final session = supabase.auth.currentSession;
          if (session != null) {
            final profileExists = await supabase.from('profiles').select().eq('id', supabase.auth.currentUser!.id).maybeSingle();

            if (profileExists == null && mounted) {
              await supabase.from('profiles').insert({'id': supabase.auth.currentUser!.id, 'email': widget.email});
              await supabase.from('public_profile').insert({'private_profile_id': supabase.auth.currentUser!.id});
            }

            if (mounted) context.go('/dashboard');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid OTP')));
          }
        }
      } on AuthException catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message), backgroundColor: Colors.red),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An unexpected error occurred'), backgroundColor: Colors.red),
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
        title: Text(
          widget.email.toUpperCase(),
          style: const TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Check your email for a login OTP!', style: Theme.of(context).textTheme.bodySmall),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        controller: _otpController,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the OTP';
                          }
                          if (value.length != 6) {
                            return 'OTP must be 6 digits';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)), gapPadding: 8.0, borderSide: BorderSide(color: Colors.black)),
                          filled: false,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(8.0),
                          counterText: '', // Hides the counter text
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _verifyOTP,
                        child: _isLoading ? const CircularProgressIndicator() : const Text('Login'),
                      ),
                    ),
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
