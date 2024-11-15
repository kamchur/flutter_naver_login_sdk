package net.lagerstroemia.naver_login_sdk

import android.content.Context
import android.util.Log
import com.navercorp.nid.NaverIdLoginSDK
import com.navercorp.nid.oauth.NidOAuthLogin
import com.navercorp.nid.oauth.OAuthLoginCallback
import com.navercorp.nid.profile.NidProfileCallback
import com.navercorp.nid.profile.data.NidProfileResponse

object NaverLoginSdkBridge {
    fun initialize(context: Context, args: Any) {
        Log.d("Crape", "NaverLoginSdkBridge.. initialize..")
        val params: Map<String, String>? = (args as? Map<*, *>?)?.entries
            ?.associate { element -> element.key.toString() to element.value.toString() }
            ?.toMutableMap()

        params?.let {
            val clientId: String = params[NaverLoginSdkConstant.Value.clientId]!!
            val clientSecret: String = params[NaverLoginSdkConstant.Value.clientSecret]!!
            val clientName: String = params[NaverLoginSdkConstant.Value.clientName]!!

            NaverIdLoginSDK.initialize(context, clientId, clientSecret, clientName)
        }
    }

    /**
     * Login
     * Access Token
     *
     * User Cancel result message:
     * E/Crape   (27017): onError code:-1, message:user_cancel
     * */
    suspend fun authenticate(context: Context) {
        NaverIdLoginSDK.authenticate(context, callback = object : OAuthLoginCallback {
            override fun onError(errorCode: Int, message: String) {
                Log.e("Crape", "onError code:$errorCode, message:$message")
            }

            override fun onFailure(httpStatus: Int, message: String) {
                Log.w("Crape", "onFailure status:$httpStatus, message:$message")
            }

            override fun onSuccess() {
                Log.i("Crape", "onSuccess")
            }
        })
    }

    fun logout() {
        NaverIdLoginSDK.logout()
    }

    /**
     * 연동해제
     * */
    fun release() {
        NidOAuthLogin().callDeleteTokenApi(callback = object : OAuthLoginCallback {
            override fun onError(errorCode: Int, message: String) {
                TODO("Not yet implemented")
            }

            override fun onFailure(httpStatus: Int, message: String) {
                TODO("Not yet implemented")
            }

            override fun onSuccess() {
                TODO("Not yet implemented")
            }

        })
    }

    fun profile() {
        NidOAuthLogin().callProfileApi(callback = object: NidProfileCallback<NidProfileResponse> {
            override fun onError(errorCode: Int, message: String) {
                TODO("Not yet implemented")
            }

            override fun onFailure(httpStatus: Int, message: String) {
                TODO("Not yet implemented")
            }

            override fun onSuccess(result: NidProfileResponse) {
                TODO("Not yet implemented")
            }

        })
    }
}