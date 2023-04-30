mod hash;
use dep::std;
// Currently we assume that it is a binary tree, so depth k implies a width of 2^k
// XXX: In the future we can add an arity parameter

// Returns true if the leaf is in the tree and it is at the given index and the hashpath proves this
fn check_membership(root: Field, leaf_hash: Field, index: Field, hash_path: [Field], hash_function: fn(Field, Field) -> Field) -> bool {
  compute_root(leaf_hash, index, hash_path, hash_function) == root
}

// Returns the merkle root of the tree from the provided leaf, its hashpath, and a chosen hash function.
fn compute_root<N>(leaf_hash: Field, index: Field, hash_path: [Field; N], hash_function: fn(Field, Field) -> Field) -> Field {
    let index_bits = index.to_le_bits(N);
    let mut current = leaf_hash;
    for i in 0..N {
        let path_bit = index_bits[i] as bool;
        let (hash_left, hash_right) = if path_bit {
            (hash_path[i], current)
         } else {
            (current, hash_path[i])
         };

      current = hash_function(hash_left, hash_right);
    };
    current
}


#[test]
fn smoketest()
{
    // TODO: raise issue for error thrown when both lines are uncommented.
    //compute_root(1, 0, [1], hash::pedersen);
    compute_root(1, 0, [1], hash::mimc_bn254);
}
