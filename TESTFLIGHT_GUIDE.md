# 🚀 Guide Complet TestFlight - MyTV

Ce guide vous accompagne pas à pas pour publier votre application MyTV sur TestFlight et la distribuer à vos testeurs.

---

## 📋 Table des matières

1. [Prérequis](#prérequis)
2. [Configuration du compte développeur](#configuration-du-compte-développeur)
3. [Préparation de l'application](#préparation-de-lapplication)
4. [Création de l'archive](#création-de-larchive)
5. [Upload sur App Store Connect](#upload-sur-app-store-connect)
6. [Configuration TestFlight](#configuration-testflight)
7. [Invitation des testeurs](#invitation-des-testeurs)
8. [Dépannage](#dépannage)

---

## 🎯 Prérequis

### 1. Compte Apple Developer (OBLIGATOIRE)

- **Coût** : 99$/an (ou 99€/an selon votre région)
- **Inscription** : [developer.apple.com/programs](https://developer.apple.com/programs/)
- **Délai d'activation** : 24-48 heures après paiement

### 2. Logiciels requis

- ✅ macOS (version récente)
- ✅ Xcode (dernière version recommandée)
- ✅ Flutter SDK (déjà installé dans votre projet)

### 3. Informations à préparer

- 📧 Email Apple ID (celui du compte développeur)
- 🏢 Nom de l'application : **MyTV** (ou le nom que vous souhaitez)
- 📦 Bundle ID : `com.votreentreprise.mytv` (à définir)
- 🎨 Icône de l'application (1024x1024 pixels)
- 📝 Description de l'application
- 📸 Captures d'écran (optionnel pour TestFlight, obligatoire pour App Store)

---

## 🔧 Configuration du compte développeur

### Étape 1 : Créer l'application sur App Store Connect

1. **Connectez-vous à App Store Connect** :
   - Allez sur [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
   - Connectez-vous avec votre Apple ID développeur

2. **Créez une nouvelle application** :
   - Cliquez sur **"Mes Apps"** (My Apps)
   - Cliquez sur le bouton **"+"** puis **"Nouvelle app"**
   - Remplissez les informations :
     - **Plateformes** : iOS (et tvOS si vous voulez aussi pour Apple TV)
     - **Nom** : MyTV (ou votre nom choisi)
     - **Langue principale** : Français
     - **Bundle ID** : Sélectionnez ou créez un nouveau Bundle ID
       - Format recommandé : `com.votreentreprise.mytv`
       - ⚠️ **IMPORTANT** : Notez ce Bundle ID, vous en aurez besoin !
     - **SKU** : Un identifiant unique (ex: `mytv-001`)
     - **Accès utilisateur** : Accès complet

3. **Sauvegardez** et notez votre **Bundle ID**

### Étape 2 : Créer les certificats et profils

1. **Allez dans Certificates, Identifiers & Profiles** :
   - Sur [developer.apple.com/account](https://developer.apple.com/account)

2. **Créez un App ID** (si pas déjà fait) :
   - Allez dans **Identifiers** → **+**
   - Sélectionnez **App IDs** → **Continue**
   - Type : **App**
   - Description : `MyTV Application`
   - Bundle ID : **Explicit** → Entrez le même Bundle ID que précédemment
   - Capabilities : Sélectionnez celles dont vous avez besoin
   - Cliquez sur **Continue** puis **Register**

3. **Créez un certificat de distribution** :
   - Allez dans **Certificates** → **+**
   - Sélectionnez **Apple Distribution**
   - Suivez les instructions pour créer une CSR (Certificate Signing Request) :
     - Ouvrez **Trousseau d'accès** (Keychain Access) sur Mac
     - Menu : **Trousseau d'accès** → **Assistant de certification** → **Demander un certificat à une autorité**
     - Email : Votre email
     - Nom : Votre nom
     - Enregistré sur le disque
   - Uploadez la CSR
   - Téléchargez et double-cliquez sur le certificat pour l'installer

4. **Créez un profil de provisionnement** :
   - Allez dans **Profiles** → **+**
   - Sélectionnez **App Store** sous Distribution
   - Sélectionnez votre App ID
   - Sélectionnez votre certificat de distribution
   - Nommez le profil : `MyTV App Store`
   - Téléchargez et double-cliquez pour l'installer

---

## 🛠️ Préparation de l'application

### Étape 1 : Configurer le Bundle ID dans Flutter

1. **Ouvrez le projet dans Xcode** :
   ```bash
   cd /Users/user290739/Downloads/MyTv-main
   open ios/Runner.xcworkspace
   ```

2. **Configurez le Bundle Identifier** :
   - Dans Xcode, cliquez sur **Runner** (projet) dans le panneau de gauche
   - Sélectionnez la cible **Runner** sous TARGETS
   - Onglet **General**
   - Dans **Identity**, changez le **Bundle Identifier** pour correspondre à celui créé sur App Store Connect
     - Exemple : `com.votreentreprise.mytv`

3. **Configurez la signature** :
   - Onglet **Signing & Capabilities**
   - Décochez **"Automatically manage signing"**
   - **Team** : Sélectionnez votre équipe de développeur
   - **Provisioning Profile** : Sélectionnez le profil créé précédemment
   - Faites de même pour les configurations **Debug** et **Release**

### Étape 2 : Vérifier les informations de l'app

1. **Version et Build Number** :
   - Dans Xcode, vérifiez **General** → **Identity**
   - **Version** : 1.0.0 (ou votre version)
   - **Build** : 1 (incrémentez à chaque upload)

2. **Icône de l'application** :
   - Assurez-vous que `ios/Runner/Assets.xcassets/AppIcon.appiconset` contient toutes les tailles d'icônes requises
   - Vous pouvez utiliser un générateur en ligne : [appicon.co](https://appicon.co)

3. **Permissions et configurations** :
   - Vérifiez `ios/Runner/Info.plist` pour les permissions nécessaires
   - Exemple : accès réseau, etc.

---

## 📦 Création de l'archive

### Méthode 1 : Via Xcode (Recommandée)

1. **Sélectionnez "Any iOS Device"** :
   - En haut de Xcode, à côté du bouton Play
   - Cliquez sur le menu déroulant et sélectionnez **"Any iOS Device (arm64)"**

2. **Créez l'archive** :
   - Menu : **Product** → **Archive**
   - ⏱️ Attendez la compilation (cela peut prendre 5-15 minutes)
   - Si des erreurs apparaissent, consultez la section [Dépannage](#dépannage)

3. **Vérifiez l'archive** :
   - Une fois terminé, la fenêtre **Organizer** s'ouvre automatiquement
   - Vous devriez voir votre archive listée avec la date et l'heure

### Méthode 2 : Via ligne de commande

```bash
# Depuis le dossier racine du projet
cd /Users/user290739/Downloads/MyTv-main

# Nettoyage
./flutter_sdk/bin/flutter clean

# Build de l'archive
./flutter_sdk/bin/flutter build ipa --release

# Le fichier .ipa sera dans : build/ios/ipa/
```

⚠️ **Note** : La méthode Xcode est plus fiable pour le premier upload.

---

## ☁️ Upload sur App Store Connect

### Depuis Xcode Organizer

1. **Dans la fenêtre Organizer** :
   - Sélectionnez votre archive
   - Cliquez sur **"Distribute App"**

2. **Sélectionnez la méthode de distribution** :
   - Choisissez **"App Store Connect"**
   - Cliquez sur **Next**

3. **Sélectionnez la destination** :
   - Choisissez **"Upload"**
   - Cliquez sur **Next**

4. **Options de distribution** :
   - **App Store Connect distribution options** :
     - ✅ Upload your app's symbols (recommandé pour le debugging)
     - ✅ Manage Version and Build Number (Xcode gérera les numéros)
   - Cliquez sur **Next**

5. **Signature automatique** :
   - Sélectionnez **"Automatically manage signing"**
   - Cliquez sur **Next**

6. **Revue finale** :
   - Vérifiez les informations
   - Cliquez sur **Upload**

7. **Attendez la fin de l'upload** :
   - ⏱️ Cela peut prendre 5-20 minutes selon la taille de l'app et votre connexion
   - Vous recevrez un email de confirmation une fois le traitement terminé

---

## 🧪 Configuration TestFlight

### Étape 1 : Attendre le traitement

1. **Vérifiez le statut** :
   - Allez sur [App Store Connect](https://appstoreconnect.apple.com)
   - Sélectionnez votre app **MyTV**
   - Allez dans l'onglet **TestFlight**

2. **Statut du build** :
   - Vous verrez votre build avec le statut **"Processing"** (Traitement en cours)
   - ⏱️ Le traitement peut prendre **15 minutes à 2 heures**
   - Vous recevrez un email quand c'est prêt

### Étape 2 : Remplir les informations de test

1. **Informations de conformité à l'exportation** :
   - Une fois le build traité, cliquez dessus
   - Répondez aux questions sur le chiffrement :
     - **Votre app utilise-t-elle le chiffrement ?**
       - Si votre app utilise HTTPS : **Oui**
       - Puis sélectionnez : **"No, it only uses encryption for standard purposes"**
   - Sauvegardez

2. **Informations de test** (optionnel mais recommandé) :
   - **What to Test** : Décrivez ce que les testeurs doivent vérifier
   - **Test Details** : Instructions spécifiques
   - **Email** : Email de contact pour les testeurs
   - **Téléphone** : Numéro de contact (optionnel)

---

## 👥 Invitation des testeurs

### Types de testeurs

- **Testeurs internes** : Membres de votre équipe App Store Connect (max 100)
- **Testeurs externes** : N'importe qui avec un email (max 10 000)

### Ajouter des testeurs internes

1. **Dans TestFlight** :
   - Onglet **Internal Testing**
   - Cliquez sur **"+"** à côté de **Internal Testers**

2. **Créez un groupe** (optionnel) :
   - Ou ajoutez directement des testeurs existants de votre équipe

3. **Sélectionnez le build** :
   - Activez le build que vous venez d'uploader

4. **Les testeurs reçoivent un email** :
   - Ils peuvent installer immédiatement

### Ajouter des testeurs externes

1. **Dans TestFlight** :
   - Onglet **External Testing**
   - Cliquez sur **"+"** pour créer un nouveau groupe
   - Nommez le groupe : ex. "Beta Testers"

2. **Ajoutez des testeurs** :
   - Cliquez sur **"+"** à côté de **Testers**
   - Entrez les emails des testeurs
   - Cliquez sur **Add**

3. **Ajoutez le build au groupe** :
   - Sélectionnez le groupe
   - Cliquez sur **Builds** → **"+"**
   - Sélectionnez votre build
   - **⚠️ IMPORTANT** : Pour les testeurs externes, Apple doit d'abord **approuver** votre build
     - Remplissez les informations de test
     - Soumettez pour révision
     - ⏱️ L'approbation prend généralement **24-48 heures**

4. **Une fois approuvé** :
   - Les testeurs reçoivent un email d'invitation
   - Ils peuvent installer l'app via TestFlight

---

## 📱 Installation par les testeurs

### Instructions pour vos testeurs

1. **Installer TestFlight** :
   - Télécharger l'app **TestFlight** depuis l'App Store
   - C'est une app gratuite d'Apple

2. **Accepter l'invitation** :
   - Ouvrir l'email d'invitation
   - Cliquer sur **"View in TestFlight"** ou **"Start Testing"**
   - Ou entrer le code d'invitation dans l'app TestFlight

3. **Installer l'application** :
   - Dans TestFlight, toucher **"Install"**
   - L'app MyTV apparaîtra sur l'écran d'accueil

4. **Tester et donner du feedback** :
   - Utiliser l'app normalement
   - En cas de problème, secouer l'appareil pour envoyer un feedback
   - Ou utiliser le bouton feedback dans TestFlight

---

## 🔄 Mettre à jour la version TestFlight

Quand vous voulez publier une nouvelle version :

1. **Incrémentez le Build Number** :
   - Dans Xcode : **General** → **Build** : 2, 3, 4...
   - Ou changez la **Version** : 1.0.1, 1.1.0, etc.

2. **Créez une nouvelle archive** :
   - Répétez les étapes de [Création de l'archive](#création-de-larchive)

3. **Uploadez** :
   - Même processus que le premier upload

4. **Les testeurs sont notifiés automatiquement** :
   - Ils reçoivent une notification dans TestFlight
   - Ils peuvent mettre à jour l'app

---

## 🐛 Dépannage

### Erreur : "No signing certificate found"

**Solution** :
1. Vérifiez que vous avez bien créé et téléchargé le certificat de distribution
2. Double-cliquez sur le fichier `.cer` pour l'installer dans le Trousseau
3. Dans Xcode, allez dans **Preferences** → **Accounts** → Sélectionnez votre compte → **Download Manual Profiles**

### Erreur : "Provisioning profile doesn't match"

**Solution** :
1. Vérifiez que le Bundle ID dans Xcode correspond exactement à celui de l'App ID
2. Téléchargez à nouveau le profil de provisionnement
3. Dans Xcode, **Signing & Capabilities** → sélectionnez manuellement le bon profil

### Erreur : "Archive failed" avec des erreurs de compilation

**Solution** :
1. Nettoyez le projet :
   ```bash
   ./flutter_sdk/bin/flutter clean
   cd ios
   pod deintegrate
   pod install
   cd ..
   ```
2. Dans Xcode : **Product** → **Clean Build Folder** (Shift+Cmd+K)
3. Réessayez l'archive

### Le build reste en "Processing" pendant des heures

**Solution** :
1. C'est parfois normal, attendez jusqu'à 24h
2. Vérifiez vos emails pour des messages d'Apple
3. Si après 24h rien ne change, contactez le support Apple Developer

### Les testeurs ne reçoivent pas l'email d'invitation

**Solution** :
1. Vérifiez les spams/courrier indésirable
2. Dans App Store Connect, renvoyez l'invitation
3. Donnez-leur le code d'invitation public (pour testeurs externes)
4. Vérifiez que l'email est correct

### Erreur : "Missing Compliance"

**Solution** :
1. Dans TestFlight, cliquez sur le build
2. Répondez aux questions sur le chiffrement
3. Pour la plupart des apps : **"No, it only uses encryption for standard purposes"**

---

## 📊 Limites de TestFlight

| Aspect | Limite |
|--------|--------|
| **Testeurs internes** | 100 maximum |
| **Testeurs externes** | 10 000 maximum |
| **Durée du build** | 90 jours (puis expire) |
| **Builds actifs** | Illimité |
| **Groupes de testeurs** | Illimité |
| **Taille de l'app** | Même limite que l'App Store |

---

## ✅ Checklist finale

Avant de soumettre à TestFlight, vérifiez :

- [ ] Compte Apple Developer actif (99$/an payé)
- [ ] Application créée sur App Store Connect
- [ ] Bundle ID configuré et correspond partout
- [ ] Certificat de distribution installé
- [ ] Profil de provisionnement créé et installé
- [ ] Icône de l'app présente (toutes les tailles)
- [ ] Version et Build number corrects
- [ ] Archive créée avec succès dans Xcode
- [ ] Upload terminé sur App Store Connect
- [ ] Build traité et disponible dans TestFlight
- [ ] Informations de conformité remplies
- [ ] Testeurs ajoutés et invités

---

## 🎓 Ressources utiles

- **Documentation officielle Apple** : [developer.apple.com/testflight](https://developer.apple.com/testflight/)
- **App Store Connect** : [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
- **Support développeur** : [developer.apple.com/support](https://developer.apple.com/support/)
- **Flutter iOS deployment** : [docs.flutter.dev/deployment/ios](https://docs.flutter.dev/deployment/ios)

---

## 💡 Conseils

1. **Commencez avec des testeurs internes** : Pas besoin d'approbation Apple, c'est plus rapide
2. **Testez vous-même d'abord** : Installez via TestFlight sur votre propre appareil
3. **Documentez bien** : Expliquez aux testeurs ce qu'ils doivent tester
4. **Collectez les feedbacks** : Utilisez les outils de feedback de TestFlight
5. **Mettez à jour régulièrement** : Les testeurs apprécient de voir les améliorations

---

## 🚀 Prochaines étapes après TestFlight

Une fois que votre app est stable et testée :

1. **Préparez pour l'App Store** :
   - Captures d'écran (toutes les tailles d'écran requises)
   - Description de l'app
   - Mots-clés
   - Politique de confidentialité
   - Vidéo de prévisualisation (optionnel)

2. **Soumettez pour révision** :
   - Dans App Store Connect, créez une nouvelle version
   - Remplissez toutes les métadonnées
   - Soumettez pour révision Apple
   - ⏱️ Révision : 24-48 heures généralement

3. **Publication** :
   - Une fois approuvée, publiez sur l'App Store !

---

**Bonne chance avec votre distribution TestFlight ! 🎉**

Si vous avez des questions, consultez la section [Dépannage](#dépannage) ou contactez le support Apple Developer.
