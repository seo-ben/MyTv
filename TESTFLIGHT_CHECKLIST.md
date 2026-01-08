# ✅ Checklist TestFlight - MyTV

Utilisez cette checklist pour suivre votre progression vers TestFlight.

---

## 🎯 Phase 1 : Préparation du compte (À faire une seule fois)

- [ ] **Créer un compte Apple Developer**
  - Aller sur [developer.apple.com/programs](https://developer.apple.com/programs/)
  - S'inscrire et payer 99$/an
  - Attendre l'activation (24-48h)

- [ ] **Créer l'application sur App Store Connect**
  - Aller sur [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
  - Mes Apps → + → Nouvelle app
  - Choisir un Bundle ID (ex: `com.votreentreprise.mytv`)
  - **Noter le Bundle ID** : ___________________________

- [ ] **Créer les certificats et profils**
  - Aller sur [developer.apple.com/account](https://developer.apple.com/account)
  - Créer un App ID avec le même Bundle ID
  - Créer un certificat de distribution (Apple Distribution)
  - Créer un profil de provisionnement (App Store)
  - Télécharger et installer les certificats

---

## 🛠️ Phase 2 : Configuration du projet

- [ ] **Préparer l'icône de l'application**
  - Créer une icône 1024x1024 pixels
  - Générer toutes les tailles sur [appicon.co](https://appicon.co)
  - Placer dans `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

- [ ] **Configurer le Bundle ID dans Xcode**
  - Ouvrir : `open ios/Runner.xcworkspace`
  - Runner → General → Bundle Identifier
  - Entrer le Bundle ID : ___________________________

- [ ] **Configurer la signature de code**
  - Xcode → Signing & Capabilities
  - Sélectionner votre Team
  - Sélectionner le profil de provisionnement

- [ ] **Vérifier les informations de version**
  - Version : ___________________________
  - Build : ___________________________

---

## 📦 Phase 3 : Création et upload du build

- [ ] **Exécuter le script de préparation**
  ```bash
  ./prepare_testflight.sh
  ```

- [ ] **Créer l'archive dans Xcode**
  - Sélectionner "Any iOS Device (arm64)"
  - Menu : Product → Archive
  - Attendre la fin de la compilation

- [ ] **Uploader sur App Store Connect**
  - Dans Organizer → Distribute App
  - Choisir "App Store Connect"
  - Choisir "Upload"
  - Suivre les étapes
  - Attendre la fin de l'upload

- [ ] **Attendre le traitement**
  - Aller sur App Store Connect → TestFlight
  - Vérifier que le build apparaît
  - Attendre le statut "Ready to Test" (15min - 2h)
  - Vérifier l'email de confirmation

---

## 🧪 Phase 4 : Configuration TestFlight

- [ ] **Remplir les informations de conformité**
  - Cliquer sur le build
  - Répondre aux questions sur le chiffrement
  - Généralement : "No, it only uses encryption for standard purposes"

- [ ] **Ajouter les informations de test** (optionnel)
  - What to Test : ___________________________
  - Test Details : ___________________________
  - Email de contact : ___________________________

---

## 👥 Phase 5 : Invitation des testeurs

### Testeurs internes (recommandé pour commencer)

- [ ] **Ajouter des testeurs internes**
  - TestFlight → Internal Testing
  - Ajouter des membres de votre équipe App Store Connect
  - Sélectionner le build

- [ ] **Vérifier que les testeurs ont reçu l'email**
  - Vérifier les spams si nécessaire

### Testeurs externes (nécessite approbation Apple)

- [ ] **Créer un groupe de testeurs externes**
  - TestFlight → External Testing → +
  - Nommer le groupe : ___________________________

- [ ] **Ajouter des testeurs**
  - Entrer les emails des testeurs
  - Liste des emails : ___________________________

- [ ] **Soumettre pour révision Apple**
  - Remplir les informations de test
  - Soumettre le build
  - Attendre l'approbation (24-48h)

- [ ] **Vérifier que les testeurs ont reçu l'invitation**

---

## 📱 Phase 6 : Instructions pour les testeurs

Envoyez ces instructions à vos testeurs :

```
Bonjour,

Vous êtes invité(e) à tester l'application MyTV via TestFlight !

Étapes :
1. Téléchargez l'app "TestFlight" depuis l'App Store
2. Ouvrez l'email d'invitation et cliquez sur "View in TestFlight"
3. Dans TestFlight, touchez "Install"
4. L'app MyTV apparaîtra sur votre écran d'accueil
5. Testez l'application et envoyez vos retours via TestFlight

Merci pour votre aide !
```

---

## 🔄 Pour les mises à jour futures

- [ ] **Incrémenter le Build Number**
  - Build actuel : ___________________________
  - Nouveau build : ___________________________

- [ ] **Créer une nouvelle archive**
  - Répéter Phase 3

- [ ] **Les testeurs seront notifiés automatiquement**

---

## 📊 Suivi des versions

| Version | Build | Date Upload | Statut | Notes |
|---------|-------|-------------|--------|-------|
| 1.0.0   | 1     |             |        |       |
|         |       |             |        |       |
|         |       |             |        |       |

---

## 🆘 Problèmes rencontrés

Notez ici les problèmes et leurs solutions :

1. ___________________________________________________________
   Solution : ___________________________________________________

2. ___________________________________________________________
   Solution : ___________________________________________________

3. ___________________________________________________________
   Solution : ___________________________________________________

---

## 📞 Contacts utiles

- **Support Apple Developer** : [developer.apple.com/support](https://developer.apple.com/support/)
- **App Store Connect** : [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
- **Guide complet** : Voir `TESTFLIGHT_GUIDE.md`

---

## 🎉 Félicitations !

Une fois toutes les cases cochées, votre application est sur TestFlight ! 🚀

**Prochaines étapes** :
- Collecter les retours des testeurs
- Corriger les bugs
- Publier des mises à jour
- Préparer la publication sur l'App Store

---

**Date de début** : ___________________________  
**Date de publication TestFlight** : ___________________________  
**Nombre de testeurs** : ___________________________
