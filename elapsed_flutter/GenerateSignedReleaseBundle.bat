start pubspec.yaml
PAUSE
CALL flutter build appbundle --obfuscate --split-debug-info=/elapsed_flutter/output_debug_files
move /Y .\build\app\outputs\bundle\release\app-release.aab .
start .
:End
PAUSE