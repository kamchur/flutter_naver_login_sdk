package net.lagerstroemia.naver_login_sdk

import android.content.Context
import android.util.Log
import com.google.gson.Gson
import com.navercorp.nid.NaverIdLoginSDK
import com.navercorp.nid.oauth.NidOAuthLogin
import com.navercorp.nid.oauth.OAuthLoginCallback
import com.navercorp.nid.profile.NidProfileCallback
import com.navercorp.nid.profile.data.NidProfileResponse
import io.flutter.plugin.common.EventChannel

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
     *
     * Log)
     * E/Crape   (27017): onError code:-1, message:user_cancel
     * */
    suspend fun authenticate(context: Context, sink: EventChannel.EventSink?) {
        NaverIdLoginSDK.authenticate(context, callback = object : OAuthLoginCallback {
            override fun onError(errorCode: Int, message: String) {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError to arrayListOf<Any>(errorCode, message)))
            }

            override fun onFailure(httpStatus: Int, message: String) {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(httpStatus, message)))
            }

            override fun onSuccess() {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to null))
            }
        })
    }

    fun logout() {
        NaverIdLoginSDK.logout()
    }

    /**
     * Delete TokenAPI
     * */
    suspend fun release(sink: EventChannel.EventSink?) {
        Log.v("Crape", "release..")
        NidOAuthLogin().callDeleteTokenApi(callback = object : OAuthLoginCallback {
            override fun onError(errorCode: Int, message: String) {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError to arrayListOf<Any>(errorCode, message)))
            }

            override fun onFailure(httpStatus: Int, message: String) {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(httpStatus, message)))
            }

            override fun onSuccess() {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to null))
            }
        })
    }

    /**
     * Getting User Profile
     * */
    fun profile(sink: EventChannel.EventSink?) {
        Log.v("Crape", "profile..")
        NidOAuthLogin().callProfileApi(callback = object: NidProfileCallback<NidProfileResponse> {
            override fun onError(errorCode: Int, message: String) {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError to arrayListOf<Any>(errorCode, message)))
            }

            override fun onFailure(httpStatus: Int, message: String) {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(httpStatus, message)))
            }

            override fun onSuccess(result: NidProfileResponse) {
                val gson = Gson()

                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to arrayListOf<Any>(
                    result.resultCode.toString(),
                    result.message.toString(),
                    gson.toJson(result.profile!!)
                )))
            }
        })
    }
}