## This module contains a data structure and related methods
## for a generic [Markov chain](https://en.wikipedia.org/wiki/Markov_chain)

import std/tables
import std/random
import std/hashes 

randomize()

type
  Node*[T] = ref object
    ## The `Node` type represents a Markov state. It has a value and
    ## a table of transitions that will point to other nodes (states)
    state*: T
    ## Transitions are count based. So, a `nodeA` could have _n_ number of
    ## transitions to `nodeB`, with larger counts yielding a higher
    ## probability
    transitions*: Table[Node[T], int]

  Chain*[T] = object
    ## The `Chain` type represents a Markov chain. It uses a `Table`
    ## to look up `Node`s by their value (`state`).
    nodes: Table[T, Node[T]]
    states*: seq[T]

proc len*(chain: Chain): int =
  ## Returns the number of states in the chain
  result = chain.states.len

proc len*(node: Node): int =
  ## Returns the number of transitions from `node`
  result = node.transitions.len

proc hasTransition*(n1: Node, n2: Node): bool =
  ## Returns true if there is a transition from `n1` to `n2`
  result = n1.transitions.hasKey(n2)

proc transitionCount*(n1: Node, n2: Node): int =
  ## Returns the number of transitions (probability) from `n1` to `n2`
  if n1.hasTransition(n2):
    result = n1.transitions[n2]
  else:
    result = 0

proc hash*[T](node: Node[T]): Hash =
  ## Returns the hash of a `Node`
  return node.state.hash

proc initNode*[T](state: T): Node[T] =
  ## Initializes a `Node`
  return Node[T](state: state, transitions: initTable[Node[T], int]())

proc initChain*[T](): Chain[T] =
  ## Initializes a `Chain`
  result = Chain[T](nodes: initTable[T, Node[T]](), states: @[])
  return result

proc get*[T](chain: Chain[T], state: T): Node[T] =
  ## Returns the `Node` with that matches `state`
  return chain.nodes[state]

proc contains*[T](chain: Chain[T], state: T): bool =
  ## Returns true if the chain contains `state`
  return chain.nodes.hasKey(state)

proc add*[T](chain: var Chain[T], state: T): Node[T] =
  ## Adds a Node with the value `state` to the Markov chain
  result = initNode(state)
  chain.nodes[state] = result
  chain.states.add(state)
  return result

proc addTransition*[T](chain: var Chain[T], s1: T, s2: T) =
  ## Adds a Node with the value `s2` to the Markov chain and adds a transition
  ## from `s1` to `s2`
  let s1 = chain.get(s1)
  let s2 = chain.get(s2)

  discard s1.transitions.hasKeyOrPut(s2, 0)
  s1.transitions[s2] += 1

proc getRandomNode*[T](chain: Chain[T]): Node[T] =
  ## Returns a random node from the chain
  let key = chain.states.sample()
  return chain.get(key)

proc next*[T](node: Node[T]): Node[T] =
  ## Returns a random node based on the probability of possible transitions
  var sum = 0
  for n in node.transitions.keys:
    sum += node.transitions[n]
  
  var rnd = rand(0 ..< sum)

  for n in node.transitions.keys:
    if rnd < node.transitions[n]:
      return n
    
    rnd -= node.transitions[n]
