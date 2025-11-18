import lab1

pub fn test_multiples() {
  let expected = 233_168

  assert lab1.multiples_rec(999) == expected
  assert lab1.multiples_tail_rec(999, 0) == expected
  assert lab1.multiples_models(999) == expected
  assert lab1.multiples_map(999) == expected
}

pub fn test_digit_fifth_powers() {
  let expected = 443_839

  assert lab1.digit_fifth_powers_rec(200_000) == expected
  assert lab1.digit_fifth_powers_tail_rec(200_000, 0) == expected
  assert lab1.digit_fifth_powers_models(200_000) == expected
  assert lab1.sum_of_fifth_powers_of_digits_map(200_000) == expected
}

pub fn main() {
  test_multiples()
  test_digit_fifth_powers()
}
