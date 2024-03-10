package com.example.presentation

import com.example.domain.exceptions.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.plugins.statuspages.*
import io.ktor.server.response.*

fun Application.installExceptionHandling() {
    install(StatusPages) {
        exception<CustomerExistsException> {call,  cause ->
            call.respond(HttpStatusCode.Conflict, cause.message ?: "Conflict")
        }
        exception<CustomerNotFoundException> {call,  cause: CustomerNotFoundException ->
            call.respond(HttpStatusCode.NotFound, cause.message ?: "Not found")
        }
        exception<InvalidCustomerDataException> { call, cause ->
            call.respond(HttpStatusCode.BadRequest, cause.message ?: "Bad request")
        }
        exception<InvalidAccountDataException> { call, cause ->
            call.respond(HttpStatusCode.BadRequest, cause.message ?: "Bad request")
        }
        exception<AccountNotFoundException> { call, cause ->
            call.respond(HttpStatusCode.NotFound, cause.message ?: "Not found")
        }
        exception<InsufficientFundsException> { call, cause ->
            call.respond(HttpStatusCode.BadRequest, cause.message ?: "Insufficient funds")
        }
        exception<AccountClosedException> { call, cause ->
            call.respond(HttpStatusCode.BadRequest, cause.message ?: "Account is closed")
        }
        exception<Throwable> { call, cause ->
            call.respondText("Internal Server Error: ${cause.localizedMessage}", status = HttpStatusCode.InternalServerError)
        }
    }
}
