@IsTest
public class ListsTest {
	static List<Account> testData() {
		List<Account> accounts = new List<Account>();
		accounts.add(new Account(Name = 'Foo', AnnualRevenue = 100));
		accounts.add(new Account(Name = 'Bar', AnnualRevenue = 60));
		accounts.add(new Account(Name = 'Foo', AnnualRevenue = 150));
		accounts.add(new Account(Name = 'Bar', AnnualRevenue = 150));
		return accounts;
	}
	@IsTest
	public static void testPlucking() {
		List<Account> accounts = testData();
		List<String> names = Lists.pluckStringy(accounts, Account.Name);
		System.assertEquals(4, names.size());
		Set<String> nameSet = new Set<String>(names);
		System.assertEquals(2, nameSet.size());
		System.assert(nameSet.contains('Foo'));
		System.assert(nameSet.contains('Bar'));
	}
	@IsTest
	public static void testGrouping() {
		List<Account> accounts = testData();
		Map<Object, List<SObject>> accountsByName = Lists.groupBy(accounts, Account.Name);
		System.assertEquals(2, accountsByName.size());
		System.assert(accountsByName.keySet().contains('Foo'));
		System.assert(accountsByName.keySet().contains('Bar'));
		System.assertEquals(2, accountsByName.get('Foo').size());
		System.assertEquals(2, accountsByName.get('Bar').size());
		List<Account> fooAccounts = accountsByName.get('Foo');
		for (Account a : fooAccounts) {
			System.assertEquals('Foo', a.Name);
		}
		List<Account> barAccounts = accountsByName.get('Bar');
		for (Account a : barAccounts) {
			System.assertEquals('Bar', a.Name);
		}
	}
}