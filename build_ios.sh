#!/bin/bash

# Script de Test et Build pour iOS - MyTelevision
# Date: 2026-01-05

echo "🚀 MyTelevision - iOS Build Script"
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

# Définir le chemin Flutter local
FLUTTER_BIN="./flutter_sdk/bin/flutter"

# 1. Nettoyage
echo "📦 Étape 1/6 : Nettoyage du projet..."
$FLUTTER_BIN clean
if [ $? -eq 0 ]; then
    step "Nettoyage terminé"
else
    error "Erreur lors du nettoyage"
    exit 1
fi
echo ""

# 2. Récupération des dépendances
echo "📥 Étape 2/6 : Récupération des dépendances..."
$FLUTTER_BIN pub get
if [ $? -eq 0 ]; then
    step "Dépendances récupérées"
else
    error "Erreur lors de la récupération des dépendances"
    exit 1
fi
echo ""

# 3. Installation des pods iOS
echo "📦 Étape 3/6 : Installation des CocoaPods..."
cd ios
pod install
if [ $? -eq 0 ]; then
    step "CocoaPods installés"
else
    error "Erreur lors de l'installation des CocoaPods"
    cd ..
    exit 1
fi
cd ..
echo ""

# 4. Analyse du code
echo "🔍 Étape 4/6 : Analyse du code..."
$FLUTTER_BIN analyze
if [ $? -eq 0 ]; then
    step "Analyse terminée sans erreur"
else
    warning "Analyse terminée avec des warnings (non bloquants)"
fi
echo ""

# 5. Build iOS Debug pour simulateur
echo "🔨 Étape 5/6 : Build iOS Debug pour simulateur..."
$FLUTTER_BIN build ios --debug --simulator
if [ $? -eq 0 ]; then
    step "Build iOS Debug créé pour simulateur"
else
    error "Erreur lors du build iOS Debug"
    exit 1
fi
echo ""

# 6. Build iOS Release (optionnel)
read -p "Voulez-vous générer le build Release pour un appareil physique ? (o/N) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Oo]$ ]]
then
    echo "🏗️  Étape 6/6 : Build iOS Release..."
    $FLUTTER_BIN build ios --release --no-codesign
    if [ $? -eq 0 ]; then
        step "Build iOS Release créé (sans signature)"
        echo ""
        echo "=========================================="
        echo "✅ BUILD TERMINÉ AVEC SUCCÈS !"
        echo "=========================================="
        echo ""
        echo "📦 Builds générés :"
        echo "  - Debug (simulateur) : build/ios/iphonesimulator/"
        echo "  - Release (appareil) : build/ios/iphoneos/"
        echo ""
        echo "📝 Prochaines étapes :"
        echo "  1. Pour tester sur simulateur : flutter run"
        echo "  2. Pour déployer sur appareil : ouvrez ios/Runner.xcworkspace dans Xcode"
        echo "  3. Configurez votre équipe de développement dans Xcode"
        echo "  4. Connectez votre iPhone/iPad et lancez depuis Xcode"
        echo ""
    else
        error "Erreur lors du build iOS Release"
        exit 1
    fi
else
    echo ""
    echo "=========================================="
    echo "✅ BUILD DE TEST TERMINÉ !"
    echo "=========================================="
    echo ""
    echo "📦 Build généré :"
    echo "  - Debug (simulateur) : build/ios/iphonesimulator/"
    echo ""
    echo "📝 Pour générer le build Release plus tard :"
    echo "  $FLUTTER_BIN build ios --release"
    echo ""
fi
# Instructions finales
echo "📚 Pour tester sur simulateur iOS :"
echo "  $FLUTTER_BIN run -d 'iPhone 16e'"
echo ""
echo "🎮 Pour ouvrir dans Xcode :"
echo "  open ios/Runner.xcworkspace"
echo ""
echo "📱 Simulateurs disponibles :"
$FLUTTER_BIN devices | grep simulator
echo ""
