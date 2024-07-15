sealed class AppError {
  final String message;

  const AppError({required this.message});
}

class ServerError extends AppError {
  ServerError({required super.message});
}

class ItemNotFound extends AppError {
  ItemNotFound({required super.message});
}

class UnableToSaveItem extends AppError {
  UnableToSaveItem({required super.message});
}

class UnableToRemoveItem extends AppError {
  UnableToRemoveItem({required super.message});
}
