import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseUrl = dotenv.env['SUPABASE_URL'];
final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

final supabase = Supabase.instance.client;
