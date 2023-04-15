package com.ottugi.curry.web.dto.user;

import com.ottugi.curry.domain.user.User;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class UserSaveRequestDto {

    private String email;

    private String nickName;

    @Builder
    public UserSaveRequestDto(String email, String nickName) {
        this.email = email;
        this.nickName = nickName;
    }

    public User toEntity() {
        return User.builder()
                .email(email)
                .nickName(nickName)
                .build();
    }
}
