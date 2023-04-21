package com.ottugi.curry.web.dto.recipe;

import com.ottugi.curry.domain.recipe.Recipe;
import lombok.Getter;

@Getter
public class RecipeResponseDto {

    private Long id;

    private String name;

    private String thumbnail;

    private String time;

    private String difficulty;

    private String composition;

    private String ingredients;

    private String seasoning;

    private String orders;

    private String photo;
     
    // TODO : 북마크 도메인 설계 후 수정
    // private Boolean isBookmark;

    public RecipeResponseDto(Recipe recipe) {
        this.id = recipe.getId();
        this.name = recipe.getName();
        this.thumbnail = recipe.getThumbnail();
        this.time = recipe.getTime();
        this.difficulty = recipe.getDifficulty();
        this.composition = recipe.getComposition();
        this.ingredients = recipe.getIngredients();
        this.seasoning = recipe.getSeasoning();
        this.orders = recipe.getOrders();
        this.photo = recipe.getPhoto();
        // this.isBookmark = isBookmark;
    }
}
