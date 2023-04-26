package com.ottugi.curry.web.dto.lately;

import com.ottugi.curry.domain.recipe.Recipe;
import lombok.Getter;

@Getter
public class LatelyListResponseDto {

    private Long id;

    private String name;

    private String thumbnail;

    public LatelyListResponseDto(Recipe recipe) {
        this.id = recipe.getId();
        this.name = recipe.getName();
        this.thumbnail = recipe.getThumbnail();
    }
}
