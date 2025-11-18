import gleam/list

pub fn main() {
  // ========= Task 1 =========
  echo multiples_rec(999)
  echo multiples_tail_rec(999, 0)
  echo multiples_models(999)
  echo multiples_map(999)

  // ========= Task 2 =========

  echo digit_fifth_powers_rec(200_000)
  echo digit_fifth_powers_tail_rec(200_000, 0)
  echo digit_fifth_powers_models(200_000)
  echo sum_of_fifth_powers_of_digits_map(200_000)
}

// ========= Task 1 =========

pub fn multiples_rec(limit: Int) -> Int {
  case limit {
    0 -> 0
    _ -> {
      multiples_rec(limit - 1)
      + case limit % 3 == 0 || limit % 5 == 0 {
        True -> limit
        False -> 0
      }
    }
  }
}

pub fn multiples_tail_rec(limit: Int, acc: Int) -> Int {
  case limit {
    0 -> acc
    _ -> {
      let tmp = case limit % 3 == 0 || limit % 5 == 0 {
        True -> limit
        False -> 0
      }
      multiples_tail_rec(limit - 1, acc + tmp)
    }
  }
}

pub fn multiples_models(limit: Int) -> Int {
  generate_numbers(limit)
  |> filter_multiples
  |> sum
}

pub fn sum(numbers: List(Int)) -> Int {
  list.fold(numbers, 0, fn(acc, n) { acc + n })
}

pub fn filter_multiples(numbers: List(Int)) -> List(Int) {
  list.filter(numbers, fn(n) { n % 3 == 0 || n % 5 == 0 })
}

pub fn generate_numbers(limit: Int) -> List(Int) {
  list.range(1, limit)
}

pub fn multiples_map(limit: Int) -> Int {
  list.map(list.range(1, limit), fn(n) {
    case n % 3 == 0 || n % 5 == 0 {
      True -> n
      False -> 0
    }
  })
  |> sum
}

// ========= Task 2 =========

pub fn digit_fifth_powers_rec(limit: Int) -> Int {
  case limit {
    1 -> 0
    _ -> {
      let sum = sum_of_fifth_powers_pf_digits_rec(limit)

      case sum == limit {
        True -> limit + digit_fifth_powers_rec(limit - 1)
        False -> digit_fifth_powers_rec(limit - 1)
      }
    }
  }
}

fn sum_of_fifth_powers_pf_digits_rec(n: Int) -> Int {
  case n {
    0 -> 0
    _ -> {
      let digit = n % 10
      let rest = n / 10
      digit
      * digit
      * digit
      * digit
      * digit
      + sum_of_fifth_powers_pf_digits_rec(rest)
    }
  }
}

pub fn digit_fifth_powers_tail_rec(limit: Int, acc: Int) -> Int {
  case limit {
    1 -> acc
    _ -> {
      let sum = sum_of_fifth_powers_pf_digits_tail_rec(limit, 0)

      case sum == limit {
        True -> digit_fifth_powers_tail_rec(limit - 1, acc + limit)
        False -> digit_fifth_powers_tail_rec(limit - 1, acc)
      }
    }
  }
}

pub fn sum_of_fifth_powers_pf_digits_tail_rec(n: Int, acc: Int) -> Int {
  case n {
    0 -> acc
    _ -> {
      let digit = n % 10
      let rest = n / 10
      sum_of_fifth_powers_pf_digits_tail_rec(
        rest,
        digit * digit * digit * digit * digit + acc,
      )
    }
  }
}

pub fn digit_fifth_powers_models(n: Int) -> Int {
  list.range(2, n)
  |> filter_numbers
  |> sum
}

fn sum_of_fifth_powers_of_digits_models(n: Int) -> Int {
  n
  |> digits
  |> list.map(fifth_power)
  |> list.fold(0, fn(acc, x) { acc + x })
}

fn digits(n: Int) -> List(Int) {
  case n {
    0 -> []
    _ -> list.append(digits(n / 10), [n % 10])
  }
}

fn fifth_power(x: Int) -> Int {
  x * x * x * x * x
}

fn filter_numbers(list: List(Int)) -> List(Int) {
  list.filter(list, fn(x) { x == sum_of_fifth_powers_of_digits_models(x) })
}

pub fn sum_of_fifth_powers_of_digits_map(limit: Int) -> Int {
  list.map(list.range(2, limit), fn(n) {
    case sum_of_fifth_powers_pf_digits_rec(n) == n {
      True -> n
      False -> 0
    }
  })
  |> sum
}
