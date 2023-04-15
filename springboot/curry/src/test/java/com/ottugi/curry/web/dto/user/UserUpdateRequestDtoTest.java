package com.ottugi.curry.web.dto.user;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class UserUpdateRequestDtoTest {

    @Test
    void UserUpdateRequestDto_롬복() {

        // given
        Long id = 1L;
        String nickName = "가경";

        // when
        UserUpdateRequestDto userUpdateRequestDto = new UserUpdateRequestDto(id, nickName);

        // then
        assertEquals(userUpdateRequestDto.getId(), id);
        assertEquals(userUpdateRequestDto.getNickName(), nickName);
    }
}