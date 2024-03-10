package com.example.presentation

import com.example.data.entities.AccountRequestStatus
import com.example.domain.UserService
import com.example.presentation.dto.LoginDTO
import com.example.presentation.dto.StatusUpdateDTO
import com.example.presentation.dto.UserDTO
import com.example.presentation.dto.mapToUserModel
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import org.koin.ktor.ext.inject

fun Application.configureRouting() {
    routing {
        route("/user") {
            val userService: UserService by inject()
            post("/register") {
                val userDTO = call.receive<UserDTO>()
                val user = mapToUserModel(userDTO)

                val registeredUser = userService.registerUser(user)
                call.respond(HttpStatusCode.Created, registeredUser)

            }

            post("/login") {
                val loginDTO = call.receive<LoginDTO>()
                val token = userService.authenticate(loginDTO.email, loginDTO.password)
                call.respond(mapOf("token" to token))

            }

            get("/users") {
                val status = call.request.queryParameters["status"]?.let { AccountRequestStatus.valueOf(it) }
                val users = userService.getUsersByStatus(status ?: AccountRequestStatus.PENDING)
                call.respond(users)
            }

            post("/user/{userId}/updateStatus") {
                val token = call.request.header("Authorization")?.removePrefix("Bearer ")
                val userId = call.parameters["userId"]?.toIntOrNull()
                val newStatus = call.receive<StatusUpdateDTO>()

                if (token == null || userId == null) {
                    call.respond(HttpStatusCode.BadRequest, "Missing token or user ID")
                    return@post
                }


                userService.updateUserStatus(token, userId, newStatus.status)
                call.respond(HttpStatusCode.OK, "User status updated")
            }

            get("/{userId}") {
                val userId = call.parameters["userId"]?.toIntOrNull()
                    ?: return@get call.respond(HttpStatusCode.BadRequest, "Invalid user ID")

                val token = call.request.header("Authorization")?.removePrefix("Bearer ")

                if (token == null) {
                    call.respond(HttpStatusCode.BadRequest, "Missing token or user ID")
                    return@get
                }

                val user = userService.getUserById(token, userId)

                call.respond(user)
            }

            head("/{userId}") {
                val userId = call.parameters["userId"]?.toIntOrNull()
                    ?: return@head call.respond(HttpStatusCode.BadRequest, "Invalid user ID")

                val exists = userService.userExists(userId)
                if (exists) {
                    call.respond(HttpStatusCode.OK)
                } else {
                    call.respond(HttpStatusCode.NotFound)
                }
            }
        }
    }
}
