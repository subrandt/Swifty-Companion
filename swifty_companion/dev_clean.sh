#!/bin/bash
# dev_clean.sh - Nettoyage pendant le développement
# executer avec les commandes suivantes:
#   source dev_clean.sh
#   flutter_dev_clean

function flutter_dev_clean() {
    echo "🧹 Nettoyage de développement en cours..."
    
    # Vérifier si nous sommes dans un projet Flutter
    if [ ! -f "pubspec.yaml" ]; then
        echo "❌ Erreur : Ce n'est pas un projet Flutter (pubspec.yaml non trouvé)"
        return 1
    fi
    
    echo "🗑️  Nettoyage Flutter..."
    flutter clean
    
    echo "📦 Réinstallation des dépendances..."
    flutter pub get
    
    echo "✅ Nettoyage de développement terminé!"
}