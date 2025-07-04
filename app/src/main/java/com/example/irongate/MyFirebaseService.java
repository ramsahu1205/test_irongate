package com.example.irongate;

import android.app.admin.DevicePolicyManager;
import android.content.ComponentName;

import androidx.annotation.NonNull;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import java.util.Map;

public class MyFirebaseService extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(@NonNull RemoteMessage remoteMessage) {
        Map<String, String> data = remoteMessage.getData();
        if ("true".equals(data.get("lock_device"))) {
            DevicePolicyManager dpm = (DevicePolicyManager) getSystemService(DEVICE_POLICY_SERVICE);
            ComponentName admin = new ComponentName(this, MyDeviceAdminReceiver.class);
            if (dpm.isAdminActive(admin)) {
                dpm.lockNow(); // Lock the device remotely
            }
        }
    }
}
