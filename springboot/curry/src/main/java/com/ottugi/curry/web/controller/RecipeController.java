package com.ottugi.curry.web.controller;

import com.ottugi.curry.service.recipe.RecipeService;
import com.ottugi.curry.web.dto.recipe.RecipeListResponseDto;
import com.ottugi.curry.web.dto.recipe.RecipeRequestDto;
import com.ottugi.curry.web.dto.recipe.RecipeResponseDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags={"Recipe API (레시피 API)"})
@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class RecipeController {

    private final RecipeService recipeService;

    @PostMapping("/api/recipe/getRecipeList")
    @ApiOperation(value = "레시피 리스트 조회", notes = "레시피 리스트를 조회하여 레시피 북마크 유무와 함께 리턴합니다.")
    public ResponseEntity<List<RecipeListResponseDto>> getRecipeList(@RequestBody RecipeRequestDto recipeRequestDto) {
        return ResponseEntity.ok().body(recipeService.getRecipeList(recipeRequestDto));
    }

    @GetMapping("/api/recipe/getRecipeDetail")
    @ApiOperation(value = "레시피 상세 조회", notes = "레시피를 상세 조회하여 레시피 북마크 유무와 함께 리턴합니다. 이후 최근 본 레시피에 추가됩니다.")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userId", value = "회원 기본키", example = "1", required = true),
            @ApiImplicitParam(name = "recipeId", value = "레시피 기본키", example = "6909678", required = true),
    })
    public ResponseEntity<RecipeResponseDto> getRecipeDetail(@RequestParam Long userId, Long recipeId) {
        return ResponseEntity.ok().body(recipeService.getRecipeDetail(userId, recipeId));
    }
}
