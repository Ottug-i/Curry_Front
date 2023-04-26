package com.ottugi.curry.web.dto.lately;

import com.ottugi.curry.domain.recipe.Recipe;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class LatelyListResponseDtoTest {

    @Test
    void LatelyListResponseDto_롬복() {

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
        LatelyListResponseDto latelyListResponseDto = new LatelyListResponseDto(recipe);

        // then
        assertEquals(latelyListResponseDto.getId(), id);
        assertEquals(latelyListResponseDto.getName(), name);
        assertEquals(latelyListResponseDto.getThumbnail(), thumbnail);
    }
}