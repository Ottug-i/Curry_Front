package com.ottugi.curry.web.controller;

import com.ottugi.curry.service.lately.LatelyServiceImpl;
import com.ottugi.curry.web.dto.lately.LatelyListResponseDto;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.Matchers.hasSize;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class LatelyControllerTest {

    Long userId = 1L;

    private MockMvc mockMvc;

    @Mock
    private LatelyServiceImpl latelyService;

    @InjectMocks
    private LatelyController latelyController;

    @BeforeEach
    public void setUp() {
        mockMvc = MockMvcBuilders.standaloneSetup(latelyController).build();
    }

    @Test
    void 최근본레시피리스트조회() throws Exception {

        // given
        List<LatelyListResponseDto> latelyListResponseDtoList = new ArrayList<>();

        // when
        when(latelyService.getLatelyAll(userId)).thenReturn(latelyListResponseDtoList);

        // then
        mockMvc.perform(get("/api/lately/getLatelyAll")
                        .param("userId", String.valueOf(userId))
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(0)));
    }
}