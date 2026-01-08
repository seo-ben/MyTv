# Guide d'Installation iOS - MyTelevision

## ⚠️ Différence importante avec Android

Contrairement à Android où vous pouvez simplement installer un fichier `.apk`, iOS a un système de sécurité beaucoup plus strict. Vous **NE POUVEZ PAS** simplement double-cliquer sur le fichier `Runner.app` pour l'installer.

## 📱 Méthodes d'Installation sur iPhone/iPad

### **Méthode 1 : Installation via Xcode (GRATUIT - Recommandé pour les tests)**

#### Prérequis :
- Un Mac avec Xcode installé ✅
- Un câble USB pour connecter votre iPhone/iPad
- Un identifiant Apple (gratuit)

#### Étapes :

1. **Connectez votre iPhone/iPad** à votre Mac via USB

2. **Ouvrez le projet dans Xcode** :
   ```bash
   cd /Users/user290739/Downloads/MyTv-main
   open ios/Runner.xcworkspace
   ```

3. **Configurez la signature de code** :
   - Dans Xcode, cliquez sur le projet "Runner" dans le panneau de gauche
   - Sélectionnez la cible "Runner" sous "TARGETS"
   - Allez dans l'onglet "Signing & Capabilities"
   - Cochez "Automatically manage signing"
   - Sélectionnez votre "Team" (votre identifiant Apple)
   - Si vous n'avez pas de team, cliquez sur "Add Account..." et connectez-vous avec votre Apple ID

4. **Sélectionnez votre appareil** :
   - En haut de Xcode, à côté du bouton Play, cliquez sur le menu déroulant
   - Sélectionnez votre iPhone/iPad connecté

5. **Lancez l'application** :
   - Cliquez sur le bouton Play ▶️ (ou Cmd+R)
   - Xcode va compiler et installer l'app sur votre appareil

6. **Faites confiance au développeur** (première fois uniquement) :
   - Sur votre iPhone/iPad, allez dans `Réglages` > `Général` > `Gestion de l'appareil` (ou `VPN et gestion de l'appareil`)
   - Touchez votre identifiant Apple
   - Touchez "Faire confiance à [votre email]"

#### ⚠️ Limitations avec un compte gratuit :
- L'application expire après **7 jours** (vous devrez la réinstaller)
- Maximum **3 applications** installées en même temps
- Pas de notifications push
- Pas de distribution via TestFlight ou App Store

---

### **Méthode 2 : Créer un fichier .ipa (Nécessite un compte développeur payant)**

#### Prérequis :
- Compte Apple Developer (99$/an)
- Certificat de distribution
- Profil de provisionnement

#### Étapes :

1. **Créez le fichier .ipa** :
   ```bash
   ./flutter_sdk/bin/flutter build ipa
   ```

2. **Le fichier sera généré ici** :
   ```
   build/ios/ipa/MyTelevision.ipa
   ```

3. **Installation sur appareil** :
   - Via Xcode : `Window` > `Devices and Simulators` > Glissez le .ipa
   - Via Apple Configurator 2
   - Via TestFlight (voir Méthode 3)

---

### **Méthode 3 : Distribution via TestFlight (Compte développeur payant)**

#### Prérequis :
- Compte Apple Developer (99$/an)
- Application enregistrée sur App Store Connect

#### Étapes :

1. **Créez une archive** :
   - Ouvrez le projet dans Xcode
   - Menu : `Product` > `Archive`
   - Attendez la fin de la compilation

2. **Uploadez sur App Store Connect** :
   - Dans la fenêtre "Archives", cliquez sur "Distribute App"
   - Sélectionnez "TestFlight & App Store"
   - Suivez les étapes

3. **Invitez des testeurs** :
   - Allez sur [App Store Connect](https://appstoreconnect.apple.com)
   - Sélectionnez votre app
   - Allez dans "TestFlight"
   - Ajoutez des testeurs internes ou externes

4. **Les testeurs installent via TestFlight** :
   - Ils téléchargent l'app "TestFlight" depuis l'App Store
   - Ils reçoivent une invitation par email
   - Ils peuvent installer votre app

#### Avantages :
- ✅ Pas de limite de 7 jours
- ✅ Jusqu'à 10 000 testeurs externes
- ✅ Distribution facile

---

### **Méthode 4 : Via Flutter directement (Pour les tests rapides)**

Si votre appareil est déjà configuré dans Xcode, vous pouvez utiliser Flutter directement :

```bash
# Listez les appareils disponibles
./flutter_sdk/bin/flutter devices

# Installez sur votre iPhone/iPad connecté
./flutter_sdk/bin/flutter run --release
```

---

## 🆚 Comparaison iOS vs Android

| Aspect | Android | iOS |
|--------|---------|-----|
| **Format de fichier** | `.apk` / `.aab` | `.app` / `.ipa` |
| **Installation directe** | ✅ Oui (APK) | ❌ Non |
| **Compte développeur gratuit** | ✅ Oui, illimité | ⚠️ Oui, mais limité (7 jours) |
| **Compte développeur payant** | 25$ (une fois) | 99$/an |
| **Distribution de test** | Fichier APK direct | TestFlight |
| **Sécurité** | Moins strict | Très strict |

---

## 💡 Recommandation

**Pour vos tests actuels** :
- Utilisez la **Méthode 1** (Xcode avec compte gratuit)
- C'est la plus simple et gratuite
- Parfait pour vérifier que tout fonctionne

**Pour une distribution plus large** :
- Investissez dans un compte Apple Developer (99$/an)
- Utilisez TestFlight pour distribuer aux testeurs
- Publiez sur l'App Store pour le grand public

---

## 🚀 Commandes rapides

```bash
# Ouvrir dans Xcode
open ios/Runner.xcworkspace

# Lister les appareils
./flutter_sdk/bin/flutter devices

# Lancer sur un appareil connecté
./flutter_sdk/bin/flutter run --release

# Créer un build iOS
./flutter_sdk/bin/flutter build ios --release

# Créer un fichier .ipa (nécessite compte développeur)
./flutter_sdk/bin/flutter build ipa
```

---

## ❓ Questions fréquentes

**Q : Puis-je envoyer le fichier .app à quelqu'un pour qu'il l'installe ?**  
R : Non, contrairement à Android, iOS ne permet pas cela. Vous devez passer par Xcode, TestFlight ou l'App Store.

**Q : Le compte gratuit suffit-il pour tester ?**  
R : Oui, mais l'app expirera après 7 jours et vous devrez la réinstaller.

**Q : Combien coûte la publication sur l'App Store ?**  
R : 99$/an pour un compte Apple Developer individuel.

**Q : Puis-je tester sur le simulateur sans appareil physique ?**  
R : Oui ! Utilisez : `./flutter_sdk/bin/flutter run -d 'iPhone 16e'`
