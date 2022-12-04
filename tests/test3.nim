import unittest
import nimds/list

test "LinkedList - Add":
  var list = initLinkedList[string]()
  check list.len == 0

  list.add("a")
  check list.len == 1

  list.add("b")
  check list.len == 2

  list.add("c")
  check list.len == 3

  for idx, item in list.pairs:
    case idx:
    of 0:
      check item == "a"
    of 1:
      check item == "b"
    of 2:
      check item == "c"
    else:
      fail()
    

test "LinkedList - InsertBefore":
  var list = initLinkedList[string]()
  check list.len == 0

  expect(IndexDefect):
    list.insertBefore(0, "a")

  list.add("b")
  check list.len == 1

  list.insertBefore(0, "c")
  check list.len == 2

  list.insertBefore(1, "a")
  check list.len == 3

  for idx, item in list.pairs:
    case idx:
    of 0:
      check item == "c"
    of 1:
      check item == "a"
    of 2:
      check item == "b"
    else:
      fail()

test "LinkedList - InsertAfter":
  var list = initLinkedList[string]()
  check list.len == 0

  expect(IndexDefect):
    list.insertAfter(0, "a")

  list.add("c")
  check list.len == 1

  list.insertAfter(0, "b")
  check list.len == 2

  list.insertAfter(0, "a")
  check list.len == 3

  for idx, item in list.pairs:
    case idx:
    of 0:
      check item == "c"
    of 1:
      check item == "a"
    of 2:
      check item == "b"
    else:
      fail()

test "LinkedList - addFirst":
  var list = initLinkedList[string]()
  check list.len == 0

  list.addFirst("b")
  check list.len == 1

  list.addFirst("a")
  check list.len == 2

  list.addFirst("c")
  check list.len == 3

  for idx, item in list.pairs:
    case idx:
    of 0:
      check item == "c"
    of 1:
      check item == "a"
    of 2:
      check item == "b"
    else:
      fail()

test "LinkedList - addLast":
  var list = initLinkedList[string]()
  check list.len == 0

  list.addLast("c")
  check list.len == 1

  list.addLast("a")
  check list.len == 2

  list.addLast("b")
  check list.len == 3

  for idx, item in list.pairs:
    case idx:
    of 0:
      check item == "c"
    of 1:
      check item == "a"
    of 2:
      check item == "b"
    else:
      fail()

test "LinkedList - remove":
  var list = initLinkedList[string]()
  check list.len == 0

  list.add("c")
  check list.len == 1

  list.add("a")
  check list.len == 2

  list.add("b")
  check list.len == 3

  check list.remove() == "c"
  check list.len == 2

  check list.remove() == "a"
  check list.len == 1

  check list.remove() == "b"
  check list.len == 0

test "LinkedList - removeAt":
  var list = initLinkedList[string]()
  check list.len == 0

  list.add("c")
  check list.len == 1

  list.add("a")
  check list.len == 2

  list.add("b")
  check list.len == 3

  check list.removeAt(2) == "b"
  check list.len == 2

  check list.removeAt(1) == "a"
  check list.len == 1

  check list.removeAt(0) == "c"
  check list.len == 0
