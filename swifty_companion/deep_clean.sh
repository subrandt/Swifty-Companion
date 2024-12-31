#!/bin/bash
# deep_clean.sh - Nettoyage complet du projet
# executer avec les commandes suivantes:
#   source deep_clean.sh
#   flutter_deep_clean

function flutter_deep_clean() {
    echo "🧹 Nettoyage complet en cours..."
    
    # Vérifier si nous sommes dans un projet Flutter
    if [ ! -f "pubspec.yaml" ]; then
        echo "❌ Erreur : Ce n'est pas un projet Flutter (pubspec.yaml non trouvé)"
        return 1
    fi
    
    echo "🗑️  Nettoyage Flutter..."
    flutter clean
    
    echo "🗑️  Nettoyage Gradle..."
    if [ -f "android/gradlew" ]; then
        cd android && ./gradlew clean && cd ..
    else
        echo "⚠️  Fichier gradlew non trouvé, régénération des fichiers Android..."
        flutter create .
        cd android && ./gradlew clean && cd ..
    fi
    
    echo "🗑️  Suppression des dossiers de build..."
    rm -rf build/
    rm -rf .dart_tool/
    rm -rf .idea/
    rm -rf ios/Pods/
    
    echo "📦 Réinstallation des dépendances..."
    flutter pub get
    
    echo "🧹 Nettoyage du cache pub..."
    flutter pub cache clean
    
    echo "✅ Nettoyage complet terminé!"
}