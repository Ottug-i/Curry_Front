package com.ottugi.curry.web.dto.user;

import com.ottugi.curry.domain.user.User;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class UserResponseDtoTest {

    @Test
    void UserResponseDto_롬복() {

        // given
        String email = "wn8925@sookmyung.ac.kr";
        String nickName = "가경";

        User user = User.builder().email(email).nickName(nickName).build();

        // when
        UserResponseDto userResponseDto = new UserResponseDto(user);

        // then
        assertEquals(userResponseDto.getEmail(), email);
        assertEquals(userResponseDto.getNickName(), nickName);
    }
}