package com.ottugi.curry.domain.recipe;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class RecipeRepositoryTest {

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

    @Autowired
    private RecipeRepository recipeRepository;

    @AfterEach
    void clean() {
        recipeRepository.deleteAll();
    }

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

        // when
        Recipe newRecipe = recipeRepository.save(recipe);

        // then
        assertEquals(newRecipe.getName(), name);
        assertEquals(newRecipe.getThumbnail(), thumbnail);
        assertEquals(newRecipe.getTime(), time);
        assertEquals(newRecipe.getDifficulty(), difficulty);
        assertEquals(newRecipe.getComposition(), composition);
        assertEquals(newRecipe.getIngredients(), ingredients);
        assertEquals(newRecipe.getSeasoning(), seasoning);
        assertEquals(newRecipe.getOrders(), orders);
        assertEquals(newRecipe.getPhoto(), photo);

    }

    @Test
    void 레시피조회() {

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
        recipeRepository.save(recipe);

        // when
        List<Recipe> recipeList = recipeRepository.findAll();

        // then
        Recipe findRecipe = recipeList.get(0);
        assertEquals(findRecipe.getName(), name);
        assertEquals(findRecipe.getThumbnail(), thumbnail);
        assertEquals(findRecipe.getTime(), time);
        assertEquals(findRecipe.getDifficulty(), difficulty);
        assertEquals(findRecipe.getComposition(), composition);
        assertEquals(findRecipe.getIngredients(), ingredients);
        assertEquals(findRecipe.getSeasoning(), seasoning);
        assertEquals(findRecipe.getOrders(), orders);
        assertEquals(findRecipe.getPhoto(), photo);
    }

    @Test
    void 레시피아이디로조회() {

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
        recipeRepository.save(recipe);

        // when
        List<Recipe> recipeList = recipeRepository.findByIdIn(Arrays.asList(id));

        // then
        assertEquals(recipeList.get(0).getName(), name);
        assertEquals(recipeList.get(0).getThumbnail(), thumbnail);
        assertEquals(recipeList.get(0).getTime(), time);
        assertEquals(recipeList.get(0).getDifficulty(), difficulty);
        assertEquals(recipeList.get(0).getComposition(), composition);
        assertEquals(recipeList.get(0).getIngredients(), ingredients);
        assertEquals(recipeList.get(0).getSeasoning(), seasoning);
        assertEquals(recipeList.get(0).getOrders(), orders);
        assertEquals(recipeList.get(0).getPhoto(), photo);
    }
}