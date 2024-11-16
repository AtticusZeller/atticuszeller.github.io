# FastApi

The function parameters will be recognized as follows:

1. If the parameter is also declared in the path, it will be used as a path parameter.
2. If the parameter is of a singular type (like int, float, str, bool, etc) it will be interpreted as a query parameter.

> [!info]
> FastAPI will know that the value of q is not required because of the default value = None.

1. If the parameter is declared to be of the type of a Pydantic model, it will be interpreted as a request body.
