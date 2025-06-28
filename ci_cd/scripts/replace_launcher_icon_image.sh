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

# pubspec.yaml daki image_path değiştiriliyor ve icons_launcher:create komutu çalıştırılıyor.
FILE_PATH="pubspec.yaml"
START_WITH="  image_path: \"ci_cd/assets/"
NEW_STRING="  image_path: \"ci_cd/assets/$LAUNCHER_IMAGE\""
sed -i '' "s#^$START_WITH.*#$NEW_STRING#g" "$FILE_PATH"

flutter pub get
dart run icons_launcher:create