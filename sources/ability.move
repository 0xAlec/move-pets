module pet::ability {

  struct Attack {}
  struct Defense {}
  struct Util {}

  struct Ability<phantom T> has store{
    mana_cost: u8,
  }

  // Reads
  public fun get_mana_cost<T>(ability: &Ability<T>): u8 {
    ability.mana_cost
  }
}