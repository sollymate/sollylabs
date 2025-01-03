import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solly_labs/core/constants/supabase_constants_ny.dart';

class SplashScreenNy extends ConsumerStatefulWidget {
  const SplashScreenNy({super.key});

  @override
  ConsumerState<SplashScreenNy> createState() => _SplashScreenNyState();
}

class _SplashScreenNyState extends ConsumerState<SplashScreenNy> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final int _animationDuration = 2;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _animationDuration),
      lowerBound: 0.5,
      upperBound: 1.0,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _initializeDataAndNavigate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/images/solly_labs_logo.png'), width: 200),
            const Text('Loading Project Data ...', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w100, color: Colors.white)),
            SizedBox(
              width: 400,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return LinearProgressIndicator(value: _animation.value, color: Colors.white);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeDataAndNavigate() async {
    _animationController.forward();
    if (supabase.auth.currentUser != null) {
      await _initializeData();
    }

    await Future.delayed(Duration(seconds: _animationDuration));

    if (!mounted) return;

    final user = supabase.auth.currentUser;
    if (user != null) {
      context.go('/dashboard');
    } else {
      context.go('/login');
    }
  }

  Future<void> _initializeData() async {
    if (!mounted) return;

    try {
      // Get the user's ID.
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in.');
      }

      // Fetch the most recently modified artboard for the current user.
      final tempArtBoardList = await supabase.from('art_board_list').select().eq('created_by', userId).order('last_modified_at', ascending: false).limit(1);

      if (!mounted) return;

      if (tempArtBoardList.isNotEmpty) {
        final tempActiveArtBoard = tempArtBoardList.first;
        final projectId = tempActiveArtBoard['project_id'] as String?;

        if (projectId != null && projectId.isNotEmpty) {
          // Fetch the project using the project ID.
          final tempProjectList = await supabase.from('project_list').select().eq('id', projectId).limit(1);

          // Fetch the widgets based on the artboard ID.
          final tempWidgetList = await supabase.from('widget_list').select().eq('art_board_id', tempActiveArtBoard['id']);

          if (!mounted) return;

          if (tempProjectList.isNotEmpty) {
            // Update the providers with the fetched data using ref.read.
            final tempActiveProject = tempProjectList.first;
            if (!mounted) return;

            // ref.read(projectProviderNy.notifier).setActiveProject(tempActiveProject);
            // ref.read(artBoardProviderNy.notifier).setActiveArtBoard(tempActiveArtBoard);
            // ref.read(widgetProviderNy.notifier).setWidgetList(tempWidgetList);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) print("Error initializing data: $e");
    }
  }
}
