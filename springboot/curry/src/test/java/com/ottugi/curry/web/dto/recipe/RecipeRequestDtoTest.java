package com.ottugi.curry.web.dto.recipe;

import org.junit.jupiter.api.Test;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;

class RecipeRequestDtoTest {

    @Test
    void RecipeRequestDto_롬복() {

        // given
        Long userId = 1L;
        Long recipeId1 = 1234L;
        Long recipeId2 = 2345L;

        // when
        RecipeRequestDto recipeRequestDto = new RecipeRequestDto(userId, Arrays.asList(recipeId1, recipeId2));

        // then
        assertEquals(recipeRequestDto.getUserId(), userId);
        assertEquals(recipeRequestDto.getRecipeId().size(), 2);
        assertEquals(recipeRequestDto.getRecipeId().get(0), recipeId1);
        assertEquals(recipeRequestDto.getRecipeId().get(1), recipeId2);
    }
}