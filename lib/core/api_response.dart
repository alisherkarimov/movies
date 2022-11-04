class ApiResponse<T> {
  Status status;
  T? data;
  String? massage;

  ApiResponse.initial(this.massage) : status = Status.INITIAL;

  ApiResponse.loading(this.massage) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.massage) : status = Status.ERROR;
}

enum Status { INITIAL, COMPLETED, ERROR, LOADING }
