package net.lagerstroemia.naver_login_sdk.api

interface NaverLoginEventListener {
    fun onReceive(state: NaverLoginState, code: String? = null, message: String? = null)
}

enum class NaverLoginState {
    SUCCESS,
    FAILURE,
    @Deprecated(message = "not used", replaceWith = ReplaceWith(expression = "only return Failure")) ERROR,
}