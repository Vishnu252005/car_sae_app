import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_event_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool _isSignIn = true; // Track whether we're showing sign in or sign up
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = _auth.currentUser;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: user != null
            ? _buildUserProfile(user, isDark)
            : _buildAuthForm(isDark),
      ),
    );
  }

  Widget _buildAuthForm(bool isDark) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 40),
          Icon(
            Icons.account_circle,
            size: 80,
            color: isDark ? Colors.white70 : Colors.blue.shade700,
          ),
          SizedBox(height: 24),
                  Text(
            _isSignIn ? 'Sign In' : 'Sign Up',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.blue.shade900,
                    ),
            textAlign: TextAlign.center,
                  ),
          SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
              fillColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(_isSignIn ? 'Sign In' : 'Sign Up'),
                  ),
                  SizedBox(height: 16),
          TextButton(
                    onPressed: () {
                      setState(() {
                _isSignIn = !_isSignIn;
                _formKey.currentState?.reset();
                _emailController.clear();
                _passwordController.clear();
                      });
                    },
            child: Text(
              _isSignIn 
                  ? 'Don\'t have an account? Sign Up'
                  : 'Already have an account? Sign In',
              style: TextStyle(
                color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        if (_isSignIn) {
          await _auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
        } else {
          final userCredential = await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
          
          // Create user document with isAdmin field defaulting to false
          await _firestore.collection('users').doc(userCredential.user!.uid).set({
            'email': _emailController.text.trim(),
            'isAdmin': false,  // Default value
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildUserProfile(User user, bool isDark) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data?.data() as Map<String, dynamic>?;
        final email = user.email ?? '';

        return Column(
        children: [
          Card(
            elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                      backgroundColor: isDark ? Colors.blue.shade700 : Colors.blue.shade100,
                          child: Icon(
                        Icons.person,
                            size: 50,
                        color: isDark ? Colors.white : Colors.blue.shade900,
                      ),
                  ),
                  SizedBox(height: 16),
                  Text(
                      email,
                    style: TextStyle(
                        fontSize: 18,
                        color: isDark ? Colors.white70 : Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateEventScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.add),
                      label: Text('Create Event'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                      'Your Events',
              style: TextStyle(
                        fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.blue.shade900,
              ),
            ),
                    SizedBox(height: 16),
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('events')
                          .where('createdBy', isEqualTo: user.uid)
                          .orderBy('createdAt', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              'No events created yet',
              style: TextStyle(
                                color: isDark ? Colors.white54 : Colors.grey.shade600,
        ),
      ),
    );
  }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final event = snapshot.data!.docs[index];
                            final eventData = event.data() as Map<String, dynamic>;
                            
                            return ListTile(
                              leading: Icon(
                                Icons.event,
                                color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                              ),
                              title: Text(
                                eventData['name'] ?? 'Unnamed Event',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                'Teams: ${eventData['numTeams'] ?? 0}',
                                style: TextStyle(
                                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                                ),
                              ),
                              trailing: Text(
                                _formatDate(eventData['createdAt']),
                                style: TextStyle(
                                  color: isDark ? Colors.white54 : Colors.grey.shade600,
        ),
      ),
    );
                          },
                        );
                      },
            ),
          ],
        ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _handleSignOut,
              icon: Icon(Icons.logout),
              label: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.red.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'No date';
    if (timestamp is Timestamp) {
      final date = timestamp.toDate();
      return '${date.day}/${date.month}/${date.year}';
    }
    return 'Invalid date';
  }

  Future<void> _handleSignOut() async {
    await _auth.signOut();
  }
} 