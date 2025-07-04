pluginManagement {
    repositories {
        google()  // ✅ Required for AGP plugins like com.android.application
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "irongate"
include(":app")
 