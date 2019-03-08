open util/ordering[Time]
open util/ordering[Cost]

sig Time {}
sig Cost {}

sig Node {
    link : set Node,
    pathCost : Cost  one -> Time,
    upstream : Node lone -> Time,
} {
    upstream.Time in link
}

fact topology {
    // all n1, n2 : Node | n2 in n1.link <=> n1 in n2.link
    // all n : Node | n not in n.link
    // all n1, n2 : Node | n2 in n1.*link
    link = ~link
    no link & iden
    Node -> Node in *link
}

one sig Root extends Node {}

pred unchanged(n : Node, t, t' : Time) {
    n.pathCost.t' = n.pathCost.t
    n.upstream.t' = n.upstream.t
}

pred locallyStable(n : Node, t : Time) {
    n.pathCost.t = n.upstream.t.pathCost.t.next
}

pred converged(t : Time) {
    Root.pathCost.t = first
    Root.upstream.t = none
    all n : Node - Root | locallyStable[n, t]
}

abstract sig Event {
    pre  : Time,
    post : Time,
} {
    post = pre.next
}

pred init(t : Time) {
    Node.pathCost.t = first
    Node.upstream.t = none
}

fact trace {
    init[first]
    all t : Time - last | one pre.t
}

sig Learn extends Event {
    learner : Node - Root
} {
    not learner.locallyStable[pre]
    let minCost = min[learner.link.pathCost.pre] {
        learner.upstream.post.pathCost.post = minCost 
        learner.pathCost.post = minCost.next
    }
    all n : Node - learner | unchanged[n, pre, post]
}

sig Skip extends Event {} {
    converged[pre]
    all n : Node | unchanged[n, pre, post]
}
　
/*
run converged for 4
run converged for 5
run converged for 6
*/

pred spanningTree(t : Time) {
    all n : Node | Root     in n.*(upstream.t)
    all n : Node | n    not in n.^(upstream.t)
}

assert validAlgorithm {
    all t : Time | converged[t] => spanningTree[t]
}

/*
check validAlgorithm for 4
check validAlgorithm for 5
check validAlgorithm for 6
*/
