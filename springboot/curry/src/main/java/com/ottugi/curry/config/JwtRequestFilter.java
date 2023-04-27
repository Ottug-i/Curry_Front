package com.ottugi.curry.config;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Component
public class JwtRequestFilter extends OncePerRequestFilter {

    public static final String AUTHORIZATION_HEADER = "Authorization";

    @Value("${jwt.secret}")
    public String secret;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        final String jwtHeader = request.getHeader(AUTHORIZATION_HEADER);
        String email = null;
        String jwtToken = null;
        if (jwtHeader != null && jwtHeader.startsWith("Bearer ")) {
            jwtToken = jwtHeader.substring(7);
            try {
                email = JWT.require(Algorithm.HMAC512(secret)).build().verify(jwtToken).getSubject();
                List<GrantedAuthority> roles = new ArrayList<>();
                String role = JWT.require(Algorithm.HMAC512(secret)).build().verify(jwtToken).getClaim("role").asString();
                roles.add(new SimpleGrantedAuthority(role));

                UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(email, null, roles);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            } catch (IllegalArgumentException e) {
                System.out.println("토큰을 얻을 수 없습니다.");
            } catch (TokenExpiredException e) {
                System.out.println("토큰이 만료되었습니다.");
            } catch (JWTVerificationException e) {
                System.out.println("유효하지 않은 토큰입니다.");
            }
        }

        filterChain.doFilter(request, response);
    }
}