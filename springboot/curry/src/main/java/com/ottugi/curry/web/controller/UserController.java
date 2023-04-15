package com.ottugi.curry.web.controller;

import com.ottugi.curry.service.user.UserService;
import com.ottugi.curry.web.dto.user.TokenDto;
import com.ottugi.curry.web.dto.user.UserResponseDto;
import com.ottugi.curry.web.dto.user.UserSaveRequestDto;
import com.ottugi.curry.web.dto.user.UserUpdateRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class UserController {

    private final UserService userService;

    @PostMapping("/auth/login")
    public ResponseEntity<TokenDto> login(@RequestBody UserSaveRequestDto userSaveRequestDto) {
        return ResponseEntity.ok().body(userService.login(userSaveRequestDto));
    }

    @GetMapping("/api/user/getProfile")
    public ResponseEntity<UserResponseDto> getProfile(@RequestParam Long id) {
        return ResponseEntity.ok().body(userService.getProfile(id));
    }

    @PutMapping("/api/user/setProfile")
    public ResponseEntity<UserResponseDto> setProfile(@RequestBody UserUpdateRequestDto userUpdateRequestDto) {
        return ResponseEntity.ok().body(userService.setProfile(userUpdateRequestDto));
    }

    @DeleteMapping("/api/user/setWithdraw")
    public ResponseEntity<Boolean> setWithdraw(@RequestParam Long id) {
        return ResponseEntity.ok().body(userService.setWithdraw(id));
    }
}
