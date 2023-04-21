package com.ottugi.curry.web.dto.recipe;

import com.ottugi.curry.domain.recipe.Recipe;
import lombok.Getter;

@Getter
public class RecipeListResponseDto {

    private Long id;

    private String name;

    private String thumbnail;

    private String time;

    private String difficulty;

    private String composition;

    private String ingredients;

    // TODO : 레시피 별 북마크 도메인 설계 후 수정
    // private Boolean isBookmark;

    public RecipeListResponseDto(Recipe recipe) {
        this.id = recipe.getId();
        this.name = recipe.getName();
        this.thumbnail = recipe.getThumbnail();
        this.time = recipe.getTime();
        this.difficulty = recipe.getDifficulty();
        this.composition = recipe.getComposition();
        this.ingredients = recipe.getIngredients();
        // this.isBookmark = isBookmark;
    }
}
