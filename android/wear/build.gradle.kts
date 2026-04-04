plugins {
    id("com.android.application")
    id("kotlin-android")
}

android {
    namespace = "com.fitkarma.fitkarma"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.fitkarma.fitkarma"
        minSdk = 26 // Wear OS 2.0
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }
}

dependencies {
    implementation("com.google.android.gms:play-services-wearable:18.1.0")
    implementation("androidx.wear:wear:1.3.0")
    implementation("androidx.wear.tiles:tiles:1.2.0")
    implementation("androidx.wear.watchface:watchface-complications-data-source:1.2.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.2")
    implementation("androidx.core:core-ktx:1.12.0")
}
