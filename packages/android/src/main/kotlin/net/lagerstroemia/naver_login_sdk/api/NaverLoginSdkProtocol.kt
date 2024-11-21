package net.lagerstroemia.naver_login_sdk.api

interface NaverLoginSdkProtocol {
    fun getVersion(): String
    fun getTokenType(): String?
    fun getAccessToken(): String?
    fun getRefreshToken(): String?
    fun getExpireAt(): Any
}