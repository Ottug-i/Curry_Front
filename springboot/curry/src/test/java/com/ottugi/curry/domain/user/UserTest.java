package com.ottugi.curry.domain.user;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserTest {

    Long id = 1L;
    String email = "wn8925@sookmyung.ac.kr";
    String nickName = "가경";
    String newNickName = "가경이";

    @Test
    void 회원생성() {

        // given
        User user = User.builder().id(id).email(email).nickName(nickName).build();

        // when, then
        assertEquals(user.getId(), id);
        assertEquals(user.getEmail(), email);
        assertEquals(user.getNickName(), nickName);
    }

    @Test
    void 회원수정() {

        // given
        User user = User.builder().id(id).email(email).nickName(nickName).build();

        // when
        user.updateProfile("가경이");

        // then
        assertEquals(user.getId(), id);
        assertEquals(user.getNickName(), newNickName);
    }

}