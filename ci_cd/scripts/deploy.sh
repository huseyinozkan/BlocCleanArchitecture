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

echo "APP_ENVIRONMENT: $APP_ENVIRONMENT"
echo "APP_NAME: $APP_NAME"
echo "BUNDLE_ID: $BUNDLE_ID"
echo "LAUNCHER_IMAGE: $LAUNCHER_IMAGE"


sh ci_cd/scripts/move_firebase_files.sh "$ENVIRONMENT"
sh ci_cd/scripts/replace_app_environment.sh "$ENVIRONMENT"
sh ci_cd/scripts/replace_app_name.sh "$ENVIRONMENT"
sh ci_cd/scripts/replace_bundle_id.sh "$ENVIRONMENT"
sh ci_cd/scripts/replace_launcher_icon_image.sh "$ENVIRONMENT"