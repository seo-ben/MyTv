@echo off
REM Script de Test et Build pour Android TV - MyTelevision
REM Date: 2025-12-27

echo.
echo ========================================
echo 🚀 MyTelevision - Android TV Build Script
echo ========================================
echo.

REM 1. Nettoyage
echo 📦 Étape 1/5 : Nettoyage du projet...
call flutter clean
if %errorlevel% neq 0 (
    echo ✗ Erreur lors du nettoyage
    exit /b 1
)
echo ✓ Nettoyage terminé
echo.

REM 2. Récupération des dépendances
echo 📥 Étape 2/5 : Récupération des dépendances...
call flutter pub get
if %errorlevel% neq 0 (
    echo ✗ Erreur lors de la récupération des dépendances
    exit /b 1
)
echo ✓ Dépendances récupérées
echo.

REM 3. Analyse du code
echo 🔍 Étape 3/5 : Analyse du code...
call flutter analyze
if %errorlevel% neq 0 (
    echo ⚠ Analyse terminée avec des warnings (non bloquants)
) else (
    echo ✓ Analyse terminée sans erreur
)
echo.

REM 4. Build APK de test
echo 🔨 Étape 4/5 : Build APK de test...
call flutter build apk --debug
if %errorlevel% neq 0 (
    echo ✗ Erreur lors du build APK de test
    exit /b 1
)
echo ✓ APK de test créé : build\app\outputs\flutter-apk\app-debug.apk
echo.

REM 5. Build AAB de production (optionnel)
set /p BUILD_AAB="Voulez-vous générer l'AAB de production ? (o/N) "
if /i "%BUILD_AAB%"=="o" (
    echo 🏗️  Étape 5/5 : Build AAB de production...
    call flutter build appbundle --release
    if %errorlevel% neq 0 (
        echo ✗ Erreur lors du build AAB de production
        exit /b 1
    )
    echo ✓ AAB de production créé : build\app\outputs\bundle\release\app-release.aab
    echo.
    echo ==========================================
    echo ✅ BUILD TERMINÉ AVEC SUCCÈS !
    echo ==========================================
    echo.
    echo 📦 Fichiers générés :
    echo   - APK de test : build\app\outputs\flutter-apk\app-debug.apk
    echo   - AAB de production : build\app\outputs\bundle\release\app-release.aab
    echo.
    echo 📝 Prochaines étapes :
    echo   1. Testez l'APK sur un émulateur Android TV
    echo   2. Vérifiez la navigation D-pad
    echo   3. Uploadez l'AAB sur Google Play Console
    echo.
) else (
    echo.
    echo ==========================================
    echo ✅ BUILD DE TEST TERMINÉ !
    echo ==========================================
    echo.
    echo 📦 Fichier généré :
    echo   - APK de test : build\app\outputs\flutter-apk\app-debug.apk
    echo.
    echo 📝 Pour générer l'AAB de production plus tard :
    echo   flutter build appbundle --release
    echo.
)

REM Instructions finales
echo 📚 Documentation disponible :
echo   - ANDROID_TV_FIXES.md (résumé)
echo   - ANDROID_TV_TEST_GUIDE.md (guide de test)
echo   - ANDROID_TV_CHANGES_SUMMARY.md (détails techniques)
echo.
echo 🎮 Pour tester sur émulateur Android TV :
echo   flutter run
echo   (puis sélectionnez l'émulateur Android TV)
echo.
pause
