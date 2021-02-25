abstract class LoginError implements Exception {}

class ErrorNotLogged extends LoginError {}

class ErrorInvalidCredentials extends LoginError {}

class ErrorAccountAlreadyExists extends LoginError {}

class ErrorCouldntLogout extends LoginError {}
