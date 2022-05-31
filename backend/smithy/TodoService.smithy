namespace smithy4s.hello

use smithy4s.api#simpleRestJson

@simpleRestJson
service TodoService {
  version: "1.0.0",
  operations: [GetTodo, GetTodos, UpdateTodo, CreateTodo, DeleteTodo],
  errors: [BadInput]
}

@readonly
@http(method: "GET", uri: "/todo")
operation GetTodos {   
  output: Todos,  
}

@readonly
@http(method: "GET", uri: "/todo/{id}")
operation GetTodo {
  input: TodoInput,
  output: Todo,
  errors: [BadInput]
}

@http(method: "POST", uri: "/todo/{id}")
operation UpdateTodo {    
  input: Todo, 
  output: Todo,
  errors: [BadInput]
}

@http(method: "PUT", uri: "/todo")
operation CreateTodo {    
  input: NewTodo, 
  output: Todo,
  errors: [BadInput]
}

@http(method: "DELETE", uri: "/todo/{id}")
operation DeleteTodo {    
  input: TodoInput, 
  output: TodoDeletedCount,
  errors: [BadInput]
}

structure TodoInput {
  @httpLabel
  @required
  id:String
}

structure TodoDeletedCount {
  @httpLabel
  @required
  count: Integer
}


@error("client")
@httpError(480)
structure BadInput {
  @jsonName("error")
  message: String
}

structure NewTodo {
  description: String,
  complete: Boolean
}

structure Todo {
  @httpLabel
  @required
  id: String,
  description: String,
  complete: Boolean
}

structure Todos {
  todos: TodoList
}


list TodoList {
  member: Todo
}