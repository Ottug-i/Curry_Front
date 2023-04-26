package com.ottugi.curry.web.dto.lately;

import com.ottugi.curry.domain.recipe.Recipe;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;

@Getter
public class LatelyListResponseDto {

    @ApiModelProperty(notes = "레시피 기본키", example = "6909678")
    private Long id;

    @ApiModelProperty(notes = "레시피 이름", example = "연어유부초밥")
    private String name;

    @ApiModelProperty(notes = "레시피 썸네일", example = "https://recipe1.ezmember.co.kr/cache/recipe/2019/04/02/f8e2bac1e4e5387b34ef9dfa04f343b41.jpg")
    private String thumbnail;

    public LatelyListResponseDto(Recipe recipe) {
        this.id = recipe.getId();
        this.name = recipe.getName();
        this.thumbnail = recipe.getThumbnail();
    }
}
