package com.ottugi.curry.web.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.service.recipe.RecipeServiceImpl;
import com.ottugi.curry.web.dto.recipe.RecipeRequestDto;
import com.ottugi.curry.web.dto.recipe.RecipeResponseDto;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.hamcrest.Matchers.hasSize;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class RecipeControllerTest {

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

    private MockMvc mockMvc;

    @Mock
    private RecipeServiceImpl recipeService;

    @InjectMocks
    private RecipeController recipeController;

    @BeforeEach
    public void setUp() {
        mockMvc = MockMvcBuilders.standaloneSetup(recipeController).build();
    }

    @Test
    void 레시피리스트조회() throws Exception {

        // given
        RecipeRequestDto recipeRequestDto = RecipeRequestDto.builder()
                .userId(userId)
                .recipeId(Arrays.asList(recipeId1, recipeId2))
                .build();
        List<RecipeResponseDto> recipeResponseDtoList = new ArrayList<>();

        // when
        when(recipeService.getRecipeList(recipeRequestDto)).thenReturn(recipeResponseDtoList);

        // then
        mockMvc.perform(get("/api/recipe/getRecipeList")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(new ObjectMapper().writeValueAsString(recipeRequestDto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(recipeResponseDtoList.size())));
    }

    @Test
    void 레시피상세조회() throws Exception {

        // given
        Recipe recipe = new Recipe(recipeId1, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        RecipeResponseDto recipeResponseDto = new RecipeResponseDto(recipe);

        // when
        when(recipeService.getRecipeDetail(userId, recipeId1)).thenReturn(recipeResponseDto);

        // then
        mockMvc.perform(get("/api/recipe/getRecipeDetail")
                    .param("userId", String.valueOf(userId))
                    .param("recipeId", String.valueOf(recipeId1)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(recipeId1));
    }
}