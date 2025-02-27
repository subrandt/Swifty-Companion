import 'package:flutter/material.dart';
import 'package:swifty_companion/core/errors/exceptions.dart';
import 'package:swifty_companion/core/network/api_client.dart';
import 'package:swifty_companion/data/models/user_model.dart';
import '../core/network/oauth2_client.dart';
import 'package:swifty_companion/config/routes.dart';
import 'package:swifty_companion/config/theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  final _apiClient = ApiClient(OAuth2Client());
  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('42 Student Search'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppTheme.backgroundDecoration,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Titre
                Text(
                  'Find a 42 Student',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 30),

                // Card avec champ de recherche
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              labelText: 'Enter student login',
                              prefixIcon: Icon(Icons.person_search),
                            ),
                            textAlign: TextAlign.left,
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                _searchStudent(value);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_searchController.text.isNotEmpty) {
                                  _searchStudent(_searchController.text);
                                }
                              },
                              child: const Text('Search'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Loading spinner or error message
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Card(
                      color: Colors.red.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _error!,
                          style: TextStyle(color: Colors.red.shade800),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _searchStudent(String login) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('🔍 Searching for user: $login');
      final userData = await _apiClient.searchUser(login);

      if (userData == null) {
        throw ApiError('No data received from API');
      }

      final user = UserModel.fromJson(userData);

      // Navigate to profile page
      if (mounted) {
        Navigator.pushNamed(
          context,
          Routes.profile,
          arguments: user,
        );
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error occurred: $e');
      setState(() {
        _isLoading = false;
        _error = 'Student not found';
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
