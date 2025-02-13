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
  final _oauth2Client = OAuth2Client();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: MouseRegion(
                    // Ajout du MouseRegion pour une meilleure gestion des événements
                    child: TextFormField(
                      // Changement pour TextFormField
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Enter student login',
                        hintText: 'Ex: jdoe',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _searchStudent(_searchController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchStudent(String login) async {
    if (login.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final userData = await _apiClient.searchUser(login);
      final user = UserModel.fromJson(userData);
      
      setState(() {
        _user = user;
        _isLoading = false;
      });

      // Pour tester
      print('User found: ${user.login}');
      print('Level: ${user.level}');
      
    } catch (e) {
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
