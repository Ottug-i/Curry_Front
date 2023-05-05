package com.ottugi.curry.web.dto.user;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;

import static org.junit.jupiter.api.Assertions.*;

class TokenDtoTest {

    @Value("${jwt.secret}")
    private String secret;

    @Test
    void TokenDto_롬복() {

        // given
        Long id = 1L;
        String email = "wn8925@sookmyung.ac.kr";
        String nickName = "가경";

        // when
        TokenDto tokenDto = new TokenDto(id, email, nickName, secret);

        // then
        assertEquals(tokenDto.getId(), id);
        assertEquals(tokenDto.getEmail(), email);
        assertEquals(tokenDto.getNickName(), nickName);
        assertEquals(tokenDto.getToken(), secret);
    }
}