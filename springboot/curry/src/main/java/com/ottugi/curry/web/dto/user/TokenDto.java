package com.ottugi.curry.web.dto.user;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TokenDto {

    @ApiModelProperty(notes = "회원 기본키", example = "1")
    private Long id;

    @ApiModelProperty(notes = "회원 이메일", example = "wn8925@sookmyung.ac.kr")
    private String email;

    @ApiModelProperty(notes = "회원 닉네임", example = "가경")
    private String nickName;

    @ApiModelProperty(notes = "회원 토큰", example = "secret")
    private String token;

    public TokenDto(Long id, String email, String nickName, String token) {
        this.id = id;
        this.email = email;
        this.nickName = nickName;
        this.token = token;
    }
}
