package com.ottugi.curry.service.lately;

import com.ottugi.curry.domain.lately.Lately;
import com.ottugi.curry.domain.lately.LatelyRepository;
import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.recipe.RecipeRepository;
import com.ottugi.curry.domain.user.User;
import com.ottugi.curry.domain.user.UserRepository;
import com.ottugi.curry.web.dto.lately.LatelyListResponseDto;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@SpringBootTest
class LatelyServiceTest {

    private final Long userId = 1L;
    private final String email = "wn8925@sookmyung.ac.kr";
    private final String nickName = "가경";

    private final Long recipeId = 1234L;
    private final String name = "참치마요 덮밥";
    private final String thumbnail = "www";
    private final String time = "15분";
    private final String difficulty = "초급";
    private final String composition = "든든하게";
    private final String ingredients = "참치캔###마요네즈###쪽파";
    private final String seasoning = "진간장###올리고당###설탕###";
    private final String orders = "1. 기름 뺀 참치###2. 마요네즈 4.5큰 술###3. 잘 비벼주세요.";
    private final String photo = "www###wwww####wwww";

    private final Long latelyId = 1L;

    @Mock
    private LatelyRepository latelyRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private RecipeRepository recipeRepository;

    @InjectMocks
    private LatelyServiceImpl latelyService;

    @Test
    void 최근본레시피추가() {

        // given
        User user = new User(userId, email, nickName);
        Recipe recipe = new Recipe(recipeId, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);

        // when
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        when(recipeRepository.findById(recipeId)).thenReturn(java.util.Optional.of(recipe));
        when(latelyRepository.findByUserIdAndRecipeId(user, recipe)).thenReturn(null);
        when(latelyRepository.save(any())).thenReturn(new Lately());
        Boolean result = latelyService.addLately(userId, recipeId);

        // then
        assertTrue(result);
    }

    @Test
    void 최근본레시피리스트조회() {

        // given
        User user = new User(userId, email, nickName);
        Recipe recipe = new Recipe(recipeId, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        Lately lately = new Lately(latelyId);
        lately.setUser(user);
        lately.setRecipe(recipe);

        // when
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        List<Lately> latelyList = new ArrayList<>();
        latelyList.add(lately);
        when(latelyRepository.findByUserIdOrderByIdDesc(user)).thenReturn(latelyList);
        List<LatelyListResponseDto> latelyListResponseDtoList = latelyService.getLatelyAll(userId);

        // then
        assertEquals(latelyListResponseDtoList.get(0).getName(), recipe.getName());
    }
}