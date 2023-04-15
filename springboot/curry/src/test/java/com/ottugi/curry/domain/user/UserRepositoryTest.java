package com.ottugi.curry.domain.user;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class UserRepositoryTest {

    String email = "wn8925@sookmyung.ac.kr";
    String nickName = "가경";

    @Autowired
    private UserRepository userRepository;

    @AfterEach
    public void clean() {
        userRepository.deleteAll();
    }

    @Test
    void 회원생성() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();

        // when
        User loginUser = userRepository.save(user);

        // then
        assertEquals(loginUser.getId(), user.getId());
        assertEquals(loginUser.getEmail(), user.getEmail());
        assertEquals(loginUser.getNickName(), user.getNickName());
    }

    @Test
    void 회원조회() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        userRepository.save(user);

        // when
        List<User> userList = userRepository.findAll();

        // then
        User findUser = userList.get(0);
        assertEquals(userList.size(), 1);
        assertEquals(findUser.getId(), user.getId());
        assertEquals(findUser.getEmail(), user.getEmail());
        assertEquals(findUser.getNickName(), user.getNickName());
    }

    @Test
    void 이메일로_회원조회() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        userRepository.save(user);

        // when
        User findUser = userRepository.findByEmail(user.getEmail());

        // then
        assertEquals(findUser.getId(), user.getId());
        assertEquals(findUser.getEmail(), user.getEmail());
        assertEquals(findUser.getNickName(), user.getNickName());    }

    @Test
    void 이메일로_회원수조회() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        userRepository.save(user);

        // when
        int userEmailCount = userRepository.countByEmail(user.getEmail());

        // then
        assertEquals(userEmailCount, 1);
    }
}