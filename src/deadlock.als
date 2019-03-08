open util/ordering[Time]

sig Time {}

sig Mutex {}

sig Thread {
    dependsOn : set Mutex,
    lock : Mutex -> Time,
} {
    lock.Time in dependsOn
}

abstract sig Event {
    pre  : Time,
    post : Time,
} {
    post = pre.next
}

pred init(t : Time) {
    no Thread.lock.t
}

fact trace {
    init[first]
    all t : Time - last | one pre.t
}

sig Lock extends Event {
    target : Thread,
    mut    : Mutex
} {
    mut in target.dependsOn
    mut not in Thread.lock.pre
    target.lock.post = target.lock.pre + mut
    all th : Thread - target | th.lock.post = th.lock.pre
}

sig Unlock extends Event {
    target : Thread,
} {
    target.lock.pre = target.dependsOn
    no target.lock.post
    all th : Thread - target | th.lock.post = th.lock.pre
}

sig Skip extends Event {} {
    all th : Thread | th.lock.post = th.lock.pre
}

pred progressive(th : Thread, t : Time) {
    some th.dependsOn - Thread.lock.t
    || th.lock.t = th.dependsOn
}

assert deadlockFree {
    some Thread
    => all t : Time | some th : Thread | progressive[th, t]
}

// check deadlockFree for 2
check deadlockFree for 3
