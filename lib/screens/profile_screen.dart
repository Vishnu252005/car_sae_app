import 'package:flutter/material.dart';

// Move enum to top level
enum UserType { admin, user, none }

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = false;
  
  // Add controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Update state variable
  UserType _userType = UserType.none;
  final String _adminEmail = 'admin@admin.com';
  final String _adminPassword = 'admin123';
  final String _userEmail = 'user@user.com';
  final String _userPassword = 'user123';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Add sign in validation
  void _handleSignIn() {
    if (_emailController.text == _adminEmail && 
        _passwordController.text == _adminPassword) {
      setState(() {
        _isLoggedIn = true;
        _userType = UserType.admin;
      });
    } else if (_emailController.text == _userEmail && 
               _passwordController.text == _userPassword) {
      setState(() {
        _isLoggedIn = true;
        _userType = UserType.user;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials.\nAdmin: admin@admin.com / admin123\nUser: user@user.com / user123'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_isLoggedIn) {
      return _buildAuthScreen(isDark);
    }

    return _buildProfileScreen(isDark);
  }

  Widget _buildAuthScreen(bool isDark) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Sign In'),
              Tab(text: 'Sign Up'),
            ],
            indicatorColor: Colors.blue.shade700,
            labelColor: isDark ? Colors.white : Colors.blue.shade900,
          ),
        ),
        body: TabBarView(
          children: [
            _buildSignInForm(isDark),
            _buildSignUpForm(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInForm(bool isDark) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // User Type Selection
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select User Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildUserTypeButton(
                          icon: Icons.admin_panel_settings,
                          label: 'Admin',
                          email: _adminEmail,
                          isDark: isDark,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildUserTypeButton(
                          icon: Icons.person,
                          label: 'User',
                          email: _userEmail,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          // Login Form
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleSignIn,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue.shade700,
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTypeButton({
    required IconData icon,
    required String label,
    required String email,
    required bool isDark,
  }) {
    final isSelected = _emailController.text == email;

    return InkWell(
      onTap: () {
        setState(() {
          _emailController.text = email;
          _passwordController.text = label.toLowerCase() == 'admin' 
              ? _adminPassword 
              : _userPassword;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? Colors.blue.shade900 : Colors.blue.shade50)
              : (isDark ? Colors.grey[800] : Colors.grey[100]),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue.shade700 : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? Colors.blue.shade700
                  : (isDark ? Colors.grey[400] : Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.blue.shade700
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm(bool isDark) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoggedIn = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileScreen(bool isDark) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Header Card with user type indicator
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _userType == UserType.admin
                      ? (isDark 
                          ? [Colors.blue.shade900, Colors.blue.shade800]
                          : [Colors.blue.shade400, Colors.blue.shade600])
                      : (isDark
                          ? [Colors.green.shade900, Colors.green.shade800]
                          : [Colors.green.shade400, Colors.green.shade600]),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundColor: _userType == UserType.admin
                              ? Colors.blue.shade100
                              : Colors.green.shade100,
                          child: Icon(
                            _userType == UserType.admin 
                                ? Icons.admin_panel_settings
                                : Icons.person,
                            size: 50,
                            color: _userType == UserType.admin
                                ? Colors.blue.shade900
                                : Colors.green.shade900,
                          ),
                        ),
                      ),
                      if (_userType == UserType.admin)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    _userType == UserType.admin ? 'Admin User' : 'Regular User',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _userType == UserType.admin ? _adminEmail : _userEmail,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          if (_userType == UserType.admin) ...[
            // Admin-specific cards
            _buildAdminDashboard(isDark),
            SizedBox(height: 20),
            _buildEventManagement(isDark),
          ] else ...[
            // User-specific cards
            _buildUserScorecard(isDark),
            SizedBox(height: 20),
            _buildUserEvents(isDark),
          ],

          // Common cards but with role-specific content
          _buildPersonalInfo(isDark),
          SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              if (_userType == UserType.admin)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle settings
                    },
                    icon: Icon(Icons.settings),
                    label: Text('Settings'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              if (_userType == UserType.admin)
                SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isLoggedIn = false;
                      _userType = UserType.none;
                    });
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Sign Out'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Admin-specific widgets
  Widget _buildAdminDashboard(bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Dashboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.blue.shade900,
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.event,
                  label: 'Events',
                  value: '12',
                  isDark: isDark,
                ),
                _buildStatItem(
                  icon: Icons.groups,
                  label: 'Teams',
                  value: '48',
                  isDark: isDark,
                ),
                _buildStatItem(
                  icon: Icons.score,
                  label: 'Scores',
                  value: '144',
                  isDark: isDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventManagement(bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Management',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.blue.shade900,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle, color: Colors.green),
              title: Text('Create New Event'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.blue),
              title: Text('Manage Teams'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.assessment, color: Colors.orange),
              title: Text('Scoring Criteria'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  // User-specific widgets
  Widget _buildUserScorecard(bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Scorecard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.green.shade900,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.emoji_events, color: Colors.amber),
              title: Text('Current Event'),
              subtitle: Text('Dance Competition 2024'),
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.orange),
              title: Text('Your Score'),
              subtitle: Text('85/100'),
            ),
            ListTile(
              leading: Icon(Icons.leaderboard, color: Colors.blue),
              title: Text('Ranking'),
              subtitle: Text('3rd Place'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserEvents(bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.green.shade900,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.event_available, color: Colors.green),
              title: Text('Upcoming Event'),
              subtitle: Text('Singing Competition - Next Week'),
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.grey),
              title: Text('Past Event'),
              subtitle: Text('Dance Competition - Last Month'),
              trailing: Text('2nd Place', style: TextStyle(color: Colors.orange)),
            ),
          ],
        ),
      ),
    );
  }

  // Common widget with role-specific content
  Widget _buildPersonalInfo(bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : 
                  (_userType == UserType.admin ? Colors.blue.shade900 : Colors.green.shade900),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.badge,
                color: _userType == UserType.admin ? Colors.blue : Colors.green,
              ),
              title: Text('Role'),
              subtitle: Text(_userType == UserType.admin ? 'Event Administrator' : 'Participant'),
              trailing: _userType == UserType.admin 
                  ? Icon(Icons.verified, color: Colors.green)
                  : null,
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: _userType == UserType.admin ? Colors.blue : Colors.green,
              ),
              title: Text('Contact'),
              subtitle: Text('+1 234 567 8900'),
            ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: _userType == UserType.admin ? Colors.blue : Colors.green,
              ),
              title: Text('Location'),
              subtitle: Text('Manila, Philippines'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark 
              ? Colors.blue.shade900.withOpacity(0.2)
              : Colors.blue.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isDark ? Colors.blue.shade200 : Colors.blue.shade900,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.blue.shade900,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
} 