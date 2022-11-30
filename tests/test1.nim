# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import nimds/queue

test "Queue Test":
  var q = initQueue[string](2)
  q.enqueue("test")
  q.enqueue("asdf")

  expect(FullError):
    q.enqueue("too many")

  check q.len == 2

  check q.dequeue() == "test"
  check q.len == 1

  check q.dequeue() == "asdf"
  check q.len == 0

  expect(EmptyError):
    discard q.dequeue()
