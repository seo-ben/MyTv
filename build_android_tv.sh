#!/bin/bash

# Script de Test et Build pour Android TV - MyTelevision
# Date: 2025-12-27

echo "🚀 MyTelevision - Android TV Build Script"
echo "=========================================="
echo ""

# Couleurs pour le terminal
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Fonction pour afficher les étapes
step() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# 1. Nettoyage
echo "📦 Étape 1/5 : Nettoyage du projet..."
flutter clean
if [ $? -eq 0 ]; then
    step "Nettoyage terminé"
else
    error "Erreur lors du nettoyage"
    exit 1
fi
echo ""

# 2. Récupération des dépendances
echo "📥 Étape 2/5 : Récupération des dépendances..."
flutter pub get
if [ $? -eq 0 ]; then
    step "Dépendances récupérées"
else
    error "Erreur lors de la récupération des dépendances"
    exit 1
fi
echo ""

# 3. Analyse du code
echo "🔍 Étape 3/5 : Analyse du code..."
flutter analyze
if [ $? -eq 0 ]; then
    step "Analyse terminée sans erreur"
else
    warning "Analyse terminée avec des warnings (non bloquants)"
fi
echo ""

# 4. Build APK de test
echo "🔨 Étape 4/5 : Build APK de test..."
flutter build apk --debug
if [ $? -eq 0 ]; then
    step "APK de test créé : build/app/outputs/flutter-apk/app-debug.apk"
else
    error "Erreur lors du build APK de test"
    exit 1
fi
echo ""

# 5. Build AAB de production (optionnel)
read -p "Voulez-vous générer l'AAB de production ? (o/N) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Oo]$ ]]
then
    echo "🏗️  Étape 5/5 : Build AAB de production..."
    flutter build appbundle --release
    if [ $? -eq 0 ]; then
        step "AAB de production créé : build/app/outputs/bundle/release/app-release.aab"
        echo ""
        echo "=========================================="
        echo "✅ BUILD TERMINÉ AVEC SUCCÈS !"
        echo "=========================================="
        echo ""
        echo "📦 Fichiers générés :"
        echo "  - APK de test : build/app/outputs/flutter-apk/app-debug.apk"
        echo "  - AAB de production : build/app/outputs/bundle/release/app-release.aab"
        echo ""
        echo "📝 Prochaines étapes :"
        echo "  1. Testez l'APK sur un émulateur Android TV"
        echo "  2. Vérifiez la navigation D-pad"
        echo "  3. Uploadez l'AAB sur Google Play Console"
        echo ""
    else
        error "Erreur lors du build AAB de production"
        exit 1
    fi
else
    echo ""
    echo "=========================================="
    echo "✅ BUILD DE TEST TERMINÉ !"
    echo "=========================================="
    echo ""
    echo "📦 Fichier généré :"
    echo "  - APK de test : build/app/outputs/flutter-apk/app-debug.apk"
    echo ""
    echo "📝 Pour générer l'AAB de production plus tard :"
    echo "  flutter build appbundle --release"
    echo ""
fi

# Instructions finales
echo "📚 Documentation disponible :"
echo "  - ANDROID_TV_FIXES.md (résumé)"
echo "  - ANDROID_TV_TEST_GUIDE.md (guide de test)"
echo "  - ANDROID_TV_CHANGES_SUMMARY.md (détails techniques)"
echo ""
echo "🎮 Pour tester sur émulateur Android TV :"
echo "  flutter run"
echo "  (puis sélectionnez l'émulateur Android TV)"
echo ""
