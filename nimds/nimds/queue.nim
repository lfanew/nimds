## This module contains a data structure that represents a generic
## [Queue](https://en.wikipedia.org/wiki/Queue_(abstract_data_type))
## with a maximum size
type
  Queue*[T] = object
    ## The `Queue` type represents a generic Queue
    data: seq[T]
    ## Contains the elements in the queue
    size: int
    ## The maximum size of the queue
  
  FullError* = object of CatchableError
  EmptyError* = object of CatchableError

proc len*(q: Queue): int =
  ## Returns the length of the queue
  return q.data.len

proc enqueue*[T](q: var Queue[T], val: T) =
  ## Adds an element to the end of the queue
  if q.len < q.size:
    q.data.add(val)
  else:
    raise newException(FullError, "Attempted to enqueue full queue")

proc dequeue*[T](q: var Queue[T]): T =
  ## Removes and returns the element at the front of the queue
  if q.len > 0:
    result = q.data[0]
    q.data.delete(0)
  else:
    raise newException(EmptyError, "Attempted to dequeue empty queue")
  return result

proc isEmpty*(q: Queue): bool =
  ## Returns true if the queue is empty
  return q.len == 0

proc isFull*(q: Queue): bool =
  ## Returns ture if the queue is full
  return q.len == q.size

proc elements*[T](q: Queue[T]): seq[T] =
  ## Returns the elements in the queue as a sequence
  return q.data

proc get*[T](q: Queue[T], i: Natural): T =
  ## Returns the element in the queue located at index `i`
  return q.data[i]

proc initQueue*[T](size: int): Queue[T] =
  ## Initializes and returns an empty queue
  result = Queue[T](data: @[], size: size)
  return result
