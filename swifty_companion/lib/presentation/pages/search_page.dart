import 'package:flutter/material.dart';
import 'package:swifty_companion/core/network/api_client.dart';
import 'package:swifty_companion/data/models/user_model.dart';
import '../../core/network/oauth2_client.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  final _apiClient = ApiClient(OAuth2Client());
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('42 Student Search'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            labelText: 'Enter student login',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              _searchStudent(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            _searchStudent(_searchController.text);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_error != null)
                Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else if (_user != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Found user: ${_user!.login}'),
                        if (_user!.imageUrl.isNotEmpty)
                          Image.network(_user!.imageUrl),
                        Text('Email: ${_user!.email}'),
                        Text('Level: ${_user!.level}'),
                      ],
                    ),
                  ),
                ),
            ],
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
      print('📡 Raw API response: $userData');

      if (userData == null) {
        throw Exception('No data received from API');
      }

      setState(() {
        _user = UserModel.fromJson(userData);
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error occurred: $e');
      setState(() {
        _isLoading = false;
        _error = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
