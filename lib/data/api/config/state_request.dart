enum StateRequestEnum {
  success,
  loading,
  failed,
  socketFaild,
}

abstract class StateRequest {
  static StateRequestEnum state = StateRequestEnum.loading;
}
