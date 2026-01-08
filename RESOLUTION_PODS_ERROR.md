# Résolution de l'erreur "Framework 'Pods_Runner' not found"

## ✅ Solution Rapide (Recommandée)

### Étape 1 : Construire le framework Pods-Runner d'abord
Dans Xcode avec le workspace ouvert (`Runner.xcworkspace`) :

1. **Sélectionnez le schéma `Pods-Runner`** dans la barre d'outils (à côté du bouton Play)
2. **Construisez** : `Product` > `Build` (ou `Cmd + B`)
3. Attendez que la construction soit terminée
4. **Revenez au schéma `Runner`**
5. **Construisez Runner** : `Product` > `Build` (ou `Cmd + B`)

### Étape 2 : Si le problème persiste - Nettoyer et reconstruire
1. Menu `Product` > `Clean Build Folder` (ou `Cmd + Shift + K`)
2. Construisez d'abord `Pods-Runner` (comme à l'étape 1)
3. Puis construisez `Runner`

## ✅ Vérifications Importantes

### 1. Ouvrir le Workspace (CRUCIAL !)
**CRUCIAL** : Vous devez ouvrir le **workspace** et non le projet :

- ❌ **NE PAS ouvrir** : `ios/Runner.xcodeproj`
- ✅ **OUVRIR** : `ios/Runner.xcworkspace`

Commande terminal : `open ios/Runner.xcworkspace`

### 2. Vérifier le Schéma de Build
1. Dans la barre d'outils Xcode, vérifiez que le schéma est sur `Runner`
2. Vérifiez que la destination est correcte (simulateur ou appareil)

## 🔧 Solutions Avancées

### Option A : Construire via Terminal
Si le problème persiste dans Xcode, construisez d'abord le framework via terminal :

```bash
cd ios
export LANG=en_US.UTF-8
xcodebuild -workspace Runner.xcworkspace -scheme Pods-Runner -configuration Debug -sdk iphonesimulator clean build
```

Puis construisez Runner dans Xcode.

### Option B : Réinstaller les pods
```bash
cd ios
export LANG=en_US.UTF-8
rm -rf Pods Podfile.lock build
pod install --repo-update
```

### Option C : Vérifier les chemins dans Xcode
1. Sélectionnez le projet `Runner` dans le navigateur de gauche
2. Sélectionnez la target `Runner`
3. Onglet `Build Settings`
4. Recherchez `Framework Search Paths`
5. Vérifiez que `$(BUILT_PRODUCTS_DIR)` est présent
6. Vérifiez que `$(PODS_CONFIGURATION_BUILD_DIR)` est présent

## ⚠️ Points importants
- **Toujours ouvrir `.xcworkspace` et jamais `.xcodeproj`** quand CocoaPods est utilisé
- Les pods ont été réinstallés avec succès
- Le framework `Pods_Runner.framework` doit être construit **avant** le target `Runner`
- Avec `use_frameworks! :linkage => :static`, le framework est statique et doit être construit explicitement

## 📝 Explication du problème
Le Podfile utilise `use_frameworks! :linkage => :static`, ce qui crée des frameworks statiques. Ces frameworks doivent être construits avant que le projet principal puisse les lier. Le target `Runner` ne dépend pas automatiquement de `Pods-Runner`, donc vous devez construire `Pods-Runner` en premier.
