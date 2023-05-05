package com.ottugi.curry.service.recipe;

import com.ottugi.curry.domain.bookmark.BookmarkRepository;
import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.recipe.RecipeRepository;
import com.ottugi.curry.domain.user.User;
import com.ottugi.curry.domain.user.UserRepository;
import com.ottugi.curry.service.lately.LatelyServiceImpl;
import com.ottugi.curry.web.dto.recipe.RecipeListResponseDto;
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

    private final Long recipeId1 = 1234L;
    private final Long recipeId2 = 2345L;
    private final String name = "참치마요 덮밥";
    private final String thumbnail = "www";
    private final String time = "15분";
    private final String difficulty = "초급";
    private final String composition = "든든하게";
    private final String ingredients = "참치캔###마요네즈###쪽파";
    private final String seasoning = "진간장###올리고당###설탕###";
    private final String orders = "1. 기름 뺀 참치###2. 마요네즈 4.5큰 술###3. 잘 비벼주세요.";
    private final String photo = "www###wwww####wwww";

    private final Long userId = 1L;
    private final String email = "wn8925@gmail.com";
    private final String nickName = "가경";

    @Mock
    private RecipeRepository recipeRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private BookmarkRepository bookmarkRepository;

    @Mock
    private LatelyServiceImpl latelyService;

    @InjectMocks
    private RecipeServiceImpl recipeService;

    @Test
    void 레시피리스트조회() {

        // given
        Recipe recipe1 = new Recipe(recipeId1, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        Recipe recipe2 = new Recipe(recipeId2, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        User user = new User(userId, email, nickName);

        // when
        List<Recipe> recipeList = Arrays.asList(recipe1, recipe2);
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        when(recipeRepository.findByIdIn(anyList())).thenReturn(recipeList);
        RecipeRequestDto recipeRequestDto = RecipeRequestDto.builder()
                .userId(userId)
                .recipeId(Arrays.asList(recipeId1, recipeId2))
                .build();
        List<RecipeListResponseDto> recipeListResponseDtoList = recipeService.getRecipeList(recipeRequestDto);

        // then
        assertEquals(recipeListResponseDtoList.size(), 2);
        assertEquals(recipeListResponseDtoList.get(0).getId(), recipeId1);
        assertEquals(recipeListResponseDtoList.get(1).getId(), recipeId2);
    }

    @Test
    void 레시피상세조회() {

        // given
        Recipe recipe = new Recipe(recipeId1, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        User user = new User(userId, email, nickName);

        // when
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        when(recipeRepository.findById(recipeId1)).thenReturn(java.util.Optional.of(recipe));
        RecipeResponseDto recipeResponseDto = recipeService.getRecipeDetail(userId, recipeId1);

        // then
        assertNotNull(recipeResponseDto);
        assertEquals(recipeResponseDto.getId(), recipeId1);
    }
}