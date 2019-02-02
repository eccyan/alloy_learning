abstract sig Role {}
lone sig Admin extends Role {}
lone sig Member extends Role {}

abstract sig Item  {}
lone sig Name extends Item {}
lone sig Tel extends Item {}

one sig Visibility { role : one Role, item : some Item }

fact adminCanSeeName {
  all v: Visibility,  r: Admin, i: Name | (r -> i) in (v.role -> v.item)
}
fact adminCanSeeTel {
  all v: Visibility,  r: Admin, i: Tel | (r -> i) in (v.role -> v.item)
}
fact memberCanSeeName {
  all v: Visibility,  r: Member, i: Name | (r -> i) in (v.role -> v.item)
}
fact memberCannotSeeTel {
  all v: Visibility,  r: Member, i: Tel | (r -> i) not in (v.role -> v.item)
}

run {} for 7
