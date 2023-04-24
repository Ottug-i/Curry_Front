package com.ottugi.curry.web.dto.bookmark;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class BookmarkRequestDto {

    Long userId;

    Long recipeId;

    @Builder
    public BookmarkRequestDto(Long userId, Long recipeId) {
        this.userId = userId;
        this.recipeId = recipeId;
    }
}
