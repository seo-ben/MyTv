# Guide de Test Android TV - MyTelevision

## 🎯 Objectif

Ce guide vous aide à tester votre application sur Android TV pour vous assurer qu'elle respecte les directives de Google Play Console.

## 📋 Problèmes Résolus

### 1. ✅ Navigation au pavé directionnel (D-pad)

**Problème initial :** Les boutons, barres de défilement et icônes de menu n'étaient pas surlignables.

**Solutions implémentées :**

- Ajout du widget `FocusableWidget` pour tous les éléments interactifs
- Support de la navigation au clavier/D-pad dans le carousel
- Indicateurs visuels de focus (bordure blanche)
- Autofocus sur les premiers éléments pour Android TV

### 2. ✅ Lecture de contenu

**Problème initial :** L'application ne lisait aucun contenu sur Android TV.

**Solutions implémentées :**

- Vérification que le lecteur vidéo fonctionne correctement
- Support du Chromecast pour diffuser sur TV
- Wakelock pour garder l'écran allumé pendant la lecture

## 🧪 Comment Tester

### Option 1 : Émulateur Android TV (Recommandé)

1. **Créer un émulateur Android TV dans Android Studio :**

   ```bash
   # Ouvrir AVD Manager
   # Tools > Device Manager > Create Device
   # Sélectionner "TV" dans la catégorie
   # Choisir "Android TV (1080p)" ou "Android TV (4K)"
   # Sélectionner une API Level 29+ (Android 10+)
   ```

2. **Lancer l'application sur l'émulateur :**

   ```bash
   flutter run
   # Sélectionner l'émulateur Android TV dans la liste
   ```

3. **Tester la navigation D-pad :**

   - Utilisez les touches fléchées de votre clavier (↑ ↓ ← →)
   - Appuyez sur `Entrée` ou `Espace` pour sélectionner
   - Vérifiez que tous les éléments sont surlignables :
     - ✅ Carousel (navigation gauche/droite)
     - ✅ Bouton "Watch Now"
     - ✅ Boutons "Sport en direct" et "Temps forts"
     - ✅ Items de la liste de football
     - ✅ Items de la liste de matchs
     - ✅ Bouton "Add to My List" dans le lecteur vidéo

4. **Tester la lecture vidéo :**
   - Sélectionnez un contenu avec le D-pad
   - Appuyez sur Entrée pour lancer la lecture
   - Vérifiez que la vidéo se lance correctement
   - Testez les contrôles du lecteur vidéo

### Option 2 : Appareil Android TV Physique

1. **Activer le mode développeur sur votre Android TV :**

   - Paramètres > À propos > Build
   - Appuyez 7 fois sur "Build" pour activer le mode développeur
   - Paramètres > Préférences de l'appareil > Sécurité et restrictions
   - Activez "Sources inconnues" pour Android Studio

2. **Connecter via ADB :**

   ```bash
   # Trouver l'adresse IP de votre TV (Paramètres > Réseau)
   adb connect <IP_DE_VOTRE_TV>:5555

   # Vérifier la connexion
   adb devices
   ```

3. **Installer l'application :**
   ```bash
   flutter build apk --release
   flutter install
   ```

### Option 3 : Test avec Chromecast

1. **Vérifier que le Chromecast est configuré**
2. **Lancer l'application sur mobile/tablette**
3. **Appuyer sur l'icône Cast**
4. **Sélectionner votre appareil Chromecast**
5. **Lancer une vidéo et vérifier qu'elle se diffuse sur la TV**

## ✅ Checklist de Validation

Avant de soumettre à Google Play Console, vérifiez :

### Navigation D-pad

- [ ] Tous les boutons sont surlignables avec le D-pad
- [ ] La bordure de focus est visible (bordure blanche)
- [ ] Le carousel peut être navigué avec les flèches gauche/droite
- [ ] Les listes horizontales peuvent être parcourues
- [ ] Le bouton "Watch Now" est focusable
- [ ] Les boutons "Sport en direct" et "Temps forts" sont focusables
- [ ] Le bouton "Add to My List" est focusable

### Lecture de Contenu

- [ ] Les vidéos se lancent correctement
- [ ] Les contrôles du lecteur fonctionnent
- [ ] Le Chromecast fonctionne (si disponible)
- [ ] L'écran reste allumé pendant la lecture
- [ ] Les publicités vidéo se lancent (si configurées)

### Interface Utilisateur

- [ ] Les éléments sont correctement dimensionnés pour TV
- [ ] Le texte est lisible à distance
- [ ] Les icônes sont assez grandes
- [ ] L'application est responsive sur différentes résolutions TV

### AndroidManifest.xml

- [ ] `android.software.leanback` est déclaré avec `required="false"`
- [ ] `android.hardware.touchscreen` est déclaré avec `required="false"`
- [ ] `android.hardware.gamepad` est déclaré avec `required="false"`
- [ ] Le banner TV est défini (`android:banner`)
- [ ] `LEANBACK_LAUNCHER` est dans les intent-filters

## 🚀 Génération de l'APK/AAB pour Soumission

### Générer un Android App Bundle (AAB) - Recommandé

```bash
# Nettoyer le projet
flutter clean

# Récupérer les dépendances
flutter pub get

# Générer l'AAB signé
flutter build appbundle --release

# Le fichier sera dans : build/app/outputs/bundle/release/app-release.aab
```

### Générer un APK (Alternative)

```bash
flutter build apk --release --split-per-abi

# Les fichiers seront dans : build/app/outputs/flutter-apk/
```

## 📝 Notes Importantes

1. **Test sur plusieurs résolutions :**

   - 720p (HD)
   - 1080p (Full HD)
   - 4K (Ultra HD)

2. **Test sur différentes versions Android TV :**

   - Android TV 9 (API 28)
   - Android TV 10 (API 29)
   - Android TV 11 (API 30)
   - Android TV 12+ (API 31+)

3. **Vérifier les performances :**
   - Temps de chargement
   - Fluidité de la navigation
   - Consommation mémoire

## 🐛 Débogage

Si vous rencontrez des problèmes :

```bash
# Voir les logs en temps réel
adb logcat | grep -i flutter

# Voir les logs spécifiques à votre app
adb logcat | grep -i mytelevision

# Capturer une vidéo de l'écran pour documentation
adb shell screenrecord /sdcard/demo.mp4
adb pull /sdcard/demo.mp4
```

## 📞 Support

Si vous avez des questions ou des problèmes :

1. Vérifiez les logs avec `adb logcat`
2. Consultez la documentation Flutter TV : https://docs.flutter.dev/platform-integration/android/tv
3. Consultez les directives Android TV : https://developer.android.com/training/tv

---

**Dernière mise à jour :** 2025-12-27
**Version de l'application :** Compatible Android TV
