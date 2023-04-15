package com.ottugi.curry.service.user;

import com.ottugi.curry.domain.user.User;
import com.ottugi.curry.domain.user.UserRepository;
import com.ottugi.curry.web.dto.user.TokenDto;
import com.ottugi.curry.web.dto.user.UserResponseDto;
import com.ottugi.curry.web.dto.user.UserSaveRequestDto;
import com.ottugi.curry.web.dto.user.UserUpdateRequestDto;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import static org.mockito.ArgumentMatchers.any;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class UserServiceTest {

    String email = "wn8925@sookmyung.ac.kr";
    String nickName = "가경";
    String newNickName = "가경이";
    String token = "secret";

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserServiceImpl userService;

    @Test
    void 회원가입() {

        // given
        UserSaveRequestDto userSaveRequestDto = new UserSaveRequestDto(email, nickName);

        // when
        when(userRepository.countByEmail(any())).thenReturn(0);
        when(userRepository.save(any())).thenReturn(new User(1L, userSaveRequestDto.getEmail(), userSaveRequestDto.getNickName()));
        TokenDto tokenDto = userService.login(userSaveRequestDto);

        // then
        assertNotNull(tokenDto);
        assertEquals(1L, tokenDto.getId());
        assertEquals(userSaveRequestDto.getEmail(), tokenDto.getEmail());
        assertEquals(userSaveRequestDto.getNickName(), tokenDto.getNickName());
        assertEquals(token, tokenDto.getToken());
    }

    @Test
    void 로그인() {

        // given
        UserSaveRequestDto userSaveRequestDto = new UserSaveRequestDto(email, nickName);
        User existingUser = new User(1L, userSaveRequestDto.getEmail(), userSaveRequestDto.getNickName());

        // when
        when(userRepository.countByEmail(any())).thenReturn(1);
        when(userRepository.findByEmail(any())).thenReturn(existingUser);
        TokenDto tokenDto = userService.login(userSaveRequestDto);

        // then
        assertNotNull(tokenDto);
        assertEquals(1L, tokenDto.getId());
        assertEquals(userSaveRequestDto.getEmail(), tokenDto.getEmail());
        assertEquals(userSaveRequestDto.getNickName(), tokenDto.getNickName());
        assertEquals(token, tokenDto.getToken());
    }

    @Test
    void 회원조회() {

        // given
        User user = new User(1L, email, nickName);

        // when
        when(userRepository.findById(1L)).thenReturn(java.util.Optional.of(user));
        UserResponseDto userResponseDto = userService.getProfile(1L);

        // then
        assertNotNull(userResponseDto);
        assertEquals(1L, userResponseDto.getId());
        assertEquals(user.getEmail(), userResponseDto.getEmail());
        assertEquals(user.getNickName(), userResponseDto.getNickName());
    }

    @Test
    void 회원수정() {

        // given
        UserUpdateRequestDto userUpdateRequestDto = new UserUpdateRequestDto(1L, newNickName);

        User existingUser = new User(1L, email, nickName);

        // when
        when(userRepository.findById(1L)).thenReturn(java.util.Optional.of(existingUser));
        UserResponseDto userResponseDto = userService.setProfile(userUpdateRequestDto);

        // then
        assertNotNull(userResponseDto);
        assertEquals(userResponseDto.getId(), userUpdateRequestDto.getId());
        assertEquals(userResponseDto.getNickName(), userUpdateRequestDto.getNickName());
    }

    @Test
    void 탈퇴() {

        // given
        User user = new User(1L, email, nickName);

        // when
        when(userRepository.findById(1L)).thenReturn(java.util.Optional.of(user));
        Boolean isWithdraw = userService.setWithdraw(1L);

        // then
        assertTrue(isWithdraw);
    }
}