package com.ottugi.curry.service.recipe;

import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.recipe.RecipeRepository;
import com.ottugi.curry.web.dto.recipe.RecipeRequestDto;
import com.ottugi.curry.web.dto.recipe.RecipeResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class RecipeServiceImpl implements RecipeService {

    private final RecipeRepository recipeRepository;
    // TODO : 레시피 별 북마크 도메인 설계 후 수정
    // private final BookmarkRepository bookmarkRepository;

    @Override
    public List<RecipeResponseDto> getRecipeList(RecipeRequestDto recipeRequestDto) {

        List<Recipe> recipeList = recipeRepository.findByIdIn(recipeRequestDto.getRecipeId());
        if (recipeList.size() != recipeRequestDto.getRecipeId().size()) {
            throw new IllegalArgumentException("해당 레시피가 없습니다.");
        }

        return recipeList.stream().map(RecipeResponseDto::new).collect(Collectors.toList());
    }

    @Override
    public RecipeResponseDto getRecipeDetail(Long userId, Long recipeId) {

        Recipe recipe = recipeRepository.findById(recipeId).orElseThrow(() -> new IllegalArgumentException("해당 레시피가 없습니다."));
        return new RecipeResponseDto(recipe);
    }

    // Boolean checkBookmark(Long userId) {
    // }
}
