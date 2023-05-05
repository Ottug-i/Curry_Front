package com.ottugi.curry.domain.user;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@DataJpaTest
class UserRepositoryTest {

    private final String email = "wn8925@gmail.com";
    private final String nickName = "가경";
    private User user;

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    public void setUp() {

        // given
        user = User.builder().email(email).nickName(nickName).build();
        userRepository.save(user);
    }

    @AfterEach
    public void clean() {
        userRepository.deleteAll();
    }

    @Test
    void 회원생성() {

        // given
        User newUser = User.builder().email("newUser@gmail.com").nickName("새 유저").build();

        // when
        User loginUser = userRepository.save(newUser);

        // then
        assertEquals(loginUser.getId(), newUser.getId());
        assertEquals(loginUser.getEmail(), newUser.getEmail());
        assertEquals(loginUser.getNickName(), newUser.getNickName());
    }

    @Test
    void 회원조회() {

        // when
        List<User> userList = userRepository.findAll();

        // then
        User findUser = userList.get(1);
        assertEquals(findUser.getId(), user.getId());
        assertEquals(findUser.getEmail(), user.getEmail());
        assertEquals(findUser.getNickName(), user.getNickName());
    }

    @Test
    void 이메일로_회원조회() {

        // when
        User findUser = userRepository.findByEmail(user.getEmail());

        // then
        assertEquals(findUser.getId(), user.getId());
        assertEquals(findUser.getEmail(), user.getEmail());
        assertEquals(findUser.getNickName(), user.getNickName());
    }

    @Test
    void 이메일로_회원수조회() {

        // when
        int userEmailCount = userRepository.countByEmail(user.getEmail());

        // then
        assertEquals(userEmailCount, 1);
    }
}