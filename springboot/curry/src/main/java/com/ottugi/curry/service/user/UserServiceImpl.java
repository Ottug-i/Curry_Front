package com.ottugi.curry.service.user;

import com.ottugi.curry.domain.user.User;
import com.ottugi.curry.domain.user.UserRepository;
import com.ottugi.curry.web.dto.user.TokenDto;
import com.ottugi.curry.web.dto.user.UserResponseDto;
import com.ottugi.curry.web.dto.user.UserSaveRequestDto;
import com.ottugi.curry.web.dto.user.UserUpdateRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    public TokenDto login(UserSaveRequestDto userSaveRequestDto) {

        if(validateDuplicatedUser(userSaveRequestDto.getEmail())) {
            User user = userRepository.findByEmail(userSaveRequestDto.getEmail());
            return createToken(user);
        }
        else {
            User user = userRepository.save(userSaveRequestDto.toEntity());
            return createToken(user);
        }
    }

    @Override
    public UserResponseDto getProfile(Long id) {

        User user = findUser(id);
        return new UserResponseDto(user);
    }

    @Override
    public UserResponseDto setProfile(UserUpdateRequestDto userUpdateRequestDto) {

        User user = findUser(userUpdateRequestDto.getId());
        user.updateProfile(userUpdateRequestDto.getNickName());

        return new UserResponseDto(user);
    }

    @Override
    public Boolean setWithdraw(Long id) {

        User user = findUser(id);
        userRepository.delete(user);
        return true;
    }

    public Boolean validateDuplicatedUser(String email) {

        int loginEmailCount = userRepository.countByEmail(email);
        if (loginEmailCount > 0) {
            return true;
        }
        else {
            return false;
        }
    }

    public User findUser(Long id) {

        User user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 회원이 없습니다."));
        return user;
    }

    public TokenDto createToken(User user) {
        // TODO : JWT 토큰 코드 수정
        String jwtToken = "secret";
        return new TokenDto(user.getId(), user.getEmail(), user.getNickName(), jwtToken);
    }
}
