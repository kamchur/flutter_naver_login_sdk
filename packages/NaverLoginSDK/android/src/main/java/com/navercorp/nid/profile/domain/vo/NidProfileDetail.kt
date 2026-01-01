package com.navercorp.nid.profile.domain.vo

data class NidProfileDetail(
    val id: String,
    val nickname: String,
    val name: String,
    val email: String,
    val gender: String,
    val age: String,
    val birthday: String,
    val profileImage: String,
    val birthyear: String,
    val mobile: String,
    val ci: String,
    val encId: String,
) {
    companion object {
        fun empty() = NidProfileDetail(
            id = "",
            nickname = "",
            name = "",
            email = "",
            gender = "",
            age = "",
            birthday = "",
            profileImage = "",
            birthyear = "",
            mobile = "",
            ci = "",
            encId = "",
        )
    }
}