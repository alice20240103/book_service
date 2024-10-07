#!/bin/sh
echo "${{ secrets.KEYSTORE }}" | base64 --decode > /app/keystore.p12
exec java -jar app.jar