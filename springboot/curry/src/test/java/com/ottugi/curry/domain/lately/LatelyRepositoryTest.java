package com.ottugi.curry.domain.lately;

import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.user.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
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
    private User user;
    private Recipe recipe;
    private Lately lately;

    @Autowired
    private LatelyRepository latelyRepository;

    @Autowired
    private TestEntityManager entityManager;

    @BeforeEach
    public void setUp() {

        // given
        user = User.builder().email(email).nickName(nickName).build();
        recipe = Recipe.builder()
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

        lately = new Lately();
        lately.setUser(user);
        lately.setRecipe(recipe);
        latelyRepository.save(lately);
    }

    @AfterEach
    void clean() {
        latelyRepository.deleteAll();
    }

    @Test
    void 최근본레시피추가() {

        // when
        Lately findLately = latelyRepository.findByUserIdAndRecipeId(user, recipe);

        // then
        assertEquals(findLately, lately);
    }

    @Test
    void 최근본레시피유저이름과레시피이름으로검색() {

        // when
        Lately findLately = latelyRepository.findByUserIdAndRecipeId(user, recipe);

        // then
        assertEquals(findLately.getUserId(), user);
        assertEquals(findLately.getRecipeId(), recipe);
    }

    @Test
    void 최근본레시피리스트유저이름으로정렬하여검색() {

        // when
        List<Lately> latelyList = latelyRepository.findByUserIdOrderByIdDesc(user);

        // then
        Lately findLately = latelyList.get(0);
        assertEquals(findLately.getUserId(), user);
        assertEquals(findLately.getRecipeId(), recipe);
    }

    @Test
    void 유저이름으로최근본레시피횟수검색() {

        // when
        int userIdCount = latelyRepository.countByUserId(user);

        // then
        assertEquals(userIdCount, 1);
    }
}