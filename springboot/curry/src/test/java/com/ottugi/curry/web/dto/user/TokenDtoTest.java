package com.ottugi.curry.web.dto.user;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class TokenDtoTest {

    @Test
    void TokenDto_롬복() {

        // given
        Long id = 1L;
        String email = "wn8925@sookmyung.ac.kr";
        String nickName = "가경";
        String token = "secret";

        // when
        TokenDto tokenDto = new TokenDto(id, email, nickName, token);

        // then
        assertEquals(tokenDto.getId(), id);
        assertEquals(tokenDto.getEmail(), email);
        assertEquals(tokenDto.getNickName(), nickName);
        assertEquals(tokenDto.getToken(), token);
    }
}