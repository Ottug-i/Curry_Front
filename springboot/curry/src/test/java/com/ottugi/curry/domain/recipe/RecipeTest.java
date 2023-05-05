package com.ottugi.curry.domain.recipe;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class RecipeTest {

    private final Long id = 1234L;
    private final String name = "참치마요 덮밥";
    private final String thumbnail = "www";
    private final String time = "15분";
    private final String difficulty = "초급";
    private final String composition = "든든하게";
    private final String ingredients = "참치캔###마요네즈###쪽파";
    private final String seasoning = "진간장###올리고당###설탕###";
    private final String orders = "1. 기름 뺀 참치###2. 마요네즈 4.5큰 술###3. 잘 비벼주세요.";
    private final String photo = "www###wwww####wwww";

    @Test
    void 레시피추가() {

        // given
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

        // when, then
        assertEquals(recipe.getId(), id);
        assertEquals(recipe.getName(), name);
        assertEquals(recipe.getThumbnail(), thumbnail);
        assertEquals(recipe.getTime(), time);
        assertEquals(recipe.getDifficulty(), difficulty);
        assertEquals(recipe.getComposition(), composition);
        assertEquals(recipe.getIngredients(), ingredients);
        assertEquals(recipe.getSeasoning(), seasoning);
        assertEquals(recipe.getOrders(), orders);
        assertEquals(recipe.getPhoto(), photo);
    }

}