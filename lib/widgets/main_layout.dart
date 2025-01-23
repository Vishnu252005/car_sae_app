import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/results_screen.dart';
import '../screens/statistics_screen.dart';
import '../models/team.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../screens/event_screen.dart';
import '../screens/profile_screen.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  bool _isScrolled = false;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    final List<Widget> _screens = [
      HomeScreen(isScrolled: _isScrolled),
      ResultsScreen(),
      StatisticsScreen(),
      EventScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Scoring'),
        actions: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return RotationTransition(
                turns: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: IconButton(
              key: ValueKey<bool>(isDark),
              icon: Icon(
                isDark ? Icons.wb_sunny : Icons.nightlight_round,
                color: isDark ? Colors.amber : Colors.white,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            setState(() {
              _isScrolled = scrollNotification.metrics.pixels > 0;
            });
          }
          return true;
        },
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isDark 
                ? Colors.black.withOpacity(0.3) 
                : Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_note_rounded),
                activeIcon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark 
                      ? Colors.blue.shade900.withOpacity(0.2) 
                      : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.edit_note_rounded),
                ),
                label: 'Input',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard_rounded),
                activeIcon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark 
                      ? Colors.blue.shade900.withOpacity(0.2) 
                      : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.leaderboard_rounded),
                ),
                label: 'Results',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_rounded),
                activeIcon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark 
                      ? Colors.blue.shade900.withOpacity(0.2) 
                      : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.analytics_rounded),
                ),
                label: 'Statistics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_rounded),
                activeIcon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark 
                      ? Colors.blue.shade900.withOpacity(0.2) 
                      : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.event_rounded),
                ),
                label: 'Event',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                activeIcon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark 
                      ? Colors.blue.shade900.withOpacity(0.2) 
                      : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.person_rounded),
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
} 