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

# AppEnvironment.dart daki selected değiştiriliyor.
FILE_PATH="lib/src/common/enums/app_environment.dart"
OLD_PART="static AppEnvironment get selected => AppEnvironment.$WORD_REGEX;"
NEW_PART="static AppEnvironment get selected => AppEnvironment.$APP_ENVIRONMENT;"
sed -i '' "s/$OLD_PART/$NEW_PART/g" "$FILE_PATH"