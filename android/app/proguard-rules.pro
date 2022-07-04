-ignorewarnings                     # 忽略警告，避免打包时某些警告出现
-optimizationpasses 5               # 指定代码的压缩级别
-dontusemixedcaseclassnames         # 是否使用大小写混合
-dontskipnonpubliclibraryclasses    # 是否混淆第三方jar
-dontpreverify                      # 混淆时是否做预校验
-verbose                            # 混淆时是否记录日志
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*        # 混淆时所采用的算法


## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
-dontwarn com.tencent.bugly.**
-dontwarn com.umeng.**
-dontwarn com.taobao.**
-dontwarn anet.channel.**
-dontwarn anetwork.channel.**
-dontwarn org.android.**
-dontwarn org.apache.thrift.**
-dontwarn com.xiaomi.**
-dontwarn com.huawei.**
-dontwarn com.meizu.**

-keepattributes *Annotation*

-keep class com.taobao.** {*;}
-keep class org.android.** {*;}
-keep class anet.channel.** {*;}
-keep class com.umeng.** {*;}
-keep class com.xiaomi.** {*;}
-keep class com.huawei.** {*;}
-keep class com.meizu.** {*;}
-keep class org.apache.thrift.** {*;}

-keep class com.alibaba.sdk.android.**{*;}
-keep class com.ut.**{*;}
-keep class com.ta.**{*;}

-keep public class **.R$*{
   public static final int *;
}

-dontwarn com.tencent.bugly.**
-keep public class com.tencent.bugly.**{*;}

# tinker混淆规则
-dontwarn com.tencent.tinker.**
-keep class com.tencent.tinker.** { *; }


 #小米push
-keep class org.android.agoo.xiaomi.MiPushBroadcastReceiver {*;}
#可以防止一个误报的 warning 导致无法成功编译，如果编译使用的 Android 版本是 23。
-dontwarn com.xiaomi.push.**

 #华为push
 -ignorewarnings
 -keepattributes *Annotation*
 -keepattributes Exceptions
 -keepattributes InnerClasses
 -keepattributes Signature
 -keepattributes SourceFile,LineNumberTable
 -keep class com.hianalytics.android.**{*;}
 -keep class com.huawei.updatesdk.**{*;}
 -keep class com.huawei.hms.**{*;}


 #oppo push
 -keep public class * extends android.app.Service

 # vivo push
 -dontwarn com.vivo.push.**
 -keep class com.vivo.push.**{*; }
 -keep class com.vivo.vms.**{*; }
 -keep class xxx.xxx.xxx.PushMessageReceiverImpl{*;}

 # 一键登录
 -keep class com.umeng.umverify.** {*;}
 -keep class cn.com.chinatelecom.gateway.lib.** {*;}
 -keep class com.unicom.xiaowo.login.** {*;}
 -keep class com.cmic.sso.sdk.** {*;}
 -keep class com.mobile.auth.** {*;}
 -keep class android.support.v4.** { *;}
 -keep class org.json.**{*;}
 -keep class com.alibaba.fastjson.** {*;}
 -keep class com.umeng.** {*;}

 -keepclassmembers class * {
    public <init> (org.json.JSONObject);
 }

 -keepclassmembers enum * {
     public static **[] values();
     public static ** valueOf(java.lang.String);
 }
