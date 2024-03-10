package com.example.domain.utills

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.typesafe.config.ConfigFactory
import io.ktor.server.config.*
import java.util.*

object JwtConfig {
    private val config = HoconApplicationConfig(ConfigFactory.load())

    private val secret = config.property("ktor.jwt.secret").getString()
    private val issuer = config.property("ktor.jwt.issuer").getString()
    private const val validityInMs = 36_000_00 * 10

    private val algorithm = Algorithm.HMAC512(secret)

    fun generateToken(userId: String): String {
        val now = System.currentTimeMillis()
        return JWT.create()
            .withSubject("Authentication")
            .withIssuer(issuer)
            .withClaim("userId", userId)
            .withIssuedAt(Date(now))
            .withExpiresAt(Date(now + validityInMs))
            .sign(algorithm)
    }

    fun verifyToken(token: String): String? {
        val verifier = JWT.require(algorithm)
            .withIssuer(issuer)
            .build()
        val jwt = verifier.verify(token)
        return jwt.getClaim("userId").asString()
    }
}