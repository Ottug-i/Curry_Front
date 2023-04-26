package com.ottugi.curry.domain.lately;

import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.user.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@DataJpaTest
class LatelyRepositoryTest {

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

    @Autowired
    private LatelyRepository latelyRepository;

    @Autowired
    private TestEntityManager entityManager;

    @AfterEach
    void clean() {
        latelyRepository.deleteAll();
    }

    @Test
    void 최근본레시피추가() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        Recipe recipe = Recipe.builder()
                .id(recipeId)
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
        entityManager.persist(user);
        entityManager.persist(recipe);

        Lately lately = new Lately();
        lately.setUser(user);
        lately.setRecipe(recipe);
        latelyRepository.save(lately);

        // when
        Lately findLately = latelyRepository.findByUserIdAndRecipeId(user, recipe);

        // then
        assertEquals(findLately, lately);
    }

    @Test
    void 최근본레시피유저이름과레시피이름으로검색() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        Recipe recipe = Recipe.builder()
                .id(recipeId)
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
        entityManager.persist(user);
        entityManager.persist(recipe);

        Lately lately = new Lately();
        lately.setUser(user);
        lately.setRecipe(recipe);
        latelyRepository.save(lately);

        // when
        Lately findLately = latelyRepository.findByUserIdAndRecipeId(user, recipe);

        // then
        assertEquals(findLately.getUserId(), user);
        assertEquals(findLately.getRecipeId(), recipe);
    }

    @Test
    void 최근본레시피리스트유저이름으로정렬하여검색() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        Recipe recipe = Recipe.builder()
                .id(recipeId)
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
        entityManager.persist(user);
        entityManager.persist(recipe);

        Lately lately = new Lately();
        lately.setUser(user);
        lately.setRecipe(recipe);
        latelyRepository.save(lately);

        // when
        List<Lately> latelyList = latelyRepository.findByUserIdOrderByIdDesc(user);

        // then
        Lately findLately = latelyList.get(0);
        assertEquals(findLately.getUserId(), user);
        assertEquals(findLately.getRecipeId(), recipe);
    }

    @Test
    void 유저이름으로최근본레시피횟수검색() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        Recipe recipe = Recipe.builder()
                .id(recipeId)
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
        entityManager.persist(user);
        entityManager.persist(recipe);

        Lately lately = new Lately();
        lately.setUser(user);
        lately.setRecipe(recipe);
        latelyRepository.save(lately);

        // when
        int userIdCount = latelyRepository.countByUserId(user);

        // then
        assertEquals(userIdCount, 1);
    }
}