# ❓ FAQ TestFlight - Questions Fréquentes

Réponses aux questions les plus courantes sur TestFlight pour MyTV.

---

## 💰 Coûts et Abonnements

### Q : Combien coûte TestFlight ?
**R :** TestFlight est **100% GRATUIT**. Cependant, vous devez avoir un **compte Apple Developer** qui coûte **99$/an** (ou 99€/an selon votre région).

### Q : Puis-je utiliser TestFlight sans payer ?
**R :** **Non**. Le compte Apple Developer payant est **OBLIGATOIRE** pour utiliser TestFlight. Il n'y a aucune alternative gratuite pour la distribution bêta iOS officielle.

### Q : Le compte gratuit Apple ID suffit-il ?
**R :** **Non**. Un simple Apple ID gratuit ne donne pas accès à TestFlight. Vous devez vous inscrire au programme Apple Developer payant.

### Q : Y a-t-il des frais supplémentaires par testeur ?
**R :** **Non**. Une fois que vous avez le compte développeur, vous pouvez inviter jusqu'à **10 000 testeurs gratuitement**.

---

## 👥 Testeurs

### Q : Combien de testeurs puis-je avoir ?
**R :**
- **Testeurs internes** : Maximum 100 (membres de votre équipe App Store Connect)
- **Testeurs externes** : Maximum 10 000
- **Total** : 10 100 testeurs maximum

### Q : Quelle est la différence entre testeurs internes et externes ?
**R :**

| Aspect | Testeurs Internes | Testeurs Externes |
|--------|-------------------|-------------------|
| **Nombre max** | 100 | 10 000 |
| **Qui ?** | Membres de votre équipe | N'importe qui avec un email |
| **Approbation Apple** | ❌ Non | ✅ Oui (24-48h) |
| **Délai d'activation** | Immédiat | 24-48h |
| **Accès** | Automatique | Sur invitation |

### Q : Les testeurs doivent-ils payer quelque chose ?
**R :** **Non**. L'app TestFlight est gratuite sur l'App Store et vos testeurs n'ont rien à payer.

### Q : Les testeurs peuvent-ils être n'importe où dans le monde ?
**R :** **Oui**. TestFlight fonctionne dans tous les pays où l'App Store est disponible.

### Q : Puis-je retirer un testeur ?
**R :** **Oui**. Vous pouvez ajouter et retirer des testeurs à tout moment depuis App Store Connect.

---

## ⏱️ Durée et Limites

### Q : Combien de temps un build TestFlight reste-t-il disponible ?
**R :** **90 jours**. Après 90 jours, le build expire et les testeurs ne peuvent plus l'installer. Ils doivent mettre à jour vers un build plus récent.

### Q : Les testeurs doivent-ils réinstaller tous les 90 jours ?
**R :** **Non**. Si l'app est déjà installée, elle continue de fonctionner. Mais ils ne pourront pas installer un build expiré s'ils l'ont supprimé.

### Q : Combien de builds puis-je avoir actifs en même temps ?
**R :** **Illimité**. Vous pouvez avoir plusieurs builds actifs simultanément. Les testeurs peuvent choisir quelle version installer.

### Q : Combien de temps prend l'approbation Apple pour les testeurs externes ?
**R :** Généralement **24-48 heures**. Parfois plus rapide (quelques heures), rarement plus long (3-5 jours).

---

## 🔄 Mises à jour

### Q : Comment publier une mise à jour ?
**R :**
1. Incrémenter le Build Number dans Xcode
2. Créer une nouvelle archive (Product → Archive)
3. Uploader sur App Store Connect
4. Les testeurs sont **notifiés automatiquement**

### Q : Les testeurs doivent-ils accepter une nouvelle invitation pour les mises à jour ?
**R :** **Non**. Une fois qu'ils sont testeurs, ils reçoivent automatiquement toutes les mises à jour.

### Q : Puis-je forcer les testeurs à mettre à jour ?
**R :** **Non**. Les testeurs choisissent quand mettre à jour. Vous pouvez seulement les notifier qu'une nouvelle version est disponible.

---

## 📱 Compatibilité et Appareils

### Q : TestFlight fonctionne-t-il sur iPad ?
**R :** **Oui**. TestFlight fonctionne sur iPhone, iPad et Apple TV.

### Q : Puis-je tester sur Apple TV avec TestFlight ?
**R :** **Oui**. Vous pouvez distribuer des builds tvOS via TestFlight. Consultez [TVOS_SETUP.md](TVOS_SETUP.md) pour la configuration.

### Q : Combien d'appareils un testeur peut-il utiliser ?
**R :** **Illimité**. Un testeur peut installer l'app sur tous ses appareils iOS/iPadOS/tvOS.

