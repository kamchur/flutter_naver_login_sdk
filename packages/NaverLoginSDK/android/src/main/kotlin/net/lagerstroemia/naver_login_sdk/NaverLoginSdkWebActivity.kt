package net.lagerstroemia.naver_login_sdk

import android.app.Activity
import android.os.Bundle
import com.navercorp.nid.NidOAuth
import com.navercorp.nid.oauth.util.NidOAuthCallback
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
        NidOAuth.requestLogin(this, callback = object: NidOAuthCallback {
            override fun onSuccess() {
                loginEventListener?.onReceive(NaverLoginState.SUCCESS)
                finishAffinity()
            }

            override fun onFailure(errorCode: String, errorDesc: String) {
                loginEventListener?.onReceive(NaverLoginState.FAILURE, code = errorCode, message = errorDesc)
                finishAffinity()
            }
        })
    }

//    override fun onDestroy() {
//        loginEventListener = null
//
//        super.onDestroy()
//    }
}