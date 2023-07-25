/// Состояния запроса на сервер
enum StateRequestEnum {
  success,
  idle,
  failed,
  socketFailed,
}

abstract class StateRequest {
  static StateRequestEnum state = StateRequestEnum.idle;
}
