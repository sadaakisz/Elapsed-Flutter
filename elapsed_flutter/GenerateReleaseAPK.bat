CALL flutter build apk --split-per-abi --no-shrink
move /Y .\build\app\outputs\apk\release\app-armeabi-v7a-release.apk .
start .
:End
PAUSE