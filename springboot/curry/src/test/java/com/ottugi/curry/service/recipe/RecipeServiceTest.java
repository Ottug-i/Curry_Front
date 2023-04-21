package com.ottugi.curry.service.recipe;

import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.recipe.RecipeRepository;
import com.ottugi.curry.web.dto.recipe.RecipeRequestDto;
import com.ottugi.curry.web.dto.recipe.RecipeResponseDto;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class RecipeServiceTest {

    Long recipeId1 = 1234L;
    Long recipeId2 = 2345L;
    String name = "참치마요 덮밥";
    String thumbnail = "www";
    String time = "15분";
    String difficulty = "초급";
    String composition = "든든하게";
    String ingredients = "참치캔###마요네즈###쪽파";
    String seasoning = "진간장###올리고당###설탕###";
    String orders = "1. 기름 뺀 참치###2. 마요네즈 4.5큰 술###3. 잘 비벼주세요.";
    String photo = "www###wwww####wwww";

    Long userId = 1L;

    @Mock
    private RecipeRepository recipeRepository;

    @InjectMocks
    private RecipeServiceImpl recipeService;

    @Test
    void 레시피리스트조회() {

        // given
        Recipe recipe1 = new Recipe(recipeId1, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        Recipe recipe2 = new Recipe(recipeId2, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);

        // when
        List<Recipe> recipeList = Arrays.asList(recipe1, recipe2);
        when(recipeRepository.findByIdIn(anyList())).thenReturn(recipeList);
        RecipeRequestDto recipeRequestDto = RecipeRequestDto.builder()
                .userId(userId)
                .recipeId(Arrays.asList(recipeId1, recipeId1))
                .build();
        List<RecipeResponseDto> recipeResponseDtoList = recipeService.getRecipeList(recipeRequestDto);

        // then
        assertEquals(recipeResponseDtoList.size(), 2);
        assertEquals(recipeResponseDtoList.get(0).getId(), recipeId1);
        assertEquals(recipeResponseDtoList.get(1).getId(), recipeId2);
    }

    @Test
    void 레시피상세조회() {

        // given
        Recipe recipe = new Recipe(recipeId1, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);

        // when
        when(recipeRepository.findById(recipeId1)).thenReturn(java.util.Optional.of(recipe));
        RecipeResponseDto recipeResponseDto = recipeService.getRecipeDetail(userId, recipeId1);

        // then
        assertNotNull(recipeResponseDto);
        assertEquals(recipeResponseDto.getId(), recipeId1);
    }
}