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

    // Get skills and cursus name based on active status
    final skills = user.getRelevantSkills();
    final cursusName = user.getRelevantCursusName();

    // Filtrer et trier les projets
    final projects = _getSortedProjects(user.projects);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(user.login),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                // Profile picture
                if (user.imageUrl.isNotEmpty)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.imageUrl),
                    backgroundColor: Colors.white,
                  ),
                const SizedBox(height: 16),

                // Username
                Text(
                  user.firstName + ' ' + user.lastName,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Basic info card
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

                // Skills card
                if (skills.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(
                              context,
                              cursusName.isNotEmpty
                                  ? 'Skills - $cursusName'
                                  : 'Skills'),
                          const SizedBox(height: 12),
                          ...skills.map((skill) => _buildFixedSkillBar(
                              context, skill.name, skill.level)),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Projects card
                if (projects.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle(context, 'Projects'),
                          const SizedBox(height: 12),
                          ...projects.map(
                              (project) => _buildProjectItem(context, project)),
                        ],
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

  // Trier les projets (les validés d'abord, puis par note décroissante)
  List<ProjectModel> _getSortedProjects(List<ProjectModel> projects) {
    final sortedProjects = List<ProjectModel>.from(projects);
    sortedProjects.sort((a, b) {
      // D'abord trier par statut validé
      if (a.validated && !b.validated) return -1;
      if (!a.validated && b.validated) return 1;

      // Ensuite par note (décroissant)
      final aScore = a.finalMark ?? 0;
      final bScore = b.finalMark ?? 0;
      return bScore.compareTo(aScore);
    });
    return sortedProjects;
  }

  // Section title widget
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Info row with icon and text
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

  // Fixed skill bar to prevent overflow on mobile screens
  Widget _buildFixedSkillBar(BuildContext context, String name, double level) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Using a Row with expanded text
          Row(
            children: [
              // Skill name with overflow handling
              Expanded(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              // Level indicator with some spacing
              const SizedBox(width: 8),
              Text(
                'Level: ${level.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Progress bar
          LinearProgressIndicator(
            value: level / 20, // Assuming max level is 20
            backgroundColor: Colors.grey[300],
            color: Theme.of(context).colorScheme.primary,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  // Project item
  Widget _buildProjectItem(BuildContext context, ProjectModel project) {
    final bool isValidated = project.validated;
    final Color statusColor = isValidated ? Colors.green : Colors.red;
    String statusText = project.status.replaceAll('_', ' ');
    statusText = statusText[0].toUpperCase() + statusText.substring(1);

    if (isValidated) {
      statusText = 'Validated';
    } else if (project.status == 'finished') {
      statusText = 'Failed';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      elevation: 1,
      child: ListTile(
        title: Text(
          project.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: project.finalMark != null
            ? Text('Mark: ${project.finalMark?.toInt()}')
            : null,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withAlpha(51),
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
