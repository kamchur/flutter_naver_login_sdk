package net.lagerstroemia.naver_login_sdk

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import com.google.gson.Gson
import com.navercorp.nid.NaverIdLoginSDK
import com.navercorp.nid.oauth.NidOAuthBehavior
import com.navercorp.nid.oauth.NidOAuthLogin
import com.navercorp.nid.oauth.OAuthLoginCallback
import com.navercorp.nid.profile.NidProfileCallback
import com.navercorp.nid.profile.data.NidProfileResponse
import io.flutter.plugin.common.EventChannel
import net.lagerstroemia.naver_login_sdk.api.NaverLoginSdkProtocol
import net.lagerstroemia.naver_login_sdk.NaverLoginSdkWebActivity
import net.lagerstroemia.naver_login_sdk.api.NaverLoginEventListener
import net.lagerstroemia.naver_login_sdk.api.NaverLoginState

object NaverLoginSdkBridge: NaverLoginSdkProtocol {
    /**
     * 2025-04-17-Thu
     *
     * Fixed for Naver OAuth Login
     * */
    var loginEventListener: NaverLoginEventListener? = null

    fun initialize(context: Context, args: Any) {
        // Log.d("Crape", "NaverLoginSdkBridge.. initialize..")
        val params: Map<String, String>? = (args as? Map<*, *>?)?.entries
            ?.associate { element -> element.key.toString() to element.value.toString() }
            ?.toMutableMap()

        params?.let {
            val clientId: String = params[NaverLoginSdkConstant.Value.clientId]!!
            val clientSecret: String = params[NaverLoginSdkConstant.Value.clientSecret]!!
            val clientName: String = params[NaverLoginSdkConstant.Value.clientName]!!

            NaverIdLoginSDK.initialize(context, clientId, clientSecret, clientName)

            /**
             * 2025-01-02-Thu,
             * Naver 5.10.0 execute only in NAVER APP.
             *
             * Web Browser is not stable.
             *
             * return: NAVER APP not installed in device message.
             * you can apply to user show dialog.
             *
             * Current [behavior] use only 'NAVERAPP'.
             * */
            NaverIdLoginSDK.behavior = NidOAuthBehavior.DEFAULT;
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
     *
     *
     * 2025-01-02-Thu,
     * - NaverAPP not installed: "기기에 네이버앱이 없습니다."
     * - NaverAPP need update: "네이버앱 업데이트가 필요합니다."
     * */
    suspend fun authenticate(activity: Activity, sink: EventChannel.EventSink?) {
        loginEventListener = object: NaverLoginEventListener {
            override fun onReceive(state: NaverLoginState, code: Int?, message: String?) {
                when (state) {
                    NaverLoginState.SUCCESS -> {
                        sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to null))
                    }
                    NaverLoginState.FAILURE -> {
                        // httpState -> code
                        sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(code!!, message!!)))
                    }
                    NaverLoginState.ERROR -> {
                        // errorCode -> code
                        val errorMessage = when (message) {
                            "기기에 네이버앱이 없습니다." -> "naverapp_not_installed"
                            "네이버앱 업데이트가 필요합니다." -> "naverapp_need_update"
                            "커스텀탭을 실행할 수 없습니다." -> "cannot_execute_web_login"
                            "인증을 진행할 수 있는 앱이 없습니다." -> "authenticate_possible_app_nothing"
                            else -> message
                        }
                        sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError to arrayListOf<Any>(code!!, errorMessage!!)))
                    }
                }
            }
        }

        val intent = Intent(activity, NaverLoginSdkWebActivity::class.java)
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        activity.startActivity(intent)
    }

    fun logout() {
        NaverIdLoginSDK.logout()
    }

    /**
     * Delete TokenAPI
     * */
    suspend fun release(sink: EventChannel.EventSink?) {
        // Log.v("Crape", "release..")
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
    suspend fun profile(sink: EventChannel.EventSink?) {
        // Log.v("Crape", "profile..")
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

    /**
     * when is not login -> httpStatus:200, message:OK
     * */
    suspend fun refresh(sink: EventChannel.EventSink?) {
        NidOAuthLogin().callRefreshAccessTokenApi(callback = object: OAuthLoginCallback {
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

    override fun getVersion(): String {
        return NaverIdLoginSDK.getVersion()
    }

    override fun getTokenType(): String? {
        return NaverIdLoginSDK.getTokenType()
    }

    override fun getExpireAt(): Any {
        return NaverIdLoginSDK.getExpiresAt()
    }

    override fun getAccessToken(): String? {
        return NaverIdLoginSDK.getAccessToken()
    }

    override fun getRefreshToken(): String? {
        return NaverIdLoginSDK.getRefreshToken()
    }
}