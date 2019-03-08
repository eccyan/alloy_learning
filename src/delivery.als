abstract sig Day { }
one sig Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday extends Day { }

sig Time { }
sig Period {
  t1, t2 : one Time,
} {
  t1 != t2
}

one sig Deliverer {
  days    : some Day,
  periods : some Period,
}

run {} for 18 but 3 Day, 3 Period