### Q : Quelle version iOS minimale est supportée ?
**R :** Cela dépend de votre configuration Flutter. Vérifiez `ios/Podfile` pour le `platform :ios` minimum.

---

## 🔒 Sécurité et Confidentialité

### Q : Les testeurs peuvent-ils partager l'app avec d'autres ?
**R :** **Non**. L'app est liée au compte Apple ID du testeur. Elle ne peut pas être transférée.

### Q : Puis-je voir qui a installé l'app ?
**R :** **Oui**. Dans App Store Connect → TestFlight, vous voyez :
- Qui a accepté l'invitation
- Qui a installé l'app
- Quelle version ils utilisent
- Combien de sessions
- Rapports de crash

### Q : Les testeurs peuvent-ils voir le code source ?
**R :** **Non**. Ils reçoivent uniquement l'app compilée, comme sur l'App Store.

---

## 🐛 Problèmes Techniques

### Q : Mon build reste en "Processing" depuis des heures, est-ce normal ?
**R :** Oui, jusqu'à **2 heures** c'est normal. Si après **24 heures** rien ne change :
1. Vérifiez vos emails pour des messages d'Apple
2. Vérifiez App Store Connect pour des erreurs
3. Contactez le support Apple Developer

### Q : J'ai une erreur "No signing certificate found"
**R :**
1. Vérifiez que vous avez créé un certificat de distribution
2. Téléchargez-le et double-cliquez pour l'installer
3. Dans Xcode : Preferences → Accounts → Download Manual Profiles

### Q : "Provisioning profile doesn't match"
**R :**
1. Vérifiez que le Bundle ID est identique partout
2. Re-téléchargez le profil de provisionnement
3. Dans Xcode, sélectionnez manuellement le bon profil

### Q : Les testeurs ne reçoivent pas l'email d'invitation
**R :**
1. Vérifiez les spams/courrier indésirable
2. Renvoyez l'invitation depuis App Store Connect
3. Vérifiez que l'email est correct
4. Pour testeurs externes, donnez-leur le lien public

### Q : "Missing Compliance" - Qu'est-ce que c'est ?
**R :** Apple demande si votre app utilise du chiffrement. Pour la plupart des apps :
- **Question** : "Votre app utilise-t-elle le chiffrement ?"
- **Réponse** : Si vous utilisez HTTPS → "Yes"
- **Puis** : "No, it only uses encryption for standard purposes"

---

## 📊 Données et Analytics

### Q : Puis-je voir combien de personnes utilisent l'app ?
**R :** **Oui**. App Store Connect → TestFlight → Metrics vous montre :
- Nombre d'installations
- Nombre de sessions
- Durée des sessions
- Crashes
- Feedback

### Q : Les crashs sont-ils rapportés automatiquement ?
**R :** **Oui**. Les rapports de crash sont envoyés automatiquement à App Store Connect.

### Q : Les testeurs peuvent-ils envoyer du feedback ?
**R :** **Oui**. Dans l'app TestFlight ou en secouant l'appareil pendant l'utilisation de votre app.

---

## 🚀 Publication sur l'App Store

