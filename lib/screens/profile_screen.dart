import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Move enum to top level
enum UserType { admin, user, none }

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  
  // Remove _isLoggedIn since we'll use FirebaseAuth state
  // bool _isLoggedIn = false;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  UserType _userType = UserType.none;

  @override
  void initState() {
    super.initState();
    // Check user type when screen initializes
    _checkUserType();
  }

  Future<void> _checkUserType() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Get user type from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _userType = userDoc.exists && userDoc.get('isAdmin') == true 
            ? UserType.admin 
            : UserType.user;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Update _handleSignIn method
  Future<void> _handleSignIn() async {
    setState(() => _isLoading = true);
    
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Get user type from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      setState(() {
        _userType = userDoc.exists && userDoc.get('isAdmin') == true 
            ? UserType.admin 
            : UserType.user;
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);
      String errorMessage = 'An error occurred';
      
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
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

  // Update _handleSignUp method
  Future<void> _handleSignUp(String fullName, String email, String password) async {
    setState(() => _isLoading = true);
    
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'isAdmin': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      setState(() {
        _userType = UserType.user;
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);
      String errorMessage = 'An error occurred';
      
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for this email';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
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

  // Add sign out method
  Future<void> _handleSignOut() async {
    await _auth.signOut();
    setState(() {
      _userType = UserType.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Use FirebaseAuth to check if user is logged in
    final user = _auth.currentUser;

    if (user == null) {
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
                          email: 'admin@admin.com',
                          isDark: isDark,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildUserTypeButton(
                          icon: Icons.person,
                          label: 'User',
                          email: 'user@user.com',
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
              ? 'admin123' 
              : 'user123';
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
    final TextEditingController _signUpEmailController = TextEditingController();
    final TextEditingController _signUpPasswordController = TextEditingController();
    final TextEditingController _signUpNameController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();
    
    // Add form key for validation
    final _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _signUpNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _signUpEmailController,
                      decoration: InputDecoration(
                        labelText: 'Email*',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _signUpPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password*',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        helperText: 'Minimum 6 characters',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password*',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _signUpPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _handleSignUp(
                                    _signUpNameController.text.trim(),
                                    _signUpEmailController.text.trim(),
                                    _signUpPasswordController.text,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Sign Up'),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '* Required fields',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileScreen(bool isDark) {
    final user = _auth.currentUser;
    
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('users').doc(user!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error loading profile'));
        }

        final userData = snapshot.data?.data() as Map<String, dynamic>?;
        final fullName = userData?['fullName'] ?? 'User';
        final email = userData?['email'] ?? user.email ?? '';
        final isAdmin = userData?['isAdmin'] ?? false;

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
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
                      colors: isAdmin
                          ? [Colors.blue.shade900, Colors.blue.shade800]
                          : [Colors.green.shade900, Colors.green.shade800],
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundColor: isAdmin
                              ? Colors.blue.shade100
                              : Colors.green.shade100,
                          child: Icon(
                            isAdmin ? Icons.admin_panel_settings : Icons.person,
                            size: 50,
                            color: isAdmin
                                ? Colors.blue.shade900
                                : Colors.green.shade900,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        fullName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              if (isAdmin) ...[
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
                  if (isAdmin)
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
                  if (isAdmin)
                    SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _handleSignOut,
                      icon: Icon(Icons.logout),
                      label: Text('Sign Out'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
      },
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