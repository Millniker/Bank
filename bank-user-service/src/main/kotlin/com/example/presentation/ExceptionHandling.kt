package com.example.presentation

import com.example.domain.exeptions.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.plugins.statuspages.*
import io.ktor.server.response.*

fun Application.installExceptionHandling() {
    install(StatusPages) {
        exception<UserNotFoundException> { call, cause ->
            call.respond(HttpStatusCode.NotFound, cause.message ?: "User not found")
        }
        exception<InvalidLoginCredentialsException> { call, cause ->
            call.respond(HttpStatusCode.Unauthorized, cause.message ?: "Invalid login credentials")
        }
        exception<UserNotApprovedException> { call, cause ->
            call.respond(HttpStatusCode.Forbidden, cause.message ?: "User not approved")
        }
        exception<UserRejectedException> { call, cause ->
            call.respond(HttpStatusCode.Forbidden, cause.message ?: "User rejected")
        }
        exception<UnauthorizedAccessException> { call, cause ->
            call.respond(HttpStatusCode.Unauthorized, cause.message ?: "Unauthorized access")
        }
        exception<InvalidUserDataException> { call, cause ->
            call.respond(HttpStatusCode.BadRequest, cause.message ?: "Invalid user data")
        }
        exception<EmailAlreadyExistsException> { call, cause ->
            call.respond(HttpStatusCode.Conflict, cause.message ?: "Email already exists")
        }
        exception<Throwable> { call, cause ->
            call.respondText("Internal Server Error: ${cause.localizedMessage}", status = HttpStatusCode.InternalServerError)
        }
    }
}
