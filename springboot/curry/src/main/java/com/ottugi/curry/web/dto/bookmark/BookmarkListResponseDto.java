package com.ottugi.curry.web.dto.bookmark;

import com.ottugi.curry.domain.recipe.Recipe;
import lombok.Getter;

@Getter
public class BookmarkListResponseDto {

    private Long id;

    private String name;

    private String thumbnail;

    private String time;

    private String difficulty;

    private String composition;

    private String ingredients;

    private Boolean isBookmark;

    public BookmarkListResponseDto(Recipe recipe, Boolean isBookmark) {
        this.id = recipe.getId();
        this.name = recipe.getName();
        this.thumbnail = recipe.getThumbnail();
        this.time = recipe.getTime();
        this.difficulty = recipe.getDifficulty();
        this.composition = recipe.getComposition();
        this.ingredients = recipe.getIngredients();
        this.isBookmark = isBookmark;
    }
}
