// android_wear/build.gradle.kts
// Wear OS app build configuration

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.devtools.ksp") version "1.9.22-1.0.17"
}

android {
    namespace = "com.fitkarma.wear"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.fitkarma.wear"
        minSdk = 30
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"

        vectorDrawables {
            useSupportLibrary = true
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildFeatures {
        compose = true
    }

    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.8"
    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    // Wear OS Core
    implementation("androidx.wear:wearable:2.21.0")
    implementation("androidx.wear:wearable:wearable:2.21.0")
    implementation("com.google.android.gms:play-services-wearable:18.1.0")

    // Compose for Wear OS
    implementation(platform("androidx.compose:compose-bom:2024.01.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material:material")
    implementation("androidx.compose.material:material-icons-extended")

    // Wear OS tiles
    implementation("androidx.wear.tiles:tiles:1.3.0")
    implementation("androidx.wear.tiles:tiles-proto:1.3.0")

    // Wear OS complications
    implementation("androidx.wear.complications:complications:1.3.0")

    // Horizon (for background)
    implementation("androidx.horologist:horologist-compose:0.4.0")

    // Location services for GPS workouts
    implementation("com.google.android.gms:play-services-location:21.1.0")

    // DataStore for local storage
    implementation("androidx.datastore:datastore-preferences:1.0.0")

    // Kotlin coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")

    // Debug
    debugImplementation("androidx.compose.ui:ui-tooling")
    debugImplementation("androidx.compose.ui:ui-test-manifest")
}
