module 0x1::Charity {

    struct CharityAccount has store {
        balance: u64,
    }

    public fun create_account(account: &mut BorrowGlobal<CharityAccount>, initial_balance: u64) {
        let new_account = CharityAccount {
            balance: initial_balance,
        };
        move_to(account, new_account);
    }

    public fun deposit(account: &mut BorrowGlobal<CharityAccount>, amount: u64) {
        let mut acc = borrow_global_mut<CharityAccount>(account.address());
        acc.balance = acc.balance + amount;
    }

    public fun withdraw(account: &mut BorrowGlobal<CharityAccount>, amount: u64) {
        let mut acc = borrow_global_mut<CharityAccount>(account.address());
        assert!(acc.balance >= amount, 0);  // Ensure there are sufficient funds
        acc.balance = acc.balance - amount;
    }

    public fun get_balance(account: &CharityAccount): u64 {
        account.balance
    }
}