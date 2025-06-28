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

WORD_REGEX="[a-zA-Z0-9_-]*"

##### Android #####

# build.gradle daki bundle'lar değiştiriliyor.
FILE_PATH="android/app/build.gradle"
OLD_PART="applicationId = \"$WORD_REGEX\.$WORD_REGEX\.$WORD_REGEX\""
NEW_PART="applicationId = \"$BUNDLE_ID\""
sed -i '' "s/$OLD_PART/$NEW_PART/g" "$FILE_PATH"



##### iOS #####

# project.pbxproj daki bundle'lar değiştiriliyor.
FILE_PATH="ios/Runner.xcodeproj/project.pbxproj"
OLD_PART="PRODUCT_BUNDLE_IDENTIFIER = $WORD_REGEX\.$WORD_REGEX\.$WORD_REGEX;"
NEW_PART="PRODUCT_BUNDLE_IDENTIFIER = $BUNDLE_ID;"
sed -i '' "s/$OLD_PART/$NEW_PART/g" "$FILE_PATH"

OLD_PART="PRODUCT_BUNDLE_IDENTIFIER = $WORD_REGEX\.$WORD_REGEX\.$WORD_REGEX\.OneSignalNotificationServiceExtension;"
NEW_PART="PRODUCT_BUNDLE_IDENTIFIER = $BUNDLE_ID.OneSignalNotificationServiceExtension;"
sed -i '' "s/$OLD_PART/$NEW_PART/g" "$FILE_PATH"

OLD_PART="PRODUCT_BUNDLE_IDENTIFIER = $WORD_REGEX\.$WORD_REGEX\.$WORD_REGEX\.BroadcastExtension;"
NEW_PART="PRODUCT_BUNDLE_IDENTIFIER = $BUNDLE_ID.BroadcastExtension;"
sed -i '' "s/$OLD_PART/$NEW_PART/g" "$FILE_PATH"

OLD_PART="PRODUCT_BUNDLE_IDENTIFIER = $WORD_REGEX\.$WORD_REGEX\.$WORD_REGEX\.RunnerTests;"
NEW_PART="PRODUCT_BUNDLE_IDENTIFIER = $BUNDLE_ID.RunnerTests;"
sed -i '' "s/$OLD_PART/$NEW_PART/g" "$FILE_PATH"
