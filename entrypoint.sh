#!/bin/sh
echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 --decode > /app/keystore.p12
exec java -jar app.jar