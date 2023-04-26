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

    Long userId = 1L;
    String email = "wn8925@sookmyung.ac.kr";
    String nickName = "가경";

    Long recipeId = 1234L;
    String name = "참치마요 덮밥";
    String thumbnail = "www";
    String time = "15분";
    String difficulty = "초급";
    String composition = "든든하게";
    String ingredients = "참치캔###마요네즈###쪽파";
    String seasoning = "진간장###올리고당###설탕###";
    String orders = "1. 기름 뺀 참치###2. 마요네즈 4.5큰 술###3. 잘 비벼주세요.";
    String photo = "www###wwww####wwww";

    Long latelyId = 1L;

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