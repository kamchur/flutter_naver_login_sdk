package net.lagerstroemia.naver_login_sdk

import android.app.Activity
import android.content.Context
import android.content.Intent
import com.google.gson.Gson
import com.navercorp.nid.NidOAuth
import com.navercorp.nid.core.data.datastore.NidOAuthInitializingCallback
import com.navercorp.nid.oauth.NidOAuthLogin
import com.navercorp.nid.oauth.domain.enum.LoginBehavior
import com.navercorp.nid.oauth.util.NidOAuthCallback
import com.navercorp.nid.profile.domain.vo.NidProfile
import com.navercorp.nid.profile.util.NidProfileCallback
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import net.lagerstroemia.naver_login_sdk.api.NaverLoginEventListener
import net.lagerstroemia.naver_login_sdk.api.NaverLoginSdkProtocol
import net.lagerstroemia.naver_login_sdk.api.NaverLoginState

object NaverLoginSdkBridge : NaverLoginSdkProtocol {
    /**
     * 2025-04-17-Thu
     *
     * Fixed for Naver OAuth Login
     * */
    var loginEventListener: NaverLoginEventListener? = null

    fun initialize(
        context: Context,
        args: Any,
        r: MethodChannel.Result
    ) {
        // Log.d("Crape", "NaverLoginSdkBridge.. initialize..")
        val params: Map<String, String>? = (args as? Map<*, *>?)?.entries
            ?.associate { element -> element.key.toString() to element.value.toString() }
            ?.toMutableMap()

        params?.let {
            val clientId: String = params[NaverLoginSdkConstant.Value.clientId]!!
            val clientSecret: String = params[NaverLoginSdkConstant.Value.clientSecret]!!
            val clientName: String = params[NaverLoginSdkConstant.Value.clientName]!!

            NidOAuth.initialize(context,
                clientId = clientId,
                clientSecret = clientSecret,
                clientName = clientName,
                callback = object: NidOAuthInitializingCallback {
                    override fun onSuccess() {
                        NidOAuth.registerObserver()

                        r.success(true)
                    }

                    override fun onFailure(e: Exception) {
                        r.success(false)
                    }
                }
            )

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
            NidOAuth.behavior = LoginBehavior.DEFAULT;
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
     *
     * 2025-10-24-Fri,
     * Deprecated authenticate > requestLogin
     * */
    suspend fun authenticate(
        activity: Activity,
        sink: EventChannel.EventSink?,
        r: MethodChannel.Result
    ) {
        loginEventListener = object : NaverLoginEventListener {
            override fun onReceive(state: NaverLoginState, code: String?, message: String?) {
                when (state) {
                    NaverLoginState.SUCCESS -> {
                        sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to null))
                    }

                    NaverLoginState.FAILURE -> {
                        // httpState -> code
                        sink?.success(
                            mapOf(
                                NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(
                                    code!!,
                                    message!!
                                )
                            )
                        )
                    }

                    NaverLoginState.ERROR -> {
                        // errorCode -> code
                        val errorMessage = when (message) {
                            "기기에 네이버앱이 없습니다." -> "naverapp_not_installed"
                            "네이버앱 업데이트가 필요합니다." -> "naverapp_need_update"
                            "커스텀탭을 실행할 수 없습니다." -> "cannot_execute_web_login"
                            "인증을 진행할 수 있는 앱이 없습니다." -> "authenticate_possible_app_nothing"
                            else -> "Please use 'Failure', this listener don't use anymore."
                        }
                        sink?.success(
                            mapOf(
                                NaverLoginSdkConstant.Key.NaverLoginEventCallback.onError to arrayListOf<Any>(
                                    code!!,
                                    errorMessage!!
                                )
                            )
                        )
                    }
                }
                r.success(null)        // true, false return later.
            }
        }

        val intent = Intent(activity, NaverLoginSdkWebActivity::class.java)
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        activity.startActivity(intent)
    }

    /**
     * 2025-10-24-Fri,
     *
     * also, Logout has callback listener.
     * */
    fun logout(
        sink: EventChannel.EventSink?,
        r: MethodChannel.Result
    ) {
        NidOAuth.logout(callback = object: NidOAuthCallback {
            override fun onSuccess() {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to null))
                r.success(null)
            }

            override fun onFailure(errorCode: String, errorDesc: String) {
                sink?.success(
                    mapOf(
                        NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(
                            errorCode,
                            errorDesc
                        )
                    )
                )
                r.success(null)
            }
        })
    }

    /**
     * Delete TokenAPI
     * */
    suspend fun release(sink: EventChannel.EventSink?, r: MethodChannel.Result) {
        // Log.v("Crape", "release..")
        NidOAuth.disconnect(callback = object : NidOAuthCallback {
            override fun onSuccess() {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to null))
                r.success(null)
            }

            override fun onFailure(errorCode: String, errorDesc: String) {
                sink?.success(
                    mapOf(
                        NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(
                            errorCode,
                            errorDesc
                        )
                    )
                )
                r.success(null)
            }
        })
    }

    /**
     * Getting User Profile
     * */
    suspend fun profile(sink: EventChannel.EventSink?, r: MethodChannel.Result) {
        NidOAuth.getUserProfile(callback = object : NidProfileCallback<NidProfile> {
            override fun onSuccess(result: NidProfile) {
                val gson = Gson()
                sink?.success(
                    mapOf(
                        NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to arrayListOf<Any>(
                            result.error.code,
                            result.error.description,
                            gson.toJson(result.profile)
                        )
                    )
                )
                r.success(null)
            }

            override fun onFailure(errorCode: String, errorDesc: String) {
                sink?.success(
                    mapOf(
                        NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(
                            errorCode,
                            errorDesc
                        )
                    )
                )

                r.success(null)
            }
        })
    }

    /**
     * when is not login -> httpStatus:200, message:OK
     * */
    suspend fun refresh(sink: EventChannel.EventSink?, r: MethodChannel.Result) {
        NidOAuthLogin().callRefreshAccessTokenApi(callback = object : NidOAuthCallback {
            override fun onSuccess() {
                sink?.success(mapOf(NaverLoginSdkConstant.Key.NaverLoginEventCallback.onSuccess to null))

                r.success(null)
            }

            override fun onFailure(errorCode: String, errorDesc: String) {
                sink?.success(
                    mapOf(
                        NaverLoginSdkConstant.Key.NaverLoginEventCallback.onFailure to arrayListOf<Any>(
                            errorCode,
                            errorDesc
                        )
                    )
                )

                r.success(null)
            }
        })
    }

    override fun getVersion(): String {
        return NidOAuth.getVersion()
    }

    override fun getTokenType(): String? {
        return NidOAuth.getTokenType()
    }

    override fun getExpireAt(): Any {
        return NidOAuth.getExpiresAt()
    }

    override fun getAccessToken(): String? {
        return NidOAuth.getAccessToken()
    }

    override fun getRefreshToken(): String? {
        return NidOAuth.getRefreshToken()
    }
}