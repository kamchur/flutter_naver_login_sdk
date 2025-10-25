package net.lagerstroemia.naver_login_sdk

object NaverLoginSdkConstant {
    const val channelNameMethod: String = "naver_login_sdk_method"
    const val channelNameEvent: String = "naver_login_sdk_event"
    const val loginBroadcastReceiver: String = "com.lagerstroemia.LOGIN_RESULT"

    object Key {
        const val initialize: String = "initialize"
        const val authenticate: String = "authenticate"
        const val logout: String = "logout"
        const val release: String = "release"
        const val profile: String = "profile"
        const val refresh: String = "refresh"

        const val version: String = "version"
        const val tokenType: String = "tokenType"
        const val accessToken: String = "accessToken"
        const val refreshToken: String = "refreshToken"
        const val expireAt = "expireAt"     // accessTokenExpireDate

        object NaverLoginEventCallback {
            const val onSuccess: String = "onSuccess"
            const val onFailure: String = "onFailure"
            @Deprecated(message = "not use anymore, only use Failure") const val onError: String = "onError"
        }
    }

    object Value {
        const val clientId: String = "clientId"
        const val clientSecret: String = "clientSecret"
        const val clientName: String = "clientName"

        object OAuthLoginCallback {
            const val errorCode: String = "errorCode"
            const val message: String = "message"
        }
    }
}