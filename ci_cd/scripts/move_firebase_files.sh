ENVIRONMENT=$1


if [ "$ENVIRONMENT" == "dev" ]; then
    cp -f ci_cd/assets/firebase_files/dev/google-services.json android/app/
    cp -f ci_cd/assets/firebase_files/dev/GoogleService-Info.plist ios/Runner/
elif [ "$ENVIRONMENT" == "prod" ]; then
    cp -f ci_cd/assets/firebase_files/prod/google-services.json android/app/
    cp -f ci_cd/assets/firebase_files/prod/GoogleService-Info.plist ios/Runner/
else
    echo "Evironment değeri geçersiz. Geçerli değerler: dev, prod"
    exit 0
fi
