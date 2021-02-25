abstract class LoginError implements Exception {}

class NotLogged extends LoginError {}

class InvalidCredentials extends LoginError {}

class AccountAlreadyExists extends LoginError {}

class CouldntLogout extends LoginError {}
