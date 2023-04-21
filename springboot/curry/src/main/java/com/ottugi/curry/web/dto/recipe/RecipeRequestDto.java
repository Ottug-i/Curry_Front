package com.ottugi.curry.web.dto.recipe;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class RecipeRequestDto {

    private Long userId;

    private List<Long> recipeId;

    @Builder
    public RecipeRequestDto(Long userId, List<Long> recipeId) {
        this.userId = userId;
        this.recipeId = recipeId;
    }
}
