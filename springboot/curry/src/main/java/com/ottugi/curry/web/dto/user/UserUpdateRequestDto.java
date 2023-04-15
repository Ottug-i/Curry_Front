package com.ottugi.curry.web.dto.user;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class UserUpdateRequestDto {

    private Long id;

    private String nickName;

    @Builder
    public UserUpdateRequestDto(Long id, String nickName) {
        this.id = id;
        this.nickName = nickName;
    }
}
