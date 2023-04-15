package com.ottugi.curry.web.dto.user;

import com.ottugi.curry.domain.user.User;
import lombok.Getter;

@Getter
public class UserResponseDto {

    private Long id;

    private String email;

    private String nickName;

    public UserResponseDto(User user) {
        this.id = user.getId();
        this.email = user.getEmail();
        this.nickName = user.getNickName();
    }
}
