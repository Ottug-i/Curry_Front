package com.ottugi.curry.service.user;

import com.ottugi.curry.web.dto.user.TokenDto;
import com.ottugi.curry.web.dto.user.UserResponseDto;
import com.ottugi.curry.web.dto.user.UserSaveRequestDto;
import com.ottugi.curry.web.dto.user.UserUpdateRequestDto;

public interface UserService {

    TokenDto login(UserSaveRequestDto userSaveRequestDto);
    UserResponseDto getProfile(Long id);
    UserResponseDto setProfile(UserUpdateRequestDto userUpdateRequestDto);
    Boolean setWithdraw(Long id);
}
