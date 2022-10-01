![InPrize](/public/Header.png)

🎁 InPrize is a free Instagram giveaway randomizer.

It is very easy to use! Log into your Facebook account, select a post from the feed, and click "Choose a Winner". You will be shown a randomly selected comment. The commenter's profile on Instagram can be opened by clicking the "Open Profile" button.

❕ To use this app, you must link your Instagram business account to your Facebook account.

[![Google Play](/public/GooglePlay.png)](https://play.google.com/store/apps/details?id=com.gugdun.inprize)

## 🔨 Build
1. Create file `res/values/strings.xml`:
~~~ XML
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="google_app_id">YOUR_GOOGLE_APP_ID</string>
    <string name="facebook_app_id">YOUR_FACEBOOK_APP_ID</string>
    <string name="facebook_client_token">YOUR_FACEBOOK_CLIENT_TOKEN</string>
</resources>
~~~
2. Create file `lib/appodeal_key.dart`:
~~~ Dart
const appKey = 'YOUR_APPODEAL_APP_KEY';
~~~
3. Run `flutter pub get`
4. Run `flutter build apk --release`

## 🏃‍♂️ Run
Run InPrize in debug mode:
~~~ Bash
flutter run -d DEVICE_ID --debug
~~~
