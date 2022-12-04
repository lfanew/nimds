## Implementation of singly linked list

type
  Node[T] = ref object
    val: T
    next: Node[T]
  LinkedList*[T] = object
    head*: Node[T]
    tail*: Node[T]
    len*: int

proc initLinkedList*[T](): LinkedList[T] =
  result = LinkedList[T](head: nil, tail: nil, len: 0)

proc initNode[T](val: T, next: Node[T]): Node[T] =
  result = Node[T](val: val, next: next)

# proc len(list: LinkedList): int =
#   result = list.len

iterator items*[T](list: LinkedList[T]): T =
  var node = list.head
  while node != nil:
    yield node.val
    node = node.next

iterator pairs*[T](list: LinkedList[T]): (int, T) =
  var node = list.head
  var index = 0
  while node != nil:
    yield (index, node.val)
    node = node.next
    inc index

iterator nodePairs[T](list: LinkedList[T]): (int, Node[T]) =
  var node = list.head
  var index = 0
  while node != nil:
    yield (index, node)
    node = node.next
    inc index

proc add*[T](list: var LinkedList[T], val: T) =
  let node = initNode(val, nil)
  
  if list.len == 0:
    list.head = node
  else:
    list.tail.next = node
  
  list.tail = node
  inc list.len

proc insertBefore*[T](list: var LinkedList[T], index: int, val: T) =
  if list.len == 0 or index >= list.len:
    raise newException(IndexDefect, "Invalid index")
  elif index == 0:
    list.head = initNode(val, list.head.next)
    inc list.len
  for idx, item in list.nodePairs:
    if idx == index - 1:
      item.next = initNode(val, item.next)
      inc list.len
      break

proc insertAfter*[T](list: var LinkedList[T], index: int, val: T) =
  if list.len == 0 or index >= list.len:
    raise newException(IndexDefect, "Invalid index")
  for idx, item in list.nodePairs:
    if idx == index:
      item.next = initNode(val, item.next)
      inc list.len
      break

proc addFirst*[T](list: var LinkedList[T], val: T) =
  let node = initNode(val, list.head)
  list.head = node
  if list.len == 0:
    list.tail = node
  inc list.len

proc addLast*[T](list: var LinkedList[T], val: T) =
  list.add(val)
  
proc remove*[T](list: var LinkedList[T]): T =
  result = list.head.val
  list.head = list.head.next
  dec list.len

proc removeAt*[T](list: var LinkedList[T], index: int): T =
  if list.len == 0 or index >= list.len:
    raise newException(IndexDefect, "Invalid index")
  elif index == 0:
    result = list.head.val
    list.head = list.head.next
    dec list.len
  for idx, item in list.nodePairs:
    if idx == index - 1:
      result = item.next.val
      item.next = item.next.next
      dec list.len
      break
  
  return result

proc pop*[T](list: var LinkedList[T]): T =
  result = list.removeAt(list.len - 1)
