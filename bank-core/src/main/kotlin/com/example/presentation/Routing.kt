package com.example.presentation

import com.example.domain.models.Money
import com.example.domain.services.AccountService
import com.example.domain.services.TransactionFlow
import com.example.domain.services.TransactionService
import com.example.presentation.dto.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.http.content.*
import io.ktor.server.plugins.openapi.*
import io.ktor.server.plugins.swagger.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.websocket.*
import io.ktor.websocket.*
import io.swagger.codegen.v3.generators.html.StaticHtmlCodegen
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import org.koin.ktor.ext.inject

fun Application.configureRouting() {
    routing {
        val accountService: AccountService by inject()
        val transactionService: TransactionService by inject()

        swaggerUI(path = "swagger", swaggerFile = "documentation.yaml") {
            version = "4.15.5"
        }
        openAPI(path="openapi", swaggerFile = "documentation.yaml") {
            codegen = StaticHtmlCodegen()
        }

        route("/client") {

            get("/account/{accountId}") {
                val accountId = call.parameters["accountId"]?.toIntOrNull()
                    ?: return@get call.respond(HttpStatusCode.BadRequest, "Invalid account ID")

                val account = accountService.getAccountById(accountId)

                call.respond(account)
            }

            get("/userId/by-account/{accountId}") {
                val accountId = call.parameters["accountId"]?.toIntOrNull()
                    ?: return@get call.respond(HttpStatusCode.BadRequest, "Invalid account ID")

                val account = accountService.getAccountById(accountId)

                call.respond(UserInfoDto(userId = account.userId))
            }

            post("/openAccount/{userId}") {
                val userId = call.parameters["userId"]
                    ?: return@post call.respond(HttpStatusCode.BadRequest, "Invalid user ID")

                val newAccountDTO = call.receive<CreateAccountDTO>()
                val account = accountService.openAccount(userId, newAccountDTO)
                call.respond(HttpStatusCode.Created, account)
            }


            post("/closeAccount/{accountId}") {
                val accountId = call.parameters["accountId"]?.toIntOrNull()
                    ?: return@post call.respond(HttpStatusCode.BadRequest, "Invalid account ID")

                accountService.closeAccount(accountId)
                call.respond(HttpStatusCode.OK, "Account closed successfully")
            }

            post("/deposit") {
                val depositDTO = call.receive<DepositDTO>()

                accountService.deposit(depositDTO.accountId, Money(depositDTO.amount, depositDTO.currencyType))
                call.respond(HttpStatusCode.OK, "Deposit successful")
            }

            post("/withdraw") {
                val withdrawDTO = call.receive<WithdrawDTO>()

                accountService.withdraw(withdrawDTO.accountId, Money(withdrawDTO.amount, withdrawDTO.currencyType))
                call.respond(HttpStatusCode.OK, "Withdrawal successful")
            }

            post("/transfer") {
                val transferRequest = try {
                    call.receive<TransferRequestDTO>()
                } catch (e: Exception) {
                    return@post call.respond(HttpStatusCode.BadRequest, "Invalid request")
                }
                accountService.transfer(
                    fromAccountId = transferRequest.fromAccountId,
                    toAccountId = transferRequest.toAccountId,
                    money = Money(
                        amount = transferRequest.amount,
                        currencyType = transferRequest.currencyType
                    ),
                )
                call.respond(HttpStatusCode.OK, "Transfer successful")
            }

            webSocket("/transactions/{accountId}") {
                val accountId = call.parameters["accountId"]?.toIntOrNull() ?: return@webSocket close()

                val initialTransactions = transactionService.getAccountTransactions(accountId)
                send(Frame.Text(Json.encodeToString(initialTransactions)))


                TransactionFlow.getTransactionsFlowForAccount(accountId).collect {
                    val updatedTransactions = transactionService.getAccountTransactions(accountId)
                    send(Frame.Text(Json.encodeToString(updatedTransactions)))
                }

            }

            get("/transactions/{accountId}") {
                val accountId = call.parameters["accountId"]?.toIntOrNull()
                    ?: return@get call.respond(HttpStatusCode.BadRequest, "Invalid account ID")

                val transactions = transactionService.getAccountTransactions(accountId)
                call.respond(HttpStatusCode.OK, transactions)
            }

            post("/accounts/{userId}") {
                val userId = call.parameters["userId"]
                    ?: return@post call.respond(HttpStatusCode.BadRequest, "Invalid user ID")

                val accounts = accountService.getAccountsByUserId(userId)
                call.respond(HttpStatusCode.Created, accounts)
            }
        }

        route("/employee") {
            get("/accounts") {
                val accounts = accountService.getAllAccounts()
                call.respond(HttpStatusCode.OK, accounts)
            }

            get("/users") {
                val users = accountService.getAllUniqueUsersWithAccount()
                call.respond(HttpStatusCode.OK, users)
            }

            get("/account/{accountId}/transactions") {
                val accountId = call.parameters["accountId"]?.toIntOrNull()
                    ?: return@get call.respond(HttpStatusCode.BadRequest, "Invalid account ID")

                val transactions = transactionService.getAccountTransactions(accountId)
                call.respond(HttpStatusCode.OK, transactions)
            }
        }
    }
}