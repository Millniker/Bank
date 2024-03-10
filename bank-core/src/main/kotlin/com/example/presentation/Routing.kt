package com.example.presentation

import com.example.presentation.dto.CreateAccountDTO
import com.example.domain.models.Money
import com.example.domain.services.AccountService
import com.example.domain.services.CustomerService
import com.example.domain.services.TransactionService
import com.example.presentation.dto.CustomerAccountCreationDTO
import com.example.presentation.dto.DepositDTO
import com.example.presentation.dto.NewCustomerDTO
import com.example.presentation.dto.WithdrawDTO
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import org.koin.ktor.ext.inject

fun Application.configureRouting() {
    routing {
        val accountService: AccountService by inject()
        val customerService: CustomerService by inject()
        val transactionService: TransactionService by inject()

        route("/client") {

            get("/account/{accountId}") {
                val accountId = call.parameters["accountId"]?.toIntOrNull()
                    ?: return@get call.respond(HttpStatusCode.BadRequest, "Invalid account ID")

                val account = accountService.getAccountById(accountId)
                    ?: return@get call.respond(HttpStatusCode.NotFound, "Account not found")

                call.respond(account)
            }

            get("/customer/by-account/{accountId}") {
                val accountId = call.parameters["accountId"]?.toIntOrNull()
                    ?: return@get call.respond(HttpStatusCode.BadRequest, "Invalid account ID")

                val customer = customerService.getCustomerByAccountId(accountId)

                call.respond(customer)
            }

            post("/createCustomer") {
                val newCustomerDTO = call.receive<NewCustomerDTO>()

                val customer = customerService.createCustomer(newCustomerDTO.toCustomer())

                call.respond(HttpStatusCode.Created, customer)
            }

            post("/openAccount") {
                val userId = call.parameters["userId"]?.toString()
                    ?: return@post call.respond(HttpStatusCode.BadRequest, "Invalid user ID")

                val newAccountDTO = call.receive<CreateAccountDTO>()

                val account = accountService.openAccount(customerService.getCustomerByUserId(userId).id, newAccountDTO)

                call.respond(HttpStatusCode.Created, account)
            }

            post("/createAccountWithNewCustomer") {
                val customerAccountCreationDTO = call.receive<CustomerAccountCreationDTO>()
                val newCustomerDTO = customerAccountCreationDTO.customer
                val newAccountDTO = customerAccountCreationDTO.account

                val customer = customerService.createCustomer(newCustomerDTO.toCustomer())

                val account = accountService.openAccount(customer.id, newAccountDTO)

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

            get("/transactions/{accountId}") {
                val accountId = call.parameters["accountId"]?.toIntOrNull()
                    ?: return@get call.respond(HttpStatusCode.BadRequest, "Invalid account ID")

                val transactions = transactionService.getAccountTransactions(accountId)
                call.respond(HttpStatusCode.OK, transactions)
            }
        }

        route("/employee") {
            get("/accounts") {
                val accounts = customerService.getAllAccounts()
                call.respond(HttpStatusCode.OK, accounts)
            }

            get("/customers") {
                val customers = customerService.getAllCustomers()
                call.respond(customers)
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
