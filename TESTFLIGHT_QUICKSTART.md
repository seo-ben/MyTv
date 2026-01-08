# 🚀 Démarrage Rapide TestFlight

Guide condensé pour publier rapidement sur TestFlight. Pour plus de détails, consultez [TESTFLIGHT_GUIDE.md](TESTFLIGHT_GUIDE.md).

---

## ⚡ En 5 minutes (si tout est déjà configuré)

```bash
# 1. Préparer le projet
./prepare_testflight.sh

# 2. Ouvrir dans Xcode
open ios/Runner.xcworkspace

# 3. Dans Xcode :
#    - Product → Archive
#    - Distribute App → App Store Connect → Upload

# 4. Attendre le traitement (15min-2h)

# 5. Inviter des testeurs sur appstoreconnect.apple.com
```

---

## 📋 Prérequis OBLIGATOIRES

Avant de commencer, vous DEVEZ avoir :

1. ✅ **Compte Apple Developer** (99$/an)
   - Inscription : [developer.apple.com/programs](https://developer.apple.com/programs/)

2. ✅ **Application créée sur App Store Connect**
   - Avec un Bundle ID (ex: `com.votreentreprise.mytv`)

3. ✅ **Certificats et profils configurés**
   - Certificat de distribution
   - Profil de provisionnement

❌ **Sans ces éléments, vous NE POUVEZ PAS utiliser TestFlight**

---

## 🎯 Processus complet (première fois)

### Étape 1 : Compte et configuration (30-60 min)

1. **Créer le compte développeur**
   - Aller sur [developer.apple.com/programs](https://developer.apple.com/programs/)
   - Payer 99$/an
   - Attendre activation (24-48h)

2. **Créer l'app sur App Store Connect**
   - [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
   - Mes Apps → + → Nouvelle app
   - Choisir un Bundle ID : `com.votreentreprise.mytv`
   - **NOTER CE BUNDLE ID !**

3. **Créer certificats et profils**
   - [developer.apple.com/account](https://developer.apple.com/account)
   - Certificates → + → Apple Distribution
   - Identifiers → + → App ID (même Bundle ID)
   - Profiles → + → App Store (distribution)

### Étape 2 : Configuration du projet (10 min)

```bash
# 1. Préparer le projet
./prepare_testflight.sh

# 2. Ouvrir Xcode
open ios/Runner.xcworkspace
```

Dans Xcode :
- Runner (projet) → General → Bundle Identifier → **Entrer votre Bundle ID**
- Signing & Capabilities → Team → **Sélectionner votre équipe**
- Signing & Capabilities → Provisioning Profile → **Sélectionner votre profil**

### Étape 3 : Créer et uploader (20-30 min)

1. **Dans Xcode** :
   - Sélectionner "Any iOS Device (arm64)" en haut
   - Menu : **Product → Archive**
   - Attendre la compilation (5-15 min)

2. **Dans Organizer** (s'ouvre automatiquement) :
   - Cliquer sur **Distribute App**
   - Sélectionner **App Store Connect**
   - Sélectionner **Upload**
   - Suivre les étapes
   - Attendre l'upload (5-20 min)

### Étape 4 : Configuration TestFlight (5 min + attente)

1. **Aller sur App Store Connect**
   - [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
   - Sélectionner votre app
   - Onglet **TestFlight**

2. **Attendre le traitement**
   - Le build apparaît avec "Processing"
   - ⏱️ Attendre 15min - 2h
   - Vous recevrez un email

3. **Remplir les infos de conformité**
   - Cliquer sur le build
   - Questions sur le chiffrement → **"No, it only uses encryption for standard purposes"**

### Étape 5 : Inviter des testeurs (2 min)

**Testeurs internes** (recommandé pour commencer) :
- TestFlight → Internal Testing → +
- Ajouter des membres de votre équipe
- Ils reçoivent un email immédiatement

**Testeurs externes** :
- TestFlight → External Testing → + → Créer un groupe
- Ajouter des emails
- Soumettre pour révision Apple (24-48h d'attente)

---

## 🔄 Mises à jour (10 min)

Pour publier une nouvelle version :

```bash
# 1. Préparer
./prepare_testflight.sh

# 2. Dans Xcode, incrémenter le Build number
#    General → Build : 2, 3, 4...

# 3. Archive et upload
#    Product → Archive → Distribute App

# Les testeurs sont notifiés automatiquement !
```

---

## 🆘 Problèmes fréquents

### "No signing certificate found"
```bash
# Solution : Télécharger manuellement les profils
# Xcode → Preferences → Accounts → Download Manual Profiles
```

### "Provisioning profile doesn't match"
- Vérifier que le Bundle ID est identique partout
- Re-télécharger le profil de provisionnement

### Build reste en "Processing" trop longtemps
- Normal jusqu'à 2h
- Vérifier les emails d'Apple
- Si > 24h, contacter le support

### Testeurs ne reçoivent pas l'email
- Vérifier les spams
- Renvoyer l'invitation
- Vérifier que l'email est correct

---

## 📞 Aide

- **Guide complet** : [TESTFLIGHT_GUIDE.md](TESTFLIGHT_GUIDE.md)
- **Checklist** : [TESTFLIGHT_CHECKLIST.md](TESTFLIGHT_CHECKLIST.md)
- **Support Apple** : [developer.apple.com/support](https://developer.apple.com/support/)

---

## ⏱️ Temps estimés

| Étape | Première fois | Mises à jour |
|-------|---------------|--------------|
| Configuration compte | 30-60 min + 24-48h attente | - |
| Configuration projet | 10 min | - |
| Création archive | 5-15 min | 5-15 min |
| Upload | 5-20 min | 5-20 min |
| Traitement Apple | 15min - 2h | 15min - 2h |
| Invitation testeurs | 2 min | - |
| **TOTAL** | **~1h + attentes** | **~15-45 min** |

---

## ✅ Checklist ultra-rapide

- [ ] Compte Apple Developer actif (99$/an)
- [ ] App créée sur App Store Connect
- [ ] Bundle ID noté : ___________________________
- [ ] Certificats et profils créés
- [ ] `./prepare_testflight.sh` exécuté
- [ ] Bundle ID configuré dans Xcode
- [ ] Archive créée (Product → Archive)
- [ ] Upload terminé (Distribute App)
- [ ] Build traité (vérifier email)
- [ ] Conformité remplie
- [ ] Testeurs invités

---

**C'est parti ! 🎉**

Suivez ces étapes et votre app sera sur TestFlight en moins d'une heure (hors temps d'attente).
