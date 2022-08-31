part of 'update_users_bloc.dart';

enum UpdateState { init, error, success }

class UpdateUsersState extends Equatable {
  final String message;
  final UpdateState updateState;
  const UpdateUsersState({required this.message, required this.updateState});
  const UpdateUsersState.init()
      : this(message: "init", updateState: UpdateState.init);
  const UpdateUsersState.error(String message)
      : this(message: message, updateState: UpdateState.error);
  const UpdateUsersState.success(String message)
      : this(message: message, updateState: UpdateState.success);
  @override
  List<Object> get props => [message, updateState];
}
