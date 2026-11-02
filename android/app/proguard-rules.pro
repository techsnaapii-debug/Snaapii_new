# Flutter Wrapper rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.provider.** { *; }
-keep class io.flutter.plugins.** { *; }

-dontwarn io.flutter.embedding.**
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# Keep Flutter engine JNI native methods
-keepclasseswithmembernames class * {
    native <methods>;
}
