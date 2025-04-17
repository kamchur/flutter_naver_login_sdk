package net.lagerstroemia.naver_login_sdk

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import com.navercorp.nid.NaverIdLoginSDK
import com.navercorp.nid.oauth.OAuthLoginCallback
import io.flutter.embedding.android.FlutterActivity
import net.lagerstroemia.naver_login_sdk.api.NaverLoginEventListener
import net.lagerstroemia.naver_login_sdk.api.NaverLoginState

// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.EventChannel

/**
 * 2025-04-17 Thu
 * taskAffinity="" bug solved/
 * */
class NaverLoginSdkWebActivity: Activity() {
    private var loginEventListener: NaverLoginEventListener? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        loginEventListener = NaverLoginSdkBridge.loginEventListener

        NaverIdLoginSDK.authenticate(this, callback = object: OAuthLoginCallback {
            override fun onError(errorCode: Int, message: String) {
                loginEventListener?.onReceive(NaverLoginState.ERROR, errorCode, message)
                finishAffinity()
            }

            override fun onFailure(httpStatus: Int, message: String) {
                loginEventListener?.onReceive(NaverLoginState.FAILURE, httpStatus, message)
                finishAffinity()
            }

            override fun onSuccess() {
                loginEventListener?.onReceive(NaverLoginState.SUCCESS)
                finishAffinity()
            }
        })
    }
}