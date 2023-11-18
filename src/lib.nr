// Currently we assume that it is a binary tree, so depth k implies a width of 2^k
// XXX: In the future we can add an arity parameter

// Returns the merkle root of the tree from the provided leaf, its hashpath, and a chosen hash function.
pub fn compute_root<N>(leaf_hash: Field, index: Field, hash_path: [Field; N], hash_function: fn([Field; 2]) -> Field) -> Field {
    let index_bits = index.to_le_bits(N);
    let mut current = leaf_hash;
    for i in 0..N {
        let path_bit = index_bits[i] as bool;
        let hash_input = if path_bit {
            [hash_path[i], current]
        } else {
            [current, hash_path[i]]
        };

        current = hash_function(hash_input);
    }
    current
}


mod tests {
  use dep::std::hash::{pedersen_hash, mimc::mimc_bn254};
  
  use crate::compute_root;

  #[test]
  fn smoketest() {
  
    compute_root(1, 0, [1], pedersen_hash);
    compute_root(1, 0, [1], mimc_bn254);
  }
}

