plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // El plugin de Flutter debe ir después de Android y Kotlin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.whoami_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Compatibilidad con Java 11 y soporte para desugaring
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.whoami_app"

        // Requerido por flutter_inappwebview y WebView moderno
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // 🔧 Configuración de los tipos de compilación
    buildTypes {
        // --- MODO RELEASE ---
        getByName("release") {
            // Firma temporal (usa la de debug para pruebas)
            signingConfig = signingConfigs.getByName("debug")

            // ✅ Habilita ProGuard/R8 con reglas personalizadas
            isMinifyEnabled = true
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }

        // --- MODO DEBUG ---
        getByName("debug") {
            // Desactiva el shrinker para evitar errores en desarrollo
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Soporte biométrico
    implementation("androidx.biometric:biometric:1.2.0-alpha05")

    // Desugaring requerido por flutter_local_notifications
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
