abstract sig Object {}

sig File extends Object {}

sig Directory extends Object {
    children : set Object
}

fact singleParent {
    all o : Object | lone children.o
}

fact acyclic {
    all o : Object | o not in o.^children
}

fact connected {
    all o1, o2 : Object | o2 in o1.*(children + ~children)
}

pred emptyDir {
    some d : Directory | no d.children
}

pred nonEmptyDir {
    some d : Directory | some d.children
}

pred deepDir {
    some d : Directory | some d.children.children
}

pred multiFileDir {
    some d : Directory | #(d.children & File) >= 2
}

run emptyDir     for 7
run nonEmptyDir  for 7
run deepDir      for 7
run multiFileDir for 7

assert uniqueRoot {
    one r : Object | no children.r
}

fact nonEmptyFS {
    some Object
}

check uniqueRoot for 7
