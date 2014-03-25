App42-Push-Notification-on-Flash-Android
=========================================
# About Application

1. This application shows how can you integrate PushNotification using App42 ActionScript API in Flash Android application.
2. How we can send PushNotification using App42 Action-Script PushNotification API.


# Running Sample

This is a sample Android app is made by using App42 Action-Script API. It uses PushNotification API of App42 platform.
Here are the few easy steps to run this sample app.

1. [Register] (https://apphq.shephertz.com/register) with App42 platform.
2. Create an app once, you are on Quick start page after registration.
3. If you are already registered, login to [AppHQ] (http://apphq.shephertz.com) console and create an app from App Manager Tab.
4. To use PushNotification service in your application open [link] (https://code.google.com/apis/console/b/0/?noredirect&pli=1) and create a new project here.
5. Click on services option in Google console and enable Google Cloud Messaging for Android service.
6. Click on API Access tab and create a new server key for your application with blank server information.
7. Go to [AppHQ] (http://apphq.shephertz.com) console and click on PushNotification and select Android Settings in Settings option.
8. Select your app and copy server key that is generated by using Google API console in step 6, and submit it.
9. Download the project from [here] (https://github.com/VishnuGShephertz/App42-Push-Notification-on-Flash-Android/archive/master.zip) and import it in your FlashBuiler.
10. Open App42Constants.as file of sample project and make following changes.

```
A. Replace api-Key and secret-Key that you have received in step 2 or 3 at line number 5 and 6.
B. Replace project-no with your Google Project Number at line number 7.
C. Replace your user-id by which you want to register your application for PushNotification at line number 8.
```
11. Adding Android Native Extension.

```
A. Open Flex Build path and add app42Push.ane file and Native Extension in your Sample project if not added.
B. Open Flex Build packaging by selecting project properties, click on Google Android and select Native Extension and checked your Native Extension added in prior step.
```
11.Build your android application and install on your android device.

__Test and verify PushNotification from AppHQ console__
 
```
A. After registering for PushNotification go to AppHQ console and click on PushNotification and select
  application after selecting User tab.
B. Select desired user from registered User-list and click on Send Message Button.
C. Send appropriate message to user by clicking Send Button.

```
# Design Details:
__Initializing App42API in ActionScript to send PushNotification :__ To Send PushNotification using APP42 ActionScript API you have to initialize first using Api-Key and Secret-Key written in App42FlashHome.mxml file.
 
```
    private function intializeApi():void
            {
                App42API.initialize(AppConstants.ApiKey,AppConstants.SecretKey);
                App42API.setLoggedInUser(AppConstants.UserId);
                App42Log.setDebug(true);
            }

```

__Registering on GCM for PushNotification in Android:__ To get PushNotification you have to register on GCM using Google Project No written in App42FlashHome.mxml file.
 
```
            app42Push.register(AppConstants.ProjectNo);

```
__Registering Device on App42:__ This function store device token on App42 using ActionScript API ,when we get registration event from Android Native written in App42FlashHome.mxml file.

```
   private function onRegistered(event:App42RegistrationEvent):void
            {
                trace("Registered with registration id:", event.registrationId);
                // Storing registration id received from C2DM service
                persistence.setProperty("registration_id", event.registrationId);
                App42API.buildPushNotificationService().storeDeviceToken(App42API.getLoggedInUser(),
                event.registrationId,DeviceType.ANDROID,new App42FlashCallback());
                registered = true;
            }

```


__Send PushNotification to User using ActionScript App42 API :__ If you want to send PushNotification message using App42 ActionScript API ,pass the userId and message,title and image you want to shown when Push Notification arrives on device , written in App42FlashHome.mxml file.
 
```
  	private function onSendPushClick(event:MouseEvent):void
			{
				var jsonMessage:Object = new Object();
				jsonMessage.title = "App42FlashPush";
				jsonMessage.message = messageInput.text;
				jsonMessage.image = "Your Image Url";
				var message:String =  JSON.stringify(jsonMessage);
              App42API.buildPushNotificationService().sendPushMessageToUser(UserInput.text,message,
				  new App42FlashCallback());
			}

```

__Customize Push Title accordingly:__ If you want to show default title in nPush Notification please change in  App42FlashPush-app.xml file at line no 244 and now you have no need to pass title with message.
 
```
  	  <meta-data android:name="push_title" android:value="App42FlashPush"/>

```

__Customization Push Message:__ If you want to show your own image and title on Push Notification , You have to send Push Mesaage String as JsonObject in following format.
 
```
    {"message":"HI I am using App42 Push Notification","image":"Your Image Url","title":"App42FlashPush"}

```

__Customization according to your application Package:__ If you are customizing your own Android Flash application that is built using Flash.
So open App42FlashPush-app.xml file and make these changes.

1. Add following manifest component in your app.xml file.

```
 <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
                <permission
        android:name="air.com.shephertz.app42.push.permission.C2D_MESSAGE"
        android:protectionLevel="signature" />
    <uses-permission android:name="air.com.shephertz.app42.push.permission.C2D_MESSAGE" />
     <uses-permission android:name="android.permission.WAKE_LOCK" />
    <!-- GCM requires a Google account. -->
    <uses-permission android:name="android.permission.GET_ACCOUNTS" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.HARDWARE_TEST" />
    <uses-permission android:name="android.permission.VIBRATE" />
        <application>
                <receiver
            android:name="com.shephertz.app42.android.flash.push.App42GCMReceiver"
            android:permission="com.google.android.c2dm.permission.SEND" >
            <intent-filter>

                <!-- Receives the actual messages. -->
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
                <!-- Receives the registration id. -->
                <action android:name="com.google.android.c2dm.intent.REGISTRATION" />
                <category android:name="air.com.shephertz.app42.push" />
            </intent-filter>
        </receiver>
        <service android:name="com.shephertz.app42.android.flash.push.App42GCMService" >
        </service>
        <meta-data android:name="push_title" android:value="App42FlashPush"/>
    </application>

```

2.Replace "com.shephertz.app42.push" with your application package name in App42FlashPush-app.xml file of Sample project.

__Customization of ANE(Android Native Extension):__ If you want to customize ANE(Android Native Extension) accordingly ,[here](https://github.com/VishnuGShephertz/App42-Push-Ane-Source) is ANE source code to build ANE according to your use cases.
