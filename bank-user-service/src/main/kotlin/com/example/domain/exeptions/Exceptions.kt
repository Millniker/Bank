package com.example.domain.exeptions

class UserNotFoundException(message: String) : Exception(message)
class InvalidLoginCredentialsException(message: String) : Exception(message)
class UserNotApprovedException(message: String) : Exception(message)
class UserRejectedException(message: String) : Exception(message)
class UnauthorizedAccessException(message: String) : Exception(message)
class InvalidUserDataException(message: String) : Exception(message)
class EmailAlreadyExistsException(message: String) : Exception(message)