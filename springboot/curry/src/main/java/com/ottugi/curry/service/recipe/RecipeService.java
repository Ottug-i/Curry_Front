package com.ottugi.curry.service.recipe;

import com.ottugi.curry.web.dto.recipe.RecipeRequestDto;
import com.ottugi.curry.web.dto.recipe.RecipeResponseDto;

import java.util.List;

public interface RecipeService {

    List<RecipeResponseDto> getRecipeList(RecipeRequestDto recipeRequestDto);
    RecipeResponseDto getRecipeDetail(Long userId, Long recipeId);
}
