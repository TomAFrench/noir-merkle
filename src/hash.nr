use dep::std;

// A collection of wrappers around the stdlib's hash functions to make them conform to the
// interface `fn(Field, Field) -> Field`

fn pedersen(left: Field, right: Field) -> Field {
  std::hash::pedersen([left, right])[0]
}

fn mimc_bn254(left: Field, right: Field) -> Field {
  std::hash::mimc_bn254([left, right])
}
