let Input : Type = {x : Text, y : Text}
let f = \(s : Input) -> [s.x, s.y]
in f {x="hello", y="world"}
