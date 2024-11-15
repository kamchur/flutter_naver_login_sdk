package net.lagerstroemia.naver_login_sdk

object NaverLoginSdkConstant {
    const val channelNameMethod: String = "naver_login_sdk_method"
    const val channelNameEvent: String = "naver_login_sdk_event"

    object Key {
        const val initialize: String = "initialize"
        const val authenticate: String = "authenticate"

        object OAuthLoginCallback {
            const val onSuccess: String = "onSuccess"
            const val onFailure: String = "onFailure"
            const val onError: String = "onError"
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