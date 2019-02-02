abstract sig Role {}
sig Admin extends Role {}
sig Member extends Role {}

abstract sig Item  {}
sig Name extends Item {}
sig Tel extends Item {}

sig Visibility { role : some Role, item : some Item, }

fact anyoneCanSeeName {
  all v: Visibility | Name in v.item and Role in v.role
}
fact memberCannotSeeName  {
  all v: Visibility | Tel not in v.item and Member in v.role
}

run {} for 7 but 1 Visibility
