package com.ottugi.curry.web.controller;

import com.ottugi.curry.service.lately.LatelyService;
import com.ottugi.curry.web.dto.lately.LatelyListResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class LatelyController {

    private final LatelyService latelyService;

    @GetMapping("/api/lately/getLatelyAll")
    public ResponseEntity<List<LatelyListResponseDto>> getLatelyAll(@RequestParam Long userId) {
        return ResponseEntity.ok().body(latelyService.getLatelyAll(userId));
    }
}
