package com.ottugi.curry.web.dto.user;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TokenDto {

    private Long id;

    private String email;

    private String nickName;

    private String token;

    public TokenDto(Long id, String email, String nickName, String token) {
        this.id = id;
        this.email = email;
        this.nickName = nickName;
        this.token = token;
    }
}
