import 'package:flutter/material.dart';
import 'package:swifty_companion/data/models/project_model.dart';
import 'package:swifty_companion/data/models/user_model.dart';
import 'package:swifty_companion/config/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(user.login),
        // AppBar avec thème transparent
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppTheme.backgroundDecoration,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Photo de profil
                if (user.imageUrl.isNotEmpty)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.imageUrl),
                    backgroundColor: Colors.white,
                  ),
                const SizedBox(height: 16),

                // // Nom d'utilisateur --> il faut le nom et prenom ici
                // Text(
                //   user.login,
                //   style: Theme.of(context).textTheme.headlineMedium,
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 24),

                // Card des informations de base
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(context, 'Personal Information'),
                        const SizedBox(height: 12),
                        _buildInfoRow(Icons.email, 'Email: ${user.email}'),
                        _buildInfoRow(Icons.bar_chart,
                            'Level: ${user.level.toStringAsFixed(2)}'),
                        if (user.location != null)
                          _buildInfoRow(
                              Icons.location_on, 'Location: ${user.location}'),
                        if (user.phone != null)
                          _buildInfoRow(Icons.phone, 'Phone: ${user.phone}'),
                        if (user.wallet != null)
                          _buildInfoRow(Icons.account_balance_wallet,
                              'Wallet: ${user.wallet} ₳'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // // Card des compétences
                // if (user.cursusUsers != null && user.cursusUsers!.isNotEmpty &&
                //     user.cursusUsers![0].skills != null && user.cursusUsers![0].skills!.isNotEmpty)
                //   Card(
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           _buildSectionTitle(context, 'Skills'),
                //           const SizedBox(height: 12),
                //           ...user.cursusUsers![0].skills!.map((skill) =>
                //             _buildSkillBar(context, skill.name, skill.level)),
                //         ],
                //       ),
                //     ),
                //   ),

                // const SizedBox(height: 16),

                // // Card des projets
                // if (user.projectsUsers != null && user.projectsUsers!.isNotEmpty)
                //   Card(
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           _buildSectionTitle(context, 'Projects'),
                //           const SizedBox(height: 12),
                //           ...user.projectsUsers!.map((project) =>
                //             _buildProjectItem(context, project)),
                //         ],
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Titre de section
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Ligne d'information
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Barre de compétence
  Widget _buildSkillBar(BuildContext context, String name, double level) {
    final percentage = (level * 100).toInt();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Text('Level: ${level.toStringAsFixed(2)} ($percentage%)'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: level / 20, // Supposant un niveau max de 20
            backgroundColor: Colors.grey[300],
            color: Theme.of(context).colorScheme.primary,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  // Élément de projet - version corrigée selon votre structure de données
  Widget _buildProjectItem(BuildContext context, ProjectModel project) {
    final bool isValidated = project.validated;
    final Color statusColor = isValidated ? Colors.green : Colors.red;
    final String statusText = isValidated ? 'Validated' : 'Failed';

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      elevation: 1,
      child: ListTile(
        title: Text(
          project.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: project.finalMark != null
            ? Text('Final Mark: ${project.finalMark}')
            : null,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color:
                statusColor.withAlpha(51), // Remplacement de withOpacity(0.2)
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: statusColor),
          ),
          child: Text(
            statusText,
            style: TextStyle(color: statusColor),
          ),
        ),
      ),
    );
  }
}
