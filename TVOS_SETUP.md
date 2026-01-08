# Compatibilité Apple TV via Flutter

Cette application a été mise à jour pour inclure la détection logicielle de tvOS, mais pour compiler et exécuter l'application sur une Apple TV, vous devez effectuer des configurations manuelles dans Xcode, car Flutter ne supporte pas nativement la création de cibles tvOS via la ligne de commande.

## Étapes pour ajouter le support tvOS

### 1. Ouvrir le projet dans Xcode
1. Lancez Xcode.
2. Ouvrez le fichier `ios/Runner.xcworkspace`.

### 2. Ajouter une cible Apple TV (tvOS)
1. Dans Xcode, cliquez sur le projet `Runner` dans le navigateur de gauche.
2. Dans la section "Targets", cliquez sur le bouton `+` en bas.
3. Sélectionnez **tvOS** > **App**.
4. Cliquez sur **Next**.
5. Nommez la cible (par exemple `RunnerTV`).
6. Assurez-vous que le langage est **Swift** (ou Objective-C selon le projet existant, Swift recommandé).
7. Cliquez sur **Finish**.

### 3. Configurer les Pods (Dépendances)
1. Ouvrez le fichier `ios/Podfile` dans votre éditeur de code.
2. Ajoutez la configuration pour la nouvelle cible tvOS. Exemple :

```ruby
target 'RunnerTV' do
  use_frameworks!
  # Copier les pods nécessaires ici, ou utiliser inherit! si applicable
  # Note : Tous les plugins Flutter ne sont pas compatibles tvOS.
  
  # Si vous utilisez des plugins spécifiques, ajoutez-les ici.
end
```
3. Exécutez `pod install` dans le dossier `ios` via le terminal :
   ```bash
   cd ios
   pod install
   ```

### 4. Adapter le Runner
Le code natif généré pour tvOS sera vide. Vous devrez peut-être copier la configuration du `AppDelegate.swift` de la cible iOS vers le `AppDelegate.swift` de la cible tvOS, en veillant à importer `Flutter` et `FlutterTv` (si vous utilisez un moteur tvOS spécifique) ou simplement adapter le `FlutterAppDelegate`.

**Note Importante** : Le support officiel de Flutter pour tvOS est encore limité. Il est possible que certains plugins (comme `google_mobile_ads` ou `webview`) ne fonctionnent pas et empêchent la compilation. Vous devrez peut-être les exclure de la cible tvOS ou attendre des mises à jour de compatibilité.

### Changements déjà effectués
Le fichier `lib/utils/device_info.dart` a été mis à jour pour détecter si l'application tourne sur une Apple TV. Si c'est le cas :
- L'interface s'adaptera en mode paysage (960x540 points).
- La navigation sera optimisée pour une télécommande (si vous implémentez la gestion du focus).
