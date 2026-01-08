#!/bin/bash

# Script de préparation pour TestFlight - MyTV
# Ce script aide à préparer votre application pour TestFlight

set -e

echo "🚀 Préparation de MyTV pour TestFlight"
echo "========================================"
echo ""

# Couleurs pour l'affichage
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages
info() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Vérification des prérequis
echo "📋 Vérification des prérequis..."
echo ""

# Vérifier Flutter
if [ ! -d "./flutter_sdk" ]; then
    error "Flutter SDK non trouvé dans ./flutter_sdk"
    exit 1
fi
info "Flutter SDK trouvé"

# Vérifier Xcode
if ! command -v xcodebuild &> /dev/null; then
    error "Xcode n'est pas installé"
    exit 1
fi
info "Xcode installé"

# Vérifier le workspace iOS
if [ ! -f "ios/Runner.xcworkspace/contents.xcworkspacedata" ]; then
    error "Workspace iOS non trouvé. Exécutez 'cd ios && pod install' d'abord"
    exit 1
fi
info "Workspace iOS trouvé"

echo ""
echo "🔧 Configuration..."
echo ""

# Demander le Bundle ID
echo "Quel est votre Bundle ID ?"
echo "Format: com.votreentreprise.mytv"
read -p "Bundle ID: " BUNDLE_ID

if [ -z "$BUNDLE_ID" ]; then
    error "Bundle ID requis"
    exit 1
fi

info "Bundle ID: $BUNDLE_ID"

# Demander la version
echo ""
echo "Quelle version voulez-vous publier ?"
read -p "Version (ex: 1.0.0): " VERSION

if [ -z "$VERSION" ]; then
    VERSION="1.0.0"
fi

info "Version: $VERSION"

# Demander le build number
echo ""
echo "Quel est le numéro de build ?"
echo "Incrémentez ce numéro à chaque upload (1, 2, 3...)"
read -p "Build number (ex: 1): " BUILD_NUMBER

if [ -z "$BUILD_NUMBER" ]; then
    BUILD_NUMBER="1"
fi

info "Build number: $BUILD_NUMBER"

echo ""
echo "📝 Résumé de la configuration:"
echo "   Bundle ID: $BUNDLE_ID"
echo "   Version: $VERSION"
echo "   Build: $BUILD_NUMBER"
echo ""

read -p "Continuer ? (o/n): " CONFIRM

if [ "$CONFIRM" != "o" ] && [ "$CONFIRM" != "O" ]; then
    warning "Annulé par l'utilisateur"
    exit 0
fi

echo ""
echo "🧹 Nettoyage du projet..."
./flutter_sdk/bin/flutter clean
info "Projet nettoyé"

echo ""
echo "📦 Installation des dépendances..."
./flutter_sdk/bin/flutter pub get
info "Dépendances Flutter installées"

echo ""
echo "🍎 Installation des pods iOS..."
cd ios
pod install
cd ..
info "Pods installés"

echo ""
echo "🔨 Construction du build iOS..."
./flutter_sdk/bin/flutter build ios --release --no-codesign
info "Build iOS créé"

echo ""
echo "✅ Préparation terminée !"
echo ""
echo "📱 Prochaines étapes:"
echo ""
echo "1. Ouvrez le projet dans Xcode:"
echo "   ${GREEN}open ios/Runner.xcworkspace${NC}"
echo ""
echo "2. Dans Xcode:"
echo "   - Sélectionnez le projet Runner"
echo "   - Onglet 'General' → Changez le Bundle Identifier en: ${YELLOW}$BUNDLE_ID${NC}"
echo "   - Changez la Version en: ${YELLOW}$VERSION${NC}"
echo "   - Changez le Build en: ${YELLOW}$BUILD_NUMBER${NC}"
echo "   - Onglet 'Signing & Capabilities' → Configurez votre équipe"
echo ""
echo "3. Créez l'archive:"
echo "   - Menu: Product → Archive"
echo "   - Attendez la fin de la compilation"
echo ""
echo "4. Uploadez sur App Store Connect:"
echo "   - Dans Organizer, cliquez sur 'Distribute App'"
echo "   - Suivez les étapes du guide TESTFLIGHT_GUIDE.md"
echo ""
echo "📖 Pour plus de détails, consultez: ${GREEN}TESTFLIGHT_GUIDE.md${NC}"
echo ""
