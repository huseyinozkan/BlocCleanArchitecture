ENVIRONMENT=$1

# .env dosyasını yükle
if [ "$ENVIRONMENT" == "dev" ]; then
    set -a
    source ci_cd/env/dev.env
    set +a
elif [ "$ENVIRONMENT" == "prod" ]; then
    set -a
    source ci_cd/env/prod.env
    set +a
else
    echo "Evironment değeri geçersiz. Geçerli değerler: dev, prod"
    exit 0
fi


WORD_REGEX="[[:alnum:][:punct:]_ -]*"

# AndroidManifest.xml daki android:label değiştiriliyor.
FILE_PATH="android/app/src/main/AndroidManifest.xml"
OLD_PART="android:label=\"$WORD_REGEX\""
NEW_PART="android:label=\"$APP_NAME\""
sed -i '' "s/$OLD_PART/$NEW_PART/g" "$FILE_PATH"


# info.plist daki CFBundleDisplayName değiştiriliyor.
FILE_PATH="ios/Runner/Info.plist"
perl -0777 -i -pe "s|(\t<key>CFBundleDisplayName</key>\n\t<string>)[^<]*(</string>)|\1$APP_NAME\2|g" "$FILE_PATH"
