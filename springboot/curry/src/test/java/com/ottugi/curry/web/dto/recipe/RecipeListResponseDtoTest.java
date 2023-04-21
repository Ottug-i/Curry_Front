package com.ottugi.curry.web.dto.recipe;

import com.ottugi.curry.domain.recipe.Recipe;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class RecipeListResponseDtoTest {

    @Test
    void RecipeListResponseDto_롬복() {

        // given
        Long id = 1234L;
        String name = "참치마요 덮밥";
        String thumbnail = "www";
        String time = "15분";
        String difficulty = "초급";
        String composition = "든든하게";
        String ingredients = "참치캔###마요네즈###쪽파";
        String seasoning = "진간장###올리고당###설탕###";
        String orders = "1. 기름 뺀 참치###2. 마요네즈 4.5큰 술###3. 잘 비벼주세요.";
        String photo = "www###wwww####wwww";

        Recipe recipe = Recipe.builder()
                .id(id)
                .name(name)
                .thumbnail(thumbnail)
                .time(time)
                .difficulty(difficulty)
                .composition(composition)
                .ingredients(ingredients)
                .seasoning(seasoning)
                .orders(orders)
                .photo(photo)
                .build();

        // when
        RecipeListResponseDto recipeListResponseDto = new RecipeListResponseDto(recipe);

        // then
        assertEquals(recipeListResponseDto.getId(), id);
        assertEquals(recipeListResponseDto.getName(), name);
        assertEquals(recipeListResponseDto.getThumbnail(), thumbnail);
        assertEquals(recipeListResponseDto.getTime(), time);
        assertEquals(recipeListResponseDto.getDifficulty(), difficulty);
        assertEquals(recipeListResponseDto.getComposition(), composition);
        assertEquals(recipeListResponseDto.getIngredients(), ingredients);
    }
}