### Q : Après TestFlight, comment publier sur l'App Store ?
**R :**
1. Préparez les métadonnées (captures d'écran, description, etc.)
2. Dans App Store Connect, créez une nouvelle version
3. Sélectionnez le build TestFlight que vous voulez publier
4. Soumettez pour révision Apple
5. Une fois approuvé, publiez !

### Q : Puis-je utiliser le même build TestFlight pour l'App Store ?
**R :** **Oui**. Vous pouvez sélectionner n'importe quel build TestFlight pour la publication sur l'App Store.

### Q : Dois-je arrêter TestFlight quand je publie sur l'App Store ?
**R :** **Non**. Vous pouvez continuer à utiliser TestFlight pour tester de nouvelles versions pendant que l'app est sur l'App Store.

---

## 🌍 Régions et Langues

### Q : Puis-je limiter TestFlight à certains pays ?
**R :** **Non** pour les testeurs internes. **Oui** pour les testeurs externes (vous pouvez sélectionner des régions).

### Q : L'app TestFlight est-elle disponible en français ?
**R :** **Oui**. TestFlight est disponible dans de nombreuses langues, dont le français.

### Q : Dois-je traduire mon app pour TestFlight ?
**R :** **Non**. Vous pouvez tester dans n'importe quelle langue. Les traductions sont optionnelles.

---

## 💡 Bonnes Pratiques

### Q : Combien de testeurs devrais-je inviter ?
**R :** Recommandation :
- **Phase 1** : 5-10 testeurs internes (votre équipe)
- **Phase 2** : 20-50 testeurs externes (early adopters)
- **Phase 3** : 100-500 testeurs (bêta publique)

### Q : À quelle fréquence devrais-je publier des mises à jour ?
**R :** Recommandation :
- **Développement actif** : 1-2 fois par semaine
- **Stabilisation** : 1 fois toutes les 2 semaines
- **Pré-lancement** : Seulement pour les bugs critiques

### Q : Dois-je communiquer avec mes testeurs ?
**R :** **Oui, fortement recommandé** :
- Expliquez ce qui doit être testé
- Demandez du feedback spécifique
- Remerciez-les pour leur aide
- Informez-les des changements dans chaque version

---

## 🔧 Alternatives

### Q : Y a-t-il des alternatives à TestFlight ?
**R :** Oui, mais avec des limitations :
- **Ad-Hoc Distribution** : Limité à 100 appareils, nécessite les UDID
- **Enterprise Distribution** : Seulement pour les grandes entreprises (299$/an)
- **Services tiers** : Firebase App Distribution, etc. (mais moins intégrés)

**TestFlight reste la solution recommandée par Apple.**

### Q : Puis-je utiliser TestFlight ET une autre solution ?
**R :** **Oui**. Vous pouvez utiliser plusieurs méthodes de distribution simultanément.

---

## 📞 Support

### Q : Où puis-je obtenir de l'aide ?
**R :**
- **Documentation locale** :
  - [TESTFLIGHT_GUIDE.md](TESTFLIGHT_GUIDE.md) - Guide complet
  - [TESTFLIGHT_QUICKSTART.md](TESTFLIGHT_QUICKSTART.md) - Démarrage rapide
  - [TESTFLIGHT_CHECKLIST.md](TESTFLIGHT_CHECKLIST.md) - Checklist
  
- **Support Apple** :
  - [developer.apple.com/support](https://developer.apple.com/support/)
  - [developer.apple.com/testflight](https://developer.apple.com/testflight/)
  
- **Communauté** :
  - Forums Apple Developer
  - Stack Overflow
  - Reddit r/iOSProgramming

### Q : Puis-je contacter Apple directement ?
**R :** **Oui**. Avec un compte Apple Developer payant, vous avez accès au support technique via :
- Email
- Téléphone (dans certains pays)
- Forums développeurs

---

## 🎓 Apprentissage

### Q : Où puis-je apprendre plus sur TestFlight ?
**R :**
- **Documentation officielle** : [developer.apple.com/testflight](https://developer.apple.com/testflight/)
- **WWDC Sessions** : Recherchez "TestFlight" sur [developer.apple.com/videos](https://developer.apple.com/videos/)
- **Guides Apple** : App Store Connect Help

### Q : Y a-t-il des vidéos tutoriels ?
**R :** **Oui**. Recherchez sur YouTube :
- "TestFlight tutorial"
- "How to use TestFlight"
- "iOS beta testing with TestFlight"

---

## 🎯 Cas d'Usage

### Q : TestFlight est-il adapté pour une petite équipe ?
**R :** **Oui, parfaitement**. Même avec 2-3 testeurs, TestFlight est utile.

### Q : Puis-je utiliser TestFlight pour tester en interne uniquement ?
**R :** **Oui**. Vous n'êtes pas obligé d'inviter des testeurs externes.

### Q : TestFlight est-il adapté pour une bêta publique ?
**R :** **Oui**. Vous pouvez inviter jusqu'à 10 000 testeurs externes.

### Q : Puis-je utiliser TestFlight pour des tests A/B ?
**R :** **Partiellement**. Vous pouvez avoir plusieurs builds actifs, mais TestFlight n'a pas de fonctionnalités A/B intégrées.

---

## 🔮 Futur

### Q : Que se passe-t-il après les 90 jours ?
**R :** Le build expire. Vous devez publier un nouveau build (même si c'est la même version, juste re-uploadée).

### Q : Puis-je garder TestFlight indéfiniment ?
**R :** **Oui**. Tant que vous payez le compte développeur (99$/an) et que vous uploadez de nouveaux builds tous les 90 jours.

### Q : Dois-je éventuellement publier sur l'App Store ?
**R :** **Non**. Vous pouvez rester sur TestFlight indéfiniment si vous le souhaitez (mais ce n'est pas l'usage prévu).

---

**Vous avez d'autres questions ?**

Consultez :
- 📖 [TESTFLIGHT_GUIDE.md](TESTFLIGHT_GUIDE.md) pour le guide complet
- ⚡ [TESTFLIGHT_QUICKSTART.md](TESTFLIGHT_QUICKSTART.md) pour démarrer rapidement
- ✅ [TESTFLIGHT_CHECKLIST.md](TESTFLIGHT_CHECKLIST.md) pour suivre votre progression

Ou contactez le support Apple Developer : [developer.apple.com/support](https://developer.apple.com/support/)
