package net.lagerstroemia.naver_login_sdk.api

interface NaverLoginEventListener {
    fun onReceive(state: NaverLoginState, code: Int? = null, message: String? = null)
}

enum class NaverLoginState {
    SUCCESS,
    FAILURE,
    ERROR,
}