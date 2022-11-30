# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import nimds/markov

test "Markov Chain Test":
  var chain = initChain[string]()
  
  let a = chain.add("a")
  let b = chain.add("b")
  let c = chain.add("c")

  chain.addTransition("a", "b")
  chain.addTransition("b", "c")
  chain.addTransition("c", "a")
  chain.addTransition("a", "c")
  chain.addTransition("a", "b")

  check a.len == 2
  check b.len == 1
  check c.len == 1

  check a.transitionCount(b) == 2
  check a.transitionCount(c) == 1
  check not b.hasTransition(a)

  check b.transitionCount(c) == 1
  check not b.hasTransition(a)
  check not b.hasTransition(b)

  check c.transitionCount(a) == 1
  check not c.hasTransition(b)
  check not c.hasTransition(c)